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
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
        [self setFooterView];
    }
}

- (void)reloadData
{
    [super reloadData];
    [self setFooterView];
}

- (void)setFooterView
{
    CGFloat height = self.contentSize.height;//MAX(self.contentSize.height, self.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview]) {
        _refreshFooterView.frame = CGRectMake(0.0f, height, self.bounds.size.width, self.bounds.size.height);
    } else {
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height, self.bounds.size.width, self.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [self addSubview:_refreshFooterView];
    }
    if (_refreshFooterView) {
        [_refreshFooterView refreshLastUpdatedDate];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_reloading) {
        return;
    }
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_reloading) {
        return;
    }
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark - EGORefreshTableDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    [self startUpdating];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
    return _reloading;
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
    return [NSDate date];
}

@end
