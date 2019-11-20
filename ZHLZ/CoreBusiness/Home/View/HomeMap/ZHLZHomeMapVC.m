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

@property (nonatomic, strong) UIButton *gpsButton;

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
    _limitRegion = MACoordinateRegionMake(defaultLocationCoordinate, MACoordinateSpanMake(1, 1));
    _limitMapRect = MAMapRectForCoordinateRegion(_limitRegion);
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsCompass = YES;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    self.mapView.centerCoordinate = defaultLocationCoordinate;
    [self.view addSubview:self.mapView];
    
    self.gpsButton = [self makeGPSButtonView];
    self.gpsButton.center = CGPointMake(CGRectGetMidX(self.gpsButton.bounds) + 10,
                                        CGRectGetHeight(self.view.bounds) - CGRectGetMidY(self.gpsButton.bounds) - 30);
    [self.view addSubview:self.gpsButton];
    self.gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    
    UIView *zoomPannelView = [self makeZoomPannelView];
    zoomPannelView.center = CGPointMake(CGRectGetWidth(self.view.bounds) -  CGRectGetMidX(zoomPannelView.bounds) - 10,
                                        CGRectGetHeight(self.view.bounds) - CGRectGetMidY(zoomPannelView.bounds) - 10);
    zoomPannelView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:zoomPannelView];
}

- (UIButton *)makeGPSButtonView {
    UIButton *ret = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ret.backgroundColor = [UIColor whiteColor];
    ret.layer.cornerRadius = 4;
    
    [ret setImage:[UIImage imageNamed:@"icon_map_gps"] forState:UIControlStateNormal];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return ret;
}

- (UIView *)makeZoomPannelView {
    UIView *ret = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 98)];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"icon_map_increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"icon_map_decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    
    return ret;
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

#pragma mark - Action

- (void)gpsAction {
    if (self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsButton setSelected:YES];
    }
}

- (void)zoomPlusAction {
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
    self.mapView.showsScale = YES;
}

- (void)zoomMinusAction {
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
    self.mapView.showsScale = NO;
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
        annotationView.image = [UIImage imageNamed:@"dianli_green_1"];
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
