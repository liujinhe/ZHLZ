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
    ZHLZDeviceStatusModel *_deviceStatusModel;
    TTXRealVideoView *_realVideoView;
    TTXTalkback *_talkback;
}
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *onlineButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (weak, nonatomic) IBOutlet UIButton *startOrStopVidioButton;
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
    if (_realVideoView) {
        if (_realVideoView.isViewing) {
            [_realVideoView StopAV];
        }
        
        if (_realVideoView.isRecording) {
            [_realVideoView stopRecord];
        }
        
        if (_realVideoView.isSounding) {
            [_realVideoView stopSound];
        }
        
        _realVideoView = nil;
    }
    
    if (_talkback) {
        if (_talkback.isTalkback) {
            [_talkback stopTalkback];
        }
        
        _talkback = nil;
    }
}

- (void)initUI {
    [self.maskView addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(showVidioView)]];
    
    [[TTXSDKPrepare prepare] initializationSDK];
    
    CGFloat realVideoViewWH = kScreenWidth - 15.f * 2;
    _realVideoView = [[TTXRealVideoView alloc] init];
    _realVideoView.frame = CGRectMake(0, 0, realVideoViewWH, realVideoViewWH);
    [self.videoView addSubview:_realVideoView];
    
    _talkback = [[TTXTalkback alloc] init];
    
    self.vehicleInfoArray = @[].mutableCopy;
    self.deviceStatusArray = @[].mutableCopy;
    self.onlineDeviceStatusArray = @[].mutableCopy;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:CellReuseIdentifier bundle:nil]
         forCellReuseIdentifier:CellReuseIdentifier];
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
        [[TTXSDKPrepare prepare] setServer:BaseAPICarVideoIPConst lanIP:BaseAPICarVideoIPConst port:BaseAPICarVideoLoginAfterPortConst];
        
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

/// 开启或关闭视频
/// @param sender sender description
- (IBAction)startOrStopVidioAction:(UIButton *)sender {
    if (_realVideoView.isViewing || !_deviceStatusModel) {
        sender.selected = NO;
        [_realVideoView StopAV];
    } else {
        sender.selected = YES;
        
        [_realVideoView setViewInfo:_deviceStatusModel.did
                                chn:_deviceStatusModel.channel
                               mode:_deviceStatusModel.codeStream];
        [_realVideoView setTitleInfo:_deviceStatusModel.deviceName
                              chName:_deviceStatusModel.channelName];
        
        [_realVideoView StartAV];
    }
}

/// 开启或关闭录像
/// @param sender sender description
- (IBAction)startOrStopRecordAction:(UIButton *)sender {
    if (_realVideoView.isRecording) {
        sender.selected = NO;
        [_realVideoView stopRecord];
    } else {
        sender.selected = YES;
        [_realVideoView startRecord];
    }
}

/// 开启或关闭声音
/// @param sender sender description
- (IBAction)startOrStopSoundAction:(UIButton *)sender {
    if (_realVideoView.isSounding) {
        sender.selected = NO;
        [_realVideoView stopSound];
    } else {
        sender.selected = YES;
        [_realVideoView playSound];
    }
}

/// 开启或关闭对讲
/// @param sender sender description
- (IBAction)startOrStopTalkbackAction:(UIButton *)sender {
    if (_talkback.isTalkback || !_deviceStatusModel) {
        sender.selected = NO;
        [_talkback stopTalkback];
    } else {
        sender.selected = YES;
        [_talkback startTalkback:_deviceStatusModel.did];
    }
}

- (void)showVidioView {
    self.maskView.hidden = !self.maskView.isHidden;
    self.showView.hidden = !self.showView.isHidden;
    
    if (self.showView.isHidden) {
        self.startOrStopVidioButton.selected = NO;
        if (_realVideoView.isViewing) {
            [_realVideoView StopAV];
        }
        
        self.startOrStopRecordButton.selected = NO;
        if (_realVideoView.isRecording) {
            [_realVideoView stopRecord];
        }
        
        self.startOrStopSoundButton.selected = NO;
        if (_realVideoView.isSounding) {
            [_realVideoView stopSound];
        }
        
        self.startOrStopTalkbackButton.selected = NO;
        if (_talkback.isTalkback) {
            [_talkback stopTalkback];
        }
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
    _deviceStatusModel = self.onlineButton.isSelected ? self.onlineDeviceStatusArray[indexPath.row] : self.deviceStatusArray[indexPath.row];
    if (_deviceStatusModel) {
        [self showVidioView];
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
