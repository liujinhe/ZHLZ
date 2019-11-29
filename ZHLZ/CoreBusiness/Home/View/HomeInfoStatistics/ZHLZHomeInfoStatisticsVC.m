//
//  ZHLZHomeInfoStatisticsVC.m
//  ZHLZ
//
//  Created by liujinhe on 2019/11/18.
//  Copyright © 2019 liujinhe. All rights reserved.
//

#import "ZHLZHomeInfoStatisticsVC.h"
#import "ZHLZHomeInfoStatisticsListVC.h"

@interface ZHLZHomeInfoStatisticsVC () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (weak, nonatomic) IBOutlet JXCategoryTitleView *titleView;
@property (weak, nonatomic) IBOutlet UIView *listView;

@property (nonatomic, strong) JXCategoryIndicatorBackgroundView *indicatorBackgroundView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation ZHLZHomeInfoStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView.delegate = self;
    self.titleView.titleFont = kFont(16);
    self.titleView.titleSelectedFont = kFont(16);
    self.titleView.titleColor = kHexRGB(0x666666);
    self.titleView.titleSelectedColor = UIColor.whiteColor;
    self.titleView.titleColorGradientEnabled = NO;
    self.titleView.titleLabelMaskEnabled = YES;
    self.titleView.defaultSelectedIndex = 0;
    
    self.titleView.titles = @[@"日", @"周", @"月", @"季度"];
    self.titleView.indicators = @[[self indicatorBackgroundView]];
    self.titleView.contentScrollView = [self listContainerView].scrollView;
    
    [self.titleView reloadData];
    [self.listContainerView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [_listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index {
    [_listContainerView.scrollView setContentOffset:CGPointMake(index * kScreenWidth, 0) animated:NO];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [_listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {

}

#pragma mark - JXCategoryListContainerViewDelegate

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titleView.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    ZHLZHomeInfoStatisticsListVC *homeInfoStatisticsListVC = [ZHLZHomeInfoStatisticsListVC new];
    homeInfoStatisticsListVC.type = index;
    return homeInfoStatisticsListVC;
}

#pragma mark - setter and getter

- (JXCategoryIndicatorBackgroundView *)indicatorBackgroundView {
    if (_indicatorBackgroundView) {
        return _indicatorBackgroundView;
    }
    _indicatorBackgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    _indicatorBackgroundView.indicatorWidthIncrement = 10;
    _indicatorBackgroundView.indicatorWidth = 45;
    _indicatorBackgroundView.indicatorHeight = 30;
    _indicatorBackgroundView.indicatorColor = kThemeColor;
    return _indicatorBackgroundView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView) {
        return _listContainerView;
    }
    _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    _listContainerView.initListPercent = 0.1;
    _listContainerView.defaultSelectedIndex = 0;
    [self.listView addSubview:_listContainerView];
    [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.listView);
    }];
    return _listContainerView;
}

@end
