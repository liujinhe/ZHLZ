//
//  ZHLZHomeCarVideoVC.m
//  ZHLZ
//
//  Created by apple on 2019/12/9.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeCarVideoVC.h"
#import "ZHLZHomeCarVideoVM.h"
#import "ZHLZHomeCarVideoTableViewCell.h"

#import <TTXSDK/TTXSDKPrepare.h>
#import <TTXSDK/TTXRealVideoView.h>
#import <TTXSDK/TTXTalkback.h>

#define CellReuseIdentifier NSStringFromClass([ZHLZHomeCarVideoTableViewCell class])

// 账号
static NSString * const Account = @"admin";
// 密码
static NSString * const Pwd = @"admin";

@interface ZHLZHomeCarVideoVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_session;         // 会话号
    NSString *_deviceId;        // 设备 ID
}
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *onlineButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) TTXRealVideoView *realVideoView;
@property (nonatomic, strong) TTXTalkback *talkback;

@property (nonatomic, strong) NSMutableArray<ZHLZVehicleInfoModel *> *vehicleInfoArray;
@property (nonatomic, strong) NSMutableArray<ZHLZDeviceStatusModel *> *deviceStatusArray;
@property (nonatomic, strong) NSMutableArray<ZHLZDeviceStatusModel *> *onlineDeviceStatusArray;

@end

@implementation ZHLZHomeCarVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self sessionLoginAction];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self sessionLogoutAction];
}

- (void)dealloc {
    if (self.realVideoView) {
        self.realVideoView = nil;
    }
    if (self.talkback) {
        self.talkback = nil;
    }
}

- (void)initUI {
    self.maskView = [UIView new];
    self.maskView.backgroundColor = kHexRGBAlpha(0x000000, 0.5);
    self.maskView.hidden = YES;
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoAction)]];
    [self.view addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [[TTXSDKPrepare prepare] initializationSDK];
    [[TTXSDKPrepare prepare] setServer:BaseAPICarVideoIPConst lanIP:BaseAPICarVideoIPConst port:BaseAPICarVideoPortConst];

    self.realVideoView = [[TTXRealVideoView alloc] init];
    self.realVideoView.hidden = YES;
    [self.realVideoView setLanInfo:BaseAPICarVideoIPConst port:BaseAPICarVideoPortConst];
    [self.view addSubview:self.realVideoView];
    [self.realVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(self.realVideoView.mas_width);
        make.centerY.equalTo(self.view);
    }];
    
    self.talkback = [[TTXTalkback alloc] init];
    
    self.vehicleInfoArray = @[].mutableCopy;
    self.deviceStatusArray = @[].mutableCopy;
    self.onlineDeviceStatusArray = @[].mutableCopy;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:CellReuseIdentifier bundle:nil] forCellReuseIdentifier:CellReuseIdentifier];
    
    [self sessionLoginAction];
}

#pragma mark - Load Data

- (void)sessionLoginAction {
    @weakify(self);
    self.task = [[ZHLZHomeCarVideoVM sharedInstance] sessionLoginWithAccount:Account withPwd:Pwd withBlock:^(NSString * _Nonnull session) {
        @strongify(self);
        self->_session = session;
        
        [[TTXSDKPrepare prepare] setJsession:self->_session];
        [[TTXSDKPrepare prepare] setServer:BaseAPICarVideoIPConst lanIP:BaseAPICarVideoIPConst port:BaseAPICarVideoLoginAfterPortConst];
        
        [self getCarInfoAction];
    }];
}

- (void)sessionLogoutAction {
    if ([_session isNotBlank]) {
        self.task = [[ZHLZHomeCarVideoVM sharedInstance] sessionLogoutWithSession:_session];
    }
}

- (void)getDeviceStatus {
    @weakify(self);
    NSString *deviceIdStr = @"";
    for (ZHLZVehicleInfoModel *model in self.vehicleInfoArray) {
        deviceIdStr = [deviceIdStr stringByAppendingString:[NSString stringWithFormat:@"%@,", model.dl.firstObject.objectID]];
    }
    deviceIdStr = [deviceIdStr substringToIndex:(deviceIdStr.length - 1)];
    self.task = [[ZHLZHomeCarVideoVM sharedInstance] getDeviceStatusWithSession:_session withDeviceId:deviceIdStr withPlateNo:nil withBlock:^(NSArray<ZHLZDeviceStatusModel *> * _Nonnull array) {
        @strongify(self);
        [self.deviceStatusArray removeAllObjects];
        [self.onlineDeviceStatusArray removeAllObjects];
        for (ZHLZDeviceStatusModel *model in array) {
            for (ZHLZVehicleInfoModel *vehicleInfoModel in self.vehicleInfoArray) {
                ZHLZVehicleInfoDeviceModel *vehicleInfoDeviceModel = vehicleInfoModel.dl.firstObject;
                if ([model.did isEqualToString:vehicleInfoDeviceModel.objectID]) {
                    model.brigade = vehicleInfoModel.nm;
                    model.channel = vehicleInfoDeviceModel.cc;
                    model.codeStream = vehicleInfoDeviceModel.md;
                    model.deviceName = vehicleInfoModel.nm;
                    model.channelName = vehicleInfoDeviceModel.cn;
                    break;
                }
            }
            [self.deviceStatusArray addObject:model];
            
            if (model.online == 1) {
                [self.onlineDeviceStatusArray addObject:model];
            }
        }
        
        [self.tableView reloadData];
    }];
}

- (void)getCarInfoAction {
    if ([_session isNotBlank]) {
        @weakify(self);
        self.task = [[ZHLZHomeCarVideoVM sharedInstance] getVehicleInfoWithSession:_session withBlock:^(NSArray<ZHLZVehicleInfoModel *> * _Nonnull array) {
            @strongify(self);
            [self.vehicleInfoArray removeAllObjects];
            for (ZHLZVehicleInfoModel *model in array) {
                if (model && model.pid == 2) {
                    [self.vehicleInfoArray addObject:model];
                }
            }
            if (self.vehicleInfoArray && self.vehicleInfoArray.count > 0) {
                [self getDeviceStatus];
            }
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Action

/// 所有
/// @param sender sender description
- (IBAction)allAction:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    self.onlineButton.selected = NO;
    self.onlineButton.backgroundColor = UIColor.systemGrayColor;
    sender.selected = YES;
    sender.backgroundColor = UIColor.systemBlueColor;
    
    [self.tableView reloadData];
}

/// 在线
/// @param sender sender description
- (IBAction)onlineAction:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    self.allButton.selected = NO;
    self.allButton.backgroundColor = UIColor.systemGrayColor;
    sender.selected = YES;
    sender.backgroundColor = UIColor.systemBlueColor;
    
    [self.tableView reloadData];
}

- (void)showVideoAction {
    if (self.realVideoView.isViewing) {
        self.maskView.hidden = YES;
        self.realVideoView.hidden = YES;
        [self.realVideoView StopAV];
    } else {
        self.maskView.hidden = NO;
        self.realVideoView.hidden = NO;
        [self.realVideoView StartAV];
    }
    
    if (self.realVideoView.isSounding) {
        [self.realVideoView stopSound];
    } else {
        [self.realVideoView playSound];
    }
    
    if (self.talkback.isTalkback) {
        [self.talkback stopTalkback];
    } else {
        [self.talkback startTalkback:_deviceId];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.onlineButton.isSelected) {
        return self.onlineDeviceStatusArray.count;
    } else {
        return self.deviceStatusArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onlineButton.isSelected) {
        ZHLZHomeCarVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
        if (cell) {
            cell.deviceStatusModel = self.onlineDeviceStatusArray[indexPath.row];
        }
        return cell;
    } else {
        ZHLZHomeCarVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier forIndexPath:indexPath];
        if (cell) {
            cell.deviceStatusModel = self.deviceStatusArray[indexPath.row];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZHLZDeviceStatusModel *model = self.onlineButton.isSelected ? self.onlineDeviceStatusArray[indexPath.row] : self.deviceStatusArray[indexPath.row];
    if (model) {
        _deviceId = model.did;
        
        [self.realVideoView setViewInfo:_deviceId
                                    chn:model.channel
                                   mode:model.codeStream];
        [self.realVideoView setTitleInfo:model.deviceName
                                  chName:model.channelName];
        [self.realVideoView setLanInfo:BaseAPICarVideoIPConst
                                  port:BaseAPICarVideoLivePortConst];
        
        [self showVideoAction];
    }
}

@end
