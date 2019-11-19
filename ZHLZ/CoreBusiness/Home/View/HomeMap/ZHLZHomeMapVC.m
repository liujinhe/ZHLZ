//
//  ZHLZHomeMapVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeMapVC.h"
#import "ZHLZHomeMapVM.h"
#import "ZHLZHomeMapModel.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

static NSString * const PointReuseIndetifier = @"pointReuseIndetifier";

@interface ZHLZHomeMapVC () <MAMapViewDelegate, AMapLocationManagerDelegate, AMapSearchDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapDistrictSearchRequest *dist;

@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation ZHLZHomeMapVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configMapView];
    
    [self configLocationManager];
    
    [self configSearch];
    
    [self loadHomeMapData];
}

- (void)configMapView {
    [AMapServices sharedServices].apiKey = AMapKeyConst;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
}

- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    
    [self.locationManager startUpdatingLocation];
}

- (void)configSearch {
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.dist = [[AMapDistrictSearchRequest alloc] init];
    self.dist.requireExtension = YES;
    [self.search AMapDistrictSearch:self.dist];
}

- (void)loadHomeMapData {
    @weakify(self);
    self.task = [[ZHLZHomeMapVM sharedInstance] loadHomeMapDataWithBlock:^(NSArray<ZHLZHomeMapModel *> * _Nonnull homeMapArray) {
        @strongify(self);
        
        self.annotations = @[].mutableCopy;
        for (ZHLZHomeMapModel *homeMapModel in homeMapArray) {
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(homeMapModel.lonY.doubleValue,
                                                                    homeMapModel.latX.doubleValue);
            pointAnnotation.lockedToScreen = YES;
            pointAnnotation.title = homeMapModel.problemDet?:@"";
            [self.annotations addObject:pointAnnotation];
            
            [self.mapView addAnnotations:self.annotations];
            [self.mapView showAnnotations:self.annotations edgePadding:UIEdgeInsetsMake(20, 20, 20, 80) animated:YES];
        }
    }];
}

#pragma mark - MAMapViewDelegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:PointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:PointReuseIndetifier];
        }
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor = [self.annotations indexOfObject:annotation] % 3;
        return annotationView;
    }
    return nil;
}

#pragma mark - AMapLocationManagerDelegate

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager {
    
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location {
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
}

#pragma mark - AMapSearchDelegate

- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response {
    if (response == nil) {
        return;
    }
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error.localizedDescription);
}

@end
