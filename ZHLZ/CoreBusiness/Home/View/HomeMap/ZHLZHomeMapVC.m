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

#import "ZHLZHomeMapSearchVC.h"

static NSString * const PointReuseIndetifier = @"pointReuseIndetifier";

@interface ZHLZHomeMapVC () <MAMapViewDelegate, AMapSearchDelegate>
{
    MACoordinateRegion _limitRegion;
    MAMapRect _limitMapRect;
    
    NSString *_projectName;
    NSString *_bid;
    NSString *_projecttypeId;
}

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapDistrictSearchRequest *dist;

@property (nonatomic, strong) ZHLZHomeMapSearchVC *homeMapSearchVC;

@property (nonatomic, strong) UIButton *gpsButton;

@property (nonatomic, strong) NSArray<ZHLZHomeMapModel *> *homeMapArray;
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
    @weakify(self);
    self.homeMapArray = @[];
    
    [self addRightBarButtonItemWithImageName:@"icon_search_light" action:@selector(searchAction)];
    
    self.homeMapSearchVC = [ZHLZHomeMapSearchVC new];
    self.homeMapSearchVC.selectSearchBlock = ^(NSString * _Nonnull projectName, NSString * _Nonnull bid, NSString * _Nonnull projecttypeId) {
        @strongify(self);
        self->_projectName = projectName;
        self->_bid = bid;
        self->_projecttypeId = projecttypeId;
        
        [self loadHomeMapData];
    };
    
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
    self.task = [[ZHLZHomeMapVM sharedInstance] loadHomeMapDataWithName:_projectName withBid:_bid withProjecttypeId:_projecttypeId withBlock:^(NSArray<ZHLZHomeMapModel *> * _Nonnull homeMapArray) {
        @strongify(self);
        
        if (self.annotationArray && self.annotationArray.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView removeAnnotations:self.annotationArray];
            });
        }
        self.annotationArray = @[].mutableCopy;
        for (ZHLZHomeMapModel *homeMapModel in homeMapArray) {
            if (homeMapModel.coordinatesX > 0 && homeMapModel.coordinatesY > 0) {
                MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(homeMapModel.coordinatesX, homeMapModel.coordinatesY);
                pointAnnotation.title = homeMapModel.typeName?:@"";
                pointAnnotation.subtitle = homeMapModel.name?:@"";
                [self.annotationArray addObject:pointAnnotation];
            }
        }
        if (self.annotationArray && self.annotationArray.count > 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mapView addAnnotations:self.annotationArray];
            });
        }
    }];
}

/// 获取图标
/// @param projecttypeId 工程类型（1-养护及其他 2-电力 3-路桥 4-燃气 5-轨道交通 6-水务 7-园林绿化）
/// @param focuson 是否重点（1-重点  2-非重点）
/// @param finishdate 预计完工时间（0<=day<15）
/// @param pronum 问题数量（大于0：红色，否则：绿色）
- (NSString *)getImageNameWithProjecttypeId:(NSInteger)projecttypeId withFocuson:(NSInteger)focuson withFinishdate:(NSTimeInterval)finishdate withPronum:(NSInteger)pronum {
    NSString *projecttype = @"marker";
    switch (projecttypeId) {
        case 1:
            projecttype = @"yanghu";
            break;
        case 2:
            projecttype = @"dianli";
            break;
        case 3:
            projecttype = @"luqiao";
            break;
        case 4:
            projecttype = @"ranqi";
            break;
        case 5:
            projecttype = @"guidaojiaotong";
            break;
        case 6:
            projecttype = @"shuiwu";
            break;
        case 7:
            projecttype = @"yuanlinlvhua";
            break;
    }
    NSString *color = @"";
    if (pronum == 0) {
        color = @"green";
    } else {
        color = @"red";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:finishdate];
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:date];
    int day = ((int)time) / (3600 * 24);
    if (day < 15 && day >= 0) {
        color = @"yellow";
    }
    NSString *tag = @"";
    if (focuson == 1) {
        tag = @"1";
    } else {
        tag = @"2";
    }
    return [NSString stringWithFormat:@"%@_%@_%@", projecttype, color, tag];
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

- (void)searchAction {
    [self presentViewController:self.homeMapSearchVC animated:NO completion:^{
        [self.homeMapSearchVC showFilterView];
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
        NSUInteger index = [self.annotationArray indexOfObject:annotation];
        ZHLZHomeMapModel *homeMapModel = self.homeMapArray[index];
        if (!homeMapModel) {
            return annotationView;
        }
        NSString *imgName = [self getImageNameWithProjecttypeId:homeMapModel.projecttypeId
                                                    withFocuson:homeMapModel.focuson
                                                 withFinishdate:homeMapModel.finishdate.time
                                                     withPronum:homeMapModel.pronum];
        annotationView.image = [UIImage imageNamed:imgName];
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -7.5);
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
