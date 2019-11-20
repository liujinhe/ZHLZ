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

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

static NSString * const PointReuseIndetifier = @"pointReuseIndetifier";

@interface ZHLZHomeMapVC () <MAMapViewDelegate, AMapSearchDelegate>
{
    MACoordinateRegion _limitRegion;
    MAMapRect _limitMapRect;
}

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapDistrictSearchRequest *dist;

@property (nonatomic, strong) NSMutableArray<MAPointAnnotation *> *annotationArray;

@end

@implementation ZHLZHomeMapVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configMapView];
    
    [self configSearch];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mapView.limitRegion = _limitRegion;
    self.mapView.limitMapRect = _limitMapRect;
    self.mapView.visibleMapRect = _limitMapRect;
    
    [self loadHomeMapData];
}

- (void)configMapView {
    CLLocationCoordinate2D defaultLocationCoordinate = CLLocationCoordinate2DMake(AMapDefaultLatitudeConst, AMapDefaultLongitudeConst);
    
    // 限制地图的显示范围
    _limitRegion = MACoordinateRegionMake(defaultLocationCoordinate, MACoordinateSpanMake(2, 2));
    _limitMapRect = MAMapRectForCoordinateRegion(_limitRegion);
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.frame];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsCompass = YES;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.centerCoordinate = defaultLocationCoordinate;
    [self.view addSubview:self.mapView];
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
        
        if (self.annotationArray && self.annotationArray.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView removeAnnotations:self.annotationArray];
            });
        }
        self.annotationArray = @[].mutableCopy;
        for (ZHLZHomeMapModel *homeMapModel in homeMapArray) {
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(homeMapModel.lonY, homeMapModel.latX);
            pointAnnotation.title = homeMapModel.problemType?:@"";
            pointAnnotation.subtitle = homeMapModel.problemDet?:@"";
            [self.annotationArray addObject:pointAnnotation];
        }
        if (self.annotationArray && self.annotationArray.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView addAnnotations:self.annotationArray];
            });
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
        annotationView.image = [UIImage imageNamed:@"luqiao_green"];
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -8);
        return annotationView;
    }
    return nil;
}

#pragma mark - AMapSearchDelegate

//- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response {
//    if (response == nil) {
//        return;
//    }
//}
//
//- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
//    NSLog(@"Error: %@", error.localizedDescription);
//}

@end
