//
//  GLViewController.h
//  HZTableViewDemo
//
//  Created by Holyen Zou on 13-7-1.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZTableView.h"

@interface GLViewController : UIViewController <UITableViewDataSource, HZTableViewDelegate>
{
    HZTableView *_tableView;
}

@end
