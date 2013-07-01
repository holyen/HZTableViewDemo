//
//  HZTableView.h
//  HZTableViewDemo
//
//  Created by Holyen Zou on 13-7-1.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;



@end
