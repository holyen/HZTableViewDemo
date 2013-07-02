//
//  HZTableView.h
//  HZTableViewDemo
//
//  Created by Holyen Zou on 13-7-1.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
@class HZTableView;
@protocol HZTableViewDelegate <NSObject>

@required

- (void)startUpdatingInHZTableView:(HZTableView *)tableView;

@end

@interface HZTableView : UITableView <UITableViewDelegate, EGORefreshTableDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    BOOL _reloading;
}

@property (nonatomic, weak) id<HZTableViewDelegate> tableViewDelegate;

- (void)stopUpdating;

@end
