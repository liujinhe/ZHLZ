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
        
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations firstObject];
    
    // 位置坐标
    CLLocationCoordinate2D coordinate = location.coordinate;
    [[NSUserDefaults standardUserDefaults] setObject:@{@"longitude":@(coordinate.longitude), @"latitude":@(coordinate.latitude)} forKey:CurrentLocationCoordinateConst];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"=========: %@", error.localizedDescription);
            return;
        }
        if (placemarks && placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            if (placemark && placemark.addressDictionary) {
                NSString *province = [placemark.addressDictionary objectForKey:@"State"];
                NSString *city = [placemark.addressDictionary objectForKey:@"City"];
                NSString *district = [placemark.addressDictionary objectForKey:@"SubLocality"];
                NSString *street = [placemark.addressDictionary objectForKey:@"Street"];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@%@%@%@", province, city, district, street] forKey:CurrentLocationAddressConst];
            }
        }
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
