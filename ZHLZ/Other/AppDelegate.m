//
//  AppDelegate.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/11.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+Category.h"

#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCurrentLocation) name:RegetLocationNotificationConst object:nil];
    
    [self initAppLaunch];
    
    [self getCurrentLocation];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    self.frostedGlassMaskView.hidden = YES;
    
    [self getCurrentLocation];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    self.frostedGlassMaskView.hidden = NO;
}

- (void)getCurrentLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    } else {
        [GRToast makeText:@"定位功能在未启用，请前往“设置-隐私-定位服务-智慧路政”来启用定位"];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"=========: %@", error.localizedDescription);
        } else {
            if (placemarks && placemarks.count > 0) {
                CLPlacemark *placemark = [placemarks firstObject];
                if (placemark && placemark.addressDictionary) {
                    // 当前位置信息
                    NSString *province = [placemark.addressDictionary objectForKey:@"State"];
                    NSString *city = [placemark.addressDictionary objectForKey:@"City"];
                    NSString *district = [placemark.addressDictionary objectForKey:@"SubLocality"];
                    NSString *street = [placemark.addressDictionary objectForKey:@"Street"];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@%@%@%@", province, city, district, street] forKey:CurrentLocationAddressConst];
                    [[NSNotificationCenter defaultCenter] postNotificationName:ReloadCurrentLocationInfoConst object:nil];
                    
                    // 当前位置坐标
                    CLLocationCoordinate2D coordinate = location.coordinate;
                    [[NSUserDefaults standardUserDefaults] setObject:@{@"longitude":@(coordinate.longitude), @"latitude":@(coordinate.latitude)} forKey:CurrentLocationCoordinateConst];
                    return;
                }
            }
        }
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:CurrentLocationAddressConst];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:CurrentLocationCoordinateConst];
    }];
    
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [GRToast makeText:@"定位失败，请重新打开App"];
}

#pragma mark - setter and getter

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters]; // 设置定位精度
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}

@end
