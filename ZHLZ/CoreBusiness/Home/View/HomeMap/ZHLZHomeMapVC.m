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
#import "ZHLZHomeMapProblemModel.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "ZHLZHomeMapSearchVC.h"
#import "ZHLZHomeBuildProjectDetailVC.h"
#import "ZHLZHomeMunicipalProblemDetailVC.h"

#import "ZHLZHomeMapCustomAnnotationView.h"

static NSString * const PointReuseIndetifier = @"pointReuseIndetifier";

static CGFloat const CalloutViewMargin = -10;

#define ZHLZHomeMapCustomAnnotationViewReuseIndetifier NSStringFromClass([ZHLZHomeMapCustomAnnotationView class])

@interface ZHLZHomeMapVC () <MAMapViewDelegate>
{
    MACoordinateRegion _limitRegion;
    MAMapRect _limitMapRect;
    
    NSString *_projectName;
    NSString *_bid;
    NSString *_projecttypeId;
    
    NSInteger _picLayerIndex;
    NSInteger _colorIndex;
}

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) ZHLZHomeMapSearchVC *homeMapSearchVC;

@property (nonatomic, strong) UIButton *gpsButton;

@property (nonatomic, strong) NSMutableArray<ZHLZHomeMapModel *> *homeMapArray;
@property (nonatomic, strong) NSMutableArray<ZHLZHomeMapProblemModel *> *homeMapProblemArray;
@property (nonatomic, strong) NSMutableArray<MAPointAnnotation *> *annotationArray;
@property (nonatomic, strong) NSMutableArray<UIImage *> *imgArray;

@end

@implementation ZHLZHomeMapVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configMapView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.mapView.limitRegion = _limitRegion;
    self.mapView.limitMapRect = _limitMapRect;
    self.mapView.visibleMapRect = _limitMapRect;
    
    [self loadHomeMapData];
}

- (void)dealloc {
    if (self.mapView) {
        self.mapView.showsUserLocation = NO;
        self.mapView.delegate = nil;
    }
}

- (void)configMapView {
    @weakify(self);
    ZHLZUserModel *userModel = [ZHLZUserManager sharedInstance].user;
    if (userModel && [userModel.userId isNotBlank] && userModel.userId.integerValue != 1) {
        _bid = userModel.orgId;
    }
    
    [self addRightBarButtonItemWithImageName:@"icon_search_light" action:@selector(searchAction)];
    
    self.homeMapSearchVC = [ZHLZHomeMapSearchVC new];
    self.homeMapSearchVC.selectSearchBlock = ^(NSString * _Nonnull projectName, NSString * _Nonnull bid, NSString * _Nonnull projecttypeId, NSInteger picLayerIndex, NSInteger colorIndex) {
        @strongify(self);
        self->_projectName = projectName;
        self->_bid = bid;
        self->_projecttypeId = projecttypeId;
        
        self->_picLayerIndex = picLayerIndex;
        self->_colorIndex = colorIndex;
        
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
    self.gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    self.gpsButton.center = CGPointMake(CGRectGetMidX(self.gpsButton.bounds) + 10,
                                        CGRectGetHeight(self.view.bounds) - CGRectGetMidY(self.gpsButton.bounds) - 30);
    [self.view addSubview:self.gpsButton];
    
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

- (void)loadHomeMapData {
    @weakify(self);
    self.task = [[ZHLZHomeMapVM sharedInstance] loadHomeMapDataWithpicLayer:_picLayerIndex withName:_projectName withBid:_bid withProjecttypeId:_projecttypeId withBlock:^(NSArray<ZHLZHomeMapModel *> * _Nonnull homeMapArray, NSArray<ZHLZHomeMapProblemModel *> * _Nonnull homeMapProblemArray) {
        @strongify(self);
        self.homeMapArray = @[].mutableCopy;
        self.homeMapProblemArray = @[].mutableCopy;
        
        if (self.annotationArray && self.annotationArray.count > 0) {
            [self.mapView removeAnnotations:self.annotationArray];
        }
        self.annotationArray = @[].mutableCopy;
        self.imgArray = @[].mutableCopy;
        if (self->_picLayerIndex == 1) {
            for (ZHLZHomeMapProblemModel *homeMapProblemModel in homeMapProblemArray) {
                if (homeMapProblemModel.latX > 0 &&
                    homeMapProblemModel.lonY > 0 &&
                    (self->_colorIndex == 0 || (
                                                [homeMapProblemModel.problemStatus isNotBlank] && self->_colorIndex == homeMapProblemModel.problemStatus.integerValue))) {
                    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                    pointAnnotation.coordinate = CLLocationCoordinate2DMake(homeMapProblemModel.lonY, homeMapProblemModel.latX);
                    [self.annotationArray addObject:pointAnnotation];
                    // 问题状态（1-正在处理 2-已解决 3-处理跟踪情况）
                    NSString *imgName;
                    if ([homeMapProblemModel.problemStatus isEqualToString:@"2"]) {
                        imgName = @"marker_green.png";
                    } else {
                        imgName = @"marker_red.png";
                    }
                    [self.imgArray addObject:[UIImage imageNamed:imgName]];
                    [self.homeMapProblemArray addObject:homeMapProblemModel];
                }
            }
        } else {
            for (ZHLZHomeMapModel *homeMapModel in homeMapArray) {
                if (homeMapModel.coordinatesX > 0 && homeMapModel.coordinatesY > 0) {
                    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                    pointAnnotation.coordinate = CLLocationCoordinate2DMake(homeMapModel.coordinatesY, homeMapModel.coordinatesX);
                    [self.annotationArray addObject:pointAnnotation];
                    
                    NSString *imgName = [self getImageNameWithProjecttypeId:homeMapModel.projecttypeId
                                                                withFocuson:homeMapModel.focuson
                                                             withFinishdate:homeMapModel.finishdate.time
                                                                 withPronum:homeMapModel.pronum];
                    [self.imgArray addObject:[UIImage imageNamed:imgName]];
                    [self.homeMapArray addObject:homeMapModel];
                }
            }
        }
        
        if (self.annotationArray && self.annotationArray.count > 0) {
            [self.mapView addAnnotations:self.annotationArray];
            [self.mapView reloadMap];
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
    return [NSString stringWithFormat:@"%@_%@_%@.png", projecttype, color, tag];
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
    @weakify(self);
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        ZHLZHomeMapCustomAnnotationView *annotationView = (ZHLZHomeMapCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:PointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[ZHLZHomeMapCustomAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:PointReuseIndetifier];
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -7.5);
        }
        NSUInteger index = [self.annotationArray indexOfObject:annotation];
        annotationView.image = self.imgArray[index];
        if (self->_picLayerIndex == 1) {
            annotationView.homeMapProblemModel = self.homeMapProblemArray[index];
            annotationView.selectHomeMapProblemBlock = ^(NSString * _Nonnull detailId) {
                @strongify(self);
                ZHLZHomeMunicipalProblemDetailVC *homeMunicipalProblemDetailVC = [ZHLZHomeMunicipalProblemDetailVC new];
                homeMunicipalProblemDetailVC.detailId = detailId;
                homeMunicipalProblemDetailVC.type = 2;
                [self.navigationController pushViewController:homeMunicipalProblemDetailVC animated:YES];
            };
        } else {
            annotationView.homeMapModel = self.homeMapArray[index];
            annotationView.selectHomeMapBlock = ^(NSString * _Nonnull detailId) {
                @strongify(self);
                ZHLZHomeBuildProjectDetailVC *homeBuildProjectDetailVC = [ZHLZHomeBuildProjectDetailVC new];
                homeBuildProjectDetailVC.detailId = detailId;
                homeBuildProjectDetailVC.detailType = 2;
                [self.navigationController pushViewController:homeBuildProjectDetailVC animated:YES];
            };
        }
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if ([view isKindOfClass:[ZHLZHomeMapCustomAnnotationView class]]) {
        ZHLZHomeMapCustomAnnotationView *annotationView = (ZHLZHomeMapCustomAnnotationView *)view;
        CGRect rect = [annotationView convertRect:annotationView.calloutView.frame toView:self.mapView];
        rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(CalloutViewMargin, CalloutViewMargin, CalloutViewMargin, CalloutViewMargin));
        if (!CGRectContainsRect(self.mapView.frame, rect)) {
            CGSize offset = [self offsetToContainRect:rect inRect:self.mapView.frame];
            CGPoint theCenter = self.mapView.center;
            theCenter = CGPointMake(theCenter.x - offset.width, theCenter.y - offset.height);
            CLLocationCoordinate2D coordinate = [self.mapView convertPoint:theCenter toCoordinateFromView:self.mapView];
            [self.mapView setCenterCoordinate:coordinate animated:YES];
        }
    }
}

- (CGSize)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect {
    CGFloat nudgeRight = fmaxf(0, CGRectGetMinX(outerRect) - (CGRectGetMinX(innerRect)));
    CGFloat nudgeLeft = fminf(0, CGRectGetMaxX(outerRect) - (CGRectGetMaxX(innerRect)));
    CGFloat nudgeTop = fmaxf(0, CGRectGetMinY(outerRect) - (CGRectGetMinY(innerRect)));
    CGFloat nudgeBottom = fminf(0, CGRectGetMaxY(outerRect) - (CGRectGetMaxY(innerRect)));
    return CGSizeMake(nudgeLeft ?: nudgeRight, nudgeTop ?: nudgeBottom);
}

@end
