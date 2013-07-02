//
//  HZTableView.m
//  HZTableViewDemo
//
//  Created by Holyen Zou on 13-7-1.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "HZTableView.h"

@implementation HZTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        EGORefreshTableHeaderView *headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.f, - self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
        headerView.delegate = self;
        [self addSubview:headerView];
        _refreshHeaderView = headerView;
        [_refreshHeaderView refreshLastUpdatedDate];
        self.delegate = self;
    }
    return self;
}

- (void)startUpdating
{
    _reloading = YES;
    [_tableViewDelegate startUpdatingInHZTableView:self];
}

- (void)stopUpdating
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

#pragma mark -
#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark - EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self startUpdating];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

@end
