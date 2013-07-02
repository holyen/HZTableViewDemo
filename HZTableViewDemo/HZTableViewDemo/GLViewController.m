//
//  GLViewController.m
//  HZTableViewDemo
//
//  Created by Holyen Zou on 13-7-1.
//  Copyright (c) 2013年 Holyen Zou. All rights reserved.
//

#import "GLViewController.h"

@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rectOfTableView = self.view.bounds;
    _tableView = [[HZTableView alloc] initWithFrame:rectOfTableView style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.tableViewDelegate = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark - UITableViewDataDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"cellTitle";
    }
    return cell;
}

#pragma mark -
#pragma mark - HZTableViewDelegate

- (void)startUpdatingInHZTableView:(HZTableView *)tableView
{
    NSLog(@"get data from server.");
    //test: stop after 3 seconds:
    [_tableView performSelector:@selector(stopUpdating) withObject:nil afterDelay:3.0];
}

@end
