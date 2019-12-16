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

@interface ZHLZHomeCarVideoVC () <UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    NSString *_session;         // 会话号
    NSString *_deviceId;        // 设备 ID
}
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *onlineButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet TTXRealVideoView *realVideoView;
@property (nonatomic, strong) TTXTalkback *talkback;

@property (weak, nonatomic) IBOutlet UIButton *startOrStopRecordButton;
@property (weak, nonatomic) IBOutlet UIButton *startOrStopSoundButton;
@property (weak, nonatomic) IBOutlet UIButton *startOrStopTalkbackButton;

@property (nonatomic, strong) NSMutableArray<ZHLZVehicleInfoModel *> *vehicleInfoArray;
@property (nonatomic, strong) NSMutableArray<ZHLZDeviceStatusModel *> *deviceStatusArray;
@property (nonatomic, strong) NSMutableArray<ZHLZDeviceStatusModel *> *onlineDeviceStatusArray;

@end

@implementation ZHLZHomeCarVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self sessionLoginAction];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self sessionLogoutAction];
}

- (void)dealloc {
    if (self.realVideoView) {
        [self.realVideoView StopAV];
        [self.realVideoView stopSound];
        [self.realVideoView stopRecord];
        
        self.realVideoView = nil;
    }
    
    if (self.talkback) {
        [self.talkback stopTalkback];
        
        self.talkback = nil;
    }
}

- (void)initUI {
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoAction)]];
    
    [[TTXSDKPrepare prepare] initializationSDK];
    
    self.talkback = [[TTXTalkback alloc] init];
    
    self.vehicleInfoArray = @[].mutableCopy;
    self.deviceStatusArray = @[].mutableCopy;
    self.onlineDeviceStatusArray = @[].mutableCopy;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:CellReuseIdentifier bundle:nil] forCellReuseIdentifier:CellReuseIdentifier];
    
    [self sessionLoginAction];
}

#pragma mark - Load Data

- (void)sessionLogoutAction {
    if ([_session isNotBlank]) {
        self.task = [[ZHLZHomeCarVideoVM sharedInstance] sessionLogoutWithSession:_session];
    }
}

- (void)sessionLoginAction {
    @weakify(self);
    [self sessionLogoutAction];
    
    self.task = [[ZHLZHomeCarVideoVM sharedInstance] sessionLoginWithAccount:Account withPwd:Pwd withBlock:^(NSString * _Nonnull session) {
        @strongify(self);
        self->_session = session;
        
        [[TTXSDKPrepare prepare] setJsession:self->_session];
        
        [self getCarInfoAction];
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
            
            [[TTXSDKPrepare prepare] setServer:BaseAPICarVideoIPConst lanIP:BaseAPICarVideoIPConst port:BaseAPICarVideoLoginAfterPortConst];
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
                    model.deviceName = vehicleInfoModel.nm;
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

/// 开启或关闭录像
/// @param sender sender description
- (IBAction)startOrStopRecordAction:(UIButton *)sender {
    if (self.realVideoView.isRecording) {
        [self.realVideoView stopRecord];
        sender.selected = NO;
    } else {
        [self.realVideoView startRecord];
        sender.selected = YES;
    }
}

/// 开启或关闭声音
/// @param sender sender description
- (IBAction)startOrStopSoundAction:(UIButton *)sender {
    if (self.realVideoView.isSounding) {
        [self.realVideoView stopSound];
        sender.selected = NO;
    } else {
        [self.realVideoView playSound];
        sender.selected = YES;
    }
}

/// 开启或关闭对讲
/// @param sender sender description
- (IBAction)startOrStopTalkbackAction:(UIButton *)sender {
    if (self.talkback.isTalkback) {
        [self.talkback stopTalkback];
    } else {
        [self.talkback startTalkback:_deviceId];
    }
}

- (void)showVideoAction {
    if (self.realVideoView.isViewing) {
        self.maskView.hidden = YES;
        self.realVideoView.hidden = YES;
        [self.realVideoView StopAV];
        
        self.startOrStopRecordButton.selected = NO;
        if (self.realVideoView.isRecording) {
            [self.realVideoView stopRecord];
        }
        
        self.startOrStopSoundButton.selected = NO;
        if (self.realVideoView.isSounding) {
            [self.realVideoView stopSound];
        }
        
        self.startOrStopTalkbackButton.selected = NO;
        if (self.talkback.isTalkback) {
            [self.talkback stopTalkback];
        }
    } else {
        self.maskView.hidden = NO;
        self.realVideoView.hidden = NO;
        [self.realVideoView StartAV];
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
        
        [self.realVideoView setViewInfo:model.did
                                    chn:model.channel
                                   mode:model.codeStream];
        [self.realVideoView setTitleInfo:model.deviceName
                                  chName:model.channelName];
        
        [self showVideoAction];
    }
}

#pragma mark - DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return kEmptyDataNoReservationLook;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return [self emptyDataTip:@"~暂无数据哟~"];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self sessionLoginAction];
}

@end
