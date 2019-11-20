//
//  ZHLZHomeScanCodeUseCarVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeScanCodeUseCarVC.h"
#import <CoreLocation/CoreLocation.h>

@interface ZHLZHomeScanCodeUseCarVC ()<CLLocationManagerDelegate>
{
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}

@property (weak, nonatomic) IBOutlet UILabel *currentUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCardLabel;

@property (weak, nonatomic) IBOutlet UIView *userCarView;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@property (weak, nonatomic) IBOutlet UILabel *currentLocation;

@property(nonatomic,strong)CLLocationManager *locationmanager;

@end

@implementation ZHLZHomeScanCodeUseCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scanCodeUseCarView];
}

-(void)userCarAction:(id)tap{


}
- (void)scanCodeUseCarView{
    self.userCarView.layer.cornerRadius = 60;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userCarAction:)];
    [self.userCarView addGestureRecognizer:tapGesturRecognizer];
    
    [self startLocating];
}

-(void)startLocating{
    
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationmanager = [[CLLocationManager alloc]init];
        self.locationmanager.delegate = self;
        [self.locationmanager requestAlwaysAuthorization];
        [self.locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        self.locationmanager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationmanager.distanceFilter = 5.0;
        [self.locationmanager startUpdatingLocation];
    }
}

/* 定位完成后 回调 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self.locationmanager stopUpdatingHeading];
        //旧址
        CLLocation *currentLocation = [locations lastObject];
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        //打印当前的经度与纬度
        NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
        
        //反地理编码
        [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count > 0) {
                CLPlacemark *placeMark = placemarks[0];
                currentCity = placeMark.locality;
                if (!currentCity) {
                    currentCity = @"无法定位当前城市";
                }
                
                /*看需求定义一个全局变量来接收赋值*/
                NSLog(@"----%@",placeMark.country);//当前国家
                NSLog(@"%@",currentCity);//当前的城市
    //            NSLog(@"%@",placeMark.subLocality);//当前的位置
    //            NSLog(@"%@",placeMark.thoroughfare);//当前街道
    //            NSLog(@"%@",placeMark.name);//具体地址
                
            }
        }];
}

/* 定位失败后 回调 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    //设置提示提醒用户打开定位服务
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
       
}



@end
