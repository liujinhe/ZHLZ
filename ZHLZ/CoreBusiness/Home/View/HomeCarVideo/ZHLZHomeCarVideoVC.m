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

// 当前所有设备
#define kAllDevice @[@"10001", @"10004", @"10005", @"10006", @"10007", @"100011"]

// 账号
static NSString * const Account = @"admin";
// 密码
static NSString * const Pwd = @"admin";

@interface ZHLZHomeCarVideoVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSString *_session;         // 会话号
    NSString *_deviceId;        // 设备 ID
    int _channel;               // 通道
    int _codeStream;            // 码流
    NSString *_deviceName;      // 设备名称
    NSString *_channelName;     // 通道名称
}
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *onlineButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) TTXRealVideoView *realVideoView;

@property (nonatomic, strong) TTXTalkback *talkback;

@property (nonatomic, strong) NSArray<ZHLZVehicleInfoModel *> *vehicleInfoArray;
@property (nonatomic, strong) NSArray<ZHLZDeviceStatusModel *> *deviceStatusArray;

@end

@implementation ZHLZHomeCarVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:CellReuseIdentifier bundle:nil] forCellReuseIdentifier:CellReuseIdentifier];
    
//    [[TTXSDKPrepare prepare] initializationSDK];
//    [[TTXSDKPrepare prepare] setServer:BaseAPICarVideoIPConst lanIP:BaseAPICarVideoIPConst port:BaseAPICarVideoPortConst];
//
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapoutAction)]];
//
//    self.realVideoView = [[TTXRealVideoView alloc] init];
//    [self.realVideoView setViewInfo:_deviceId chn:_channel mode:_codeStream];
//    [self.realVideoView setTitleInfo:_deviceName chName:_channelName];
//    [self.realVideoView setLanInfo:BaseAPICarVideoIPConst port:BaseAPICarVideoPortConst];
//    [self.view addSubview:self.realVideoView];
//    [self.realVideoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(10);
//        make.right.equalTo(self.view).offset(-10);
//        make.height.equalTo(self.realVideoView.mas_width);
//        make.centerY.equalTo(self.view);
//    }];
//
//    self.talkback = [[TTXTalkback alloc] init];
    
    [self sessionLoginAction];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self sessionLoginAction];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self sessionLogoutAction];
}

#pragma mark - Load Data

- (void)sessionLoginAction {
    @weakify(self);
    self.task = [[ZHLZHomeCarVideoVM sharedInstance] sessionLoginWithAccount:Account withPwd:Pwd withBlock:^(NSString * _Nonnull session) {
        @strongify(self);
        self->_session = session;
        
        [self getDeviceStatus];
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
    for (NSString *deviceId in kAllDevice) {
        deviceIdStr = [deviceIdStr stringByAppendingString:[NSString stringWithFormat:@"%@,", deviceId]];
    }
    deviceIdStr = [deviceIdStr substringToIndex:(deviceIdStr.length - 1)];
    self.task = [[ZHLZHomeCarVideoVM sharedInstance] getDeviceStatusWithDeviceId:deviceIdStr withPlateNo:nil withBlock:^(NSArray<ZHLZDeviceStatusModel *> * _Nonnull array) {
        @strongify(self);
        self.deviceStatusArray = array;
        
        [self.tableView reloadData];
    }];
}

- (void)getCarInfoAction {
    if ([_session isNotBlank]) {
        @weakify(self);
        self.task = [[ZHLZHomeCarVideoVM sharedInstance] getVehicleInfoWithSession:_session withBlock:^(NSArray<ZHLZVehicleInfoModel *> * _Nonnull array) {
            @strongify(self);
            self.vehicleInfoArray = array;
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
}

- (void)tapoutAction {
    
}

- (void)showVideo {
    if (self.realVideoView.isViewing) {
        [self.realVideoView StopAV];
    } else {
        [self.realVideoView StartAV];
    }
    
    if (self.talkback.isTalkback) {
        [self.talkback stopTalkback];
    } else {
        [self.talkback startTalkback:_deviceId];
    }
}

@end
