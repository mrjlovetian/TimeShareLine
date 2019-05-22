//
//  GKListLoadViewController.m
//  GKPageScrollViewObjc
//
//  Created by gaokun on 2019/3/13.
//  Copyright © 2019 gaokun. All rights reserved.
//

#import "GKListLoadViewController.h"
#import "GKPageScrollView.h"
#import "JXCategoryView.h"
#import "JXCategoryListCollectionContainerView.h"
#import "USWebViewController.h"

@interface GKListLoadViewController ()<GKPageScrollViewDelegate>

@property (nonatomic, strong) GKPageScrollView      *pageScrollView;

@property (nonatomic, strong) UIImageView           *headerView;

@property (nonatomic, strong) JXCategoryTitleView   *categoryView;

@property (nonatomic, strong) NSArray               *titles;
@property (nonatomic, strong) NSArray *contentUrlStrs;

@end

@implementation GKListLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentUrlStrs = @[@"http://robroker.hithink.com/stockpage/usa_AAPL#&atab=geguNews", @"http://robroker.hithink.com/basic/AAPL/pub.html?appname=platformphone", @"http://robroker.hithink.com/basic/AAPL/company.html", @"http://robroker.hithink.com/basic/AAPL/company.html"];
    self.gk_navTitleColor = [UIColor whiteColor];
    self.gk_navTitleFont = [UIFont boldSystemFontOfSize:18.0f];
    self.gk_navBackgroundColor = [UIColor clearColor];
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.view addSubview:self.pageScrollView];
    [self.pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.pageScrollView reloadData];
}

#pragma mark - GKPageScrollViewDelegate
- (BOOL)shouldLazyLoadListInPageScrollView:(GKPageScrollView *)pageScrollView {
    return YES;
}

- (UIView *)headerViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.headerView;
}

- (UIView *)segmentedViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.titles.count;
}

- (id<GKPageListViewDelegate>)pageScrollView:(GKPageScrollView *)pageScrollView initListAtIndex:(NSInteger)index {
    USWebViewController *webVC = [USWebViewController new];
    webVC.webUrlStr = self.contentUrlStrs[index];
    return webVC;
}

#pragma mark - 懒加载
- (GKPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[GKPageScrollView alloc] initWithDelegate:self];
    }
    return _pageScrollView;
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kBaseHeaderHeight)];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.clipsToBounds = YES;
        _headerView.backgroundColor = [UIColor orangeColor];
        _headerView.image = [UIImage imageNamed:@"test"];
    }
    return _headerView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"News", @"Filings", @"Profile", @"Financials"];
    }
    return _titles;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kBaseSegmentHeight)];
        _categoryView.titles = self.titles;
        _categoryView.titleFont = [UIFont systemFontOfSize:15.0f];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:15.0f];
        _categoryView.titleColor = [UIColor grayColor];
        _categoryView.titleSelectedColor = [UIColor redColor];
        
        JXCategoryIndicatorLineView *lineView = [JXCategoryIndicatorLineView new];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
        lineView.indicatorLineViewHeight = ADAPTATIONRATIO * 4.0f;
        lineView.verticalMargin = ADAPTATIONRATIO * 2.0f;
        _categoryView.indicators = @[lineView];
        
        // 设置关联的scrollView
        _categoryView.contentScrollView = self.pageScrollView.listContainerView.collectionView;
        
        UIView  *btmLineView = [UIView new];
        btmLineView.backgroundColor = GKColorRGB(110, 110, 110);
        [_categoryView addSubview:btmLineView];
        [btmLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self->_categoryView);
            make.height.mas_equalTo(ADAPTATIONRATIO * 2.0f);
        }];
    }
    return _categoryView;
}

@end
