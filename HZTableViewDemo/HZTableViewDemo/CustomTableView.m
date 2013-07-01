    //
    //  CustomTableView.m
    //  Forum
    //
    //  Created by Lei Zhu on 12-8-20.
    //  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
    //

#import "CustomTableView.h"

@implementation CellData
@synthesize index;
@synthesize firstStr;
@synthesize secondStr;
@synthesize thirdStr;
@synthesize fourthStr;
@synthesize fifthStr;
@synthesize sixthStr,sevenStr,firstArr;

- (void)dealloc
{
    [firstStr release];
    [secondStr release];
    [thirdStr release];
    [fourthStr release];
    [fifthStr release];
    [sixthStr release];
    [sevenStr release];
    [firstArr release];
	[super dealloc];
}
@end

@interface CustomTableView(Private)

- (UIButton *)initReloadMoreDataBtn;
- (void)refreshLoadMoreBtnFrame;

@end

@implementation CustomTableView
@synthesize tableViewDelegate;

- (void)dealloc{
    [m_allCellViewArr release];
    [m_allCellDataArr release];
    [m_allSectionData release];
    [m_allSectionView release];
    [m_allSectionKeyArr release];
    [m_allCellHeightArr release];
    [m_allCellTitleData release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame type:(TABLE_VIEW_TYPE)type
{
    m_type = type;
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        m_allCellViewArr = [[NSMutableArray alloc] init];
        m_allCellDataArr = [[NSMutableArray alloc] init];
        loadMoreData = NO;
        loadMoreViewheight = 30;
        switch (m_type) {
            case TABLE_VIEW_TYPE_DEAFAULT:
            {
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            cellHeight = 60.0f;
            }
                break;
            case TABLE_VIEW_TYPE_LIVERECORD:
            {
                [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                cellHeight = 50.0f;
            }
                break;
            case TABLE_VIEW_TYPE_UTILITY_MAP:
            {
            cellHeight = 70.0f;
            self.backgroundColor = [UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1];
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            }
                break;
            case TABLE_VIEW_TYPE_CARCONSUME:
            {
            cellHeight = 45;
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            m_allSectionData = [[NSMutableDictionary alloc] init];
            }
                break;
            case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
            {
            cellHeight = 60/2;
            m_allSectionData = [[NSMutableDictionary alloc] init];
            }
                break;
            case TABLE_VIEW_TYPE_PARTS_PRICE:
            {
                cellHeight = 53;
                [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
                self.backgroundColor = [UIColor colorWithRed:170.0f/255.0f green:175.0f/255.0f blue:180.0f/255.0f alpha:1];
            
            }
                break;
            case TABLE_VIEW_TYPE_WORRYFREETIPS:
            {
            cellHeight  = 60;
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            }
                break;
            case TABLE_VIEW_TYPE_BRAND_ACTIVITY:
            {
            cellHeight  = 96;
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            self.backgroundColor = [UIColor colorWithRed:170.0f/255.0f green:175.0f/255.0f blue:180.0f/255.0f alpha:1];
            }
                break;
            case TABLE_VIEW_TYPE_DEALER_LOCATOR:
            {
            cellHeight  = 75;
            self.backgroundColor = [UIColor clearColor];
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            }
                break;
            case TABLE_VIEW_TYPE_CITY_SELECTED:
            {
            m_allSectionData = [[NSMutableDictionary alloc] init];
            m_allSectionView = [[NSMutableDictionary alloc] init];
            m_allSectionKeyArr = [[NSMutableArray alloc] init];
            
            cellHeight =30;
            self.backgroundColor = [UIColor clearColor];
            
            }
                break;
            case TABLE_VIEW_TYPE_CAR_SELECTED:
            {
            cellHeight = 190/2;
            }
                break;
            case TABLE_VIEW_TYPE_CAR_INSTRU:
            {
            cellHeight = 50;
            [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            }
                break;
            case TABLE_VIEW_TYPE_CAR_TYPE_SELECTED:
            {
            cellHeight = 65;
            }
                break;
            default:
            {
            cellHeight =45.f;
            }
                break;
        }
    }
    return self;
}

- (void)setTarget:(id)target
{
    m_target = target;
}

- (void)setType:(TABLE_VIEW_TYPE)type
{
    m_type = type;
}

- (void)clearAllTableViewData
{
    [self setContentOffset:CGPointMake(0, 0)];
    [m_allCellViewArr removeAllObjects];
    [m_allCellDataArr removeAllObjects];
}

- (void)releaseAllTableViewData
{
    if (m_allCellViewArr) {
        for (CustomTableViewCell * cell in m_allCellViewArr) {
            [cell clearAllSubViews];
        }
        [m_allCellViewArr removeAllObjects];
    }
    
    if (m_allCellDataArr) {
        [m_allCellDataArr removeAllObjects];
    }
    
    if (m_allSectionKeyArr) {
        [m_allSectionKeyArr removeAllObjects];
    }
    if (m_allSectionData) {
        NSArray * allKeys = [m_allSectionData allKeys];
        for (int i = 0; i < [allKeys count]; i ++) {
            NSString * key = [allKeys objectAtIndex:i];
            NSDictionary * dict = [m_allSectionData objectForKey:key];
            NSArray * cellViews = [dict objectForKey:@"itemsView"];
            for (CustomTableViewCell * cell in cellViews) {
                [cell clearAllSubViews];
            }
        }
        [m_allSectionData removeAllObjects];
    }
    
    if (m_allSectionView) {
        NSArray * allKeys = [m_allSectionView allKeys];
        for (int i = 0; i < [allKeys count]; i ++) {
            NSString * key = [allKeys objectAtIndex:i];
            NSArray * subViews = [m_allSectionView objectForKey:key];
            for (CustomTableViewCell * cell in subViews) {
                [cell clearAllSubViews];
            }
        }
        [m_allSectionView removeAllObjects];
    }
    
    [self reloadData];
}


- (void)addReloadMoreDataBtn
{
    if (!m_loadMoreBtn) {
        m_loadMoreBtn = [[UIButton alloc] init];
            //[m_loadMoreBtn setBackgroundImage:[UIImage imageNamed:@"image_loadmore.png"] forState:UIControlStateNormal];
        [m_loadMoreBtn setTitle:@"向上滑动加载更多..." forState:UIControlStateNormal];
        [m_loadMoreBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [m_loadMoreBtn addTarget:self action:@selector(loadMoreBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        float btnHeight = 21;
        float btnWidht = 150;
        float originY = (loadMoreViewheight - btnHeight) / 2;
        float originX = (CGRectGetWidth(self.frame) - btnWidht) / 2;
        [m_loadMoreBtn setFrame:CGRectMake(originX, originY, btnWidht, btnHeight)];
        
        m_indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        m_indicatorView.frame = CGRectMake(CGRectGetWidth(m_loadMoreBtn.frame) - 25, 2, 18, 18);
        m_indicatorView.hidesWhenStopped = YES;
            //m_indicatorView.backgroundColor = [UIColor lightGrayColor];
            //[m_loadMoreBtn addSubview:m_indicatorView];
    }
    [self refreshLoadMoreBtnFrame];
    [self addSubview:m_loadMoreBtn];
    loadMoreData = YES;
}

- (void)refreshLoadMoreBtnFrame
{
    CGSize tempSize = self.contentSize;
    tempSize.height += loadMoreViewheight;
    self.contentSize = tempSize;
    float btnHeight = 21;
    float btnWidht = 150;
    float originY = (loadMoreViewheight - btnHeight) / 2;
    float originX = (CGRectGetWidth(self.frame) - btnWidht) / 2;
    NSLog(@"%f %f ",originX,tempSize.height - originY - btnHeight);
    [m_loadMoreBtn setFrame:CGRectMake(originX, tempSize.height - originY - btnHeight, btnWidht, btnHeight)];
}

- (void)removeReloadMoreDataBtn
{
    CGSize tempSize = self.contentSize;
    tempSize.height -= loadMoreViewheight;
    self.contentSize = tempSize;
    [self reloadData];
    [m_loadMoreBtn removeFromSuperview];
    [m_loadMoreBtn release];
    m_loadMoreBtn = nil;
    loadMoreData = NO;
    [m_indicatorView removeFromSuperview];
    [m_indicatorView release];
    m_indicatorView = nil;
}

- (void)loadMoreBtnPressed
{
    if ([tableViewDelegate respondsToSelector:@selector(getMoreListData)]) {
        [m_indicatorView startAnimating];
        [tableViewDelegate getMoreListData];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (decelerate) {
            //NSLog(@"YES");
        if (loadMoreData) {
                // NSLog(@"scrollView.contentSize.height:%f",scrollView.contentSize.height);
                //NSLog(@"scrollView.contentOffset.y:%f",(scrollView.contentOffset.y + CGRectGetHeight(self.frame)));
            float hight = scrollView.contentSize.height;
            float offsetY = (scrollView.contentOffset.y + CGRectGetHeight(self.frame));
            if ((offsetY - hight > 60)) {
                [self loadMoreBtnPressed];
            }
        }
    }else{
            //NSLog(@"NO");
        switch (m_type) {
            case TABLE_VIEW_TYPE_BRAND_ACTIVITY:
            {
            [self dynamicLoadImage];
            }
                break;
                
            default:
                break;
        }
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    switch (m_type) {
        case TABLE_VIEW_TYPE_BRAND_ACTIVITY:
        {
        [self dynamicLoadImage];
        }
            break;
            
        default:
            break;
    }
    
    
}


- (void)dynamicLoadImage
{
    NSArray * visibleCells = [self visibleCells];
    for (int i = 0; i < [visibleCells count] ; i ++) {
        UITableViewCell * cell = [visibleCells objectAtIndex:i];
        CustomTableViewCell * cellView = (CustomTableViewCell *)[cell viewWithTag:1989];
        BOOL hasImg = [cellView hasImage];
        if (!hasImg) {
            [cellView loadImage];
        }
    }
    
}

#pragma mark 车型选择
-(void)initWithCarData:(NSArray *)array
{
        //    [self releaseAllTableViewData];
    for ( int i=0; i<array.count; i++) {
        NSDictionary * dict = [array objectAtIndex:i];
        CarData * data = [[CarData alloc] init];
        data.c_id = [dict objectForKey:@"id"];
        data.c_name = [dict objectForKey:@"name"];
        data.c_imgurl = [dict objectForKey:@"imageurl"];
        data.c_imgBanerUrl = [dict objectForKey:@"bannerimage"];  
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CAR_SELECTED];
        
        NSRange tempRange = [data.c_imgurl rangeOfString:@"http"];
        
        if (tempRange.location == NSNotFound) {
            [cell setImgView:data.c_imgurl];
        }
        else
        {
            NSRange range = [data.c_imgurl rangeOfString:@"png"];
            NSRange jpg = [data.c_imgurl rangeOfString:@"jpg"];
            if (range.location == NSNotFound && jpg.location == NSNotFound) {
                if (i%2!=0) {
                    [cell setImgView:CARTYPE_IMAGE_GRAY];
                }
                else
                    [cell setImgView:CARTYPE_IMAGE];
            }
            else
            {
                [cell setImgURL:data.c_imgurl];
                
                NSURL * URL = [NSURL URLWithString:data.c_imgurl];
                SDWebImageManager *manager = [SDWebImageManager sharedManager];
                UIImage *cachedImage = [manager imageWithURL:URL];
                if (!cachedImage) {
                    [cell setImgView:[NSString stringWithFormat:@"%@.png", data.c_name ]];
                }
                else
                    [cell loadImage];
            }
        }
        [cell setFirstLabelText:data.c_name];
        if (i%2!=0)
            cell.backgroundColor = [UIColor whiteColor];
        else
            cell.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:205.0f/255.0f blue:211.0f/255.0f alpha:1];
        [m_allCellViewArr addObject:cell];
        [m_allCellDataArr addObject:data];
        [data release];
        [cell release];
    }
    [self reloadData];
}

#pragma mark   车型选择  
-(void)initWithCarTypeData:(NSDictionary *)dict
{
    [self releaseAllTableViewData];
    NSArray * tempArray = [dict objectForKey:@"items"]; 
    for ( int i=0; i<tempArray.count; i++) {
        NSDictionary * typedict = [tempArray objectAtIndex:i];
        
        CarData *data = [[CarData alloc] init];
        data.c_id = [dict objectForKey:@"id"];
        data.c_name = [dict objectForKey:@"name"];
        data.c_imgBanerUrl = [dict objectForKey:@"bannerimage"];
        data.c_itemId = [typedict objectForKey:@"itemid"];
        data.c_itemName = [typedict objectForKey:@"Itemname"];
        data.c_itemPrice = [typedict objectForKey:@"price"];
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CAR_TYPE_SELECTED];
        [cell setFirstLabelText:data.c_itemName];
        if (i%2!=0)
            cell.backgroundColor = [UIColor whiteColor];
        else
            cell.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:205.0f/255.0f blue:211.0f/255.0f alpha:1];
        [m_allCellViewArr addObject:cell];
        [m_allCellDataArr addObject:data];
        [data release];
        [cell release];
    }
    [self reloadData];
}

#pragma mark 保险计算器 车型选择 --过滤价格
-(void)initWithCarTypeFilterPriceData:(NSDictionary *)dict
{
    [self releaseAllTableViewData];
    NSArray * tempArray = [dict objectForKey:@"items"];
    int sign = 0;
    for ( int i=0; i<tempArray.count; i++) {
        NSDictionary * typedict = [tempArray objectAtIndex:i];
        if ([[typedict objectForKey:@"price"] intValue] == 0 ) {
            continue;
        }
        sign++;
        CarData *data = [[CarData alloc] init];
        data.c_id = [dict objectForKey:@"id"];
        data.c_name = [dict objectForKey:@"name"];
        data.c_imgBanerUrl = [dict objectForKey:@"bannerimage"];
        data.c_itemId = [typedict objectForKey:@"itemid"];
        data.c_itemName = [typedict objectForKey:@"Itemname"];
        data.c_itemPrice = [typedict objectForKey:@"price"];
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CAR_TYPE_SELECTED];
        [cell setFirstLabelText:data.c_itemName];
        if (sign%2!=0)
            cell.backgroundColor = [UIColor whiteColor];
        else
            cell.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:205.0f/255.0f blue:211.0f/255.0f alpha:1];
        [m_allCellViewArr addObject:cell];
        [m_allCellDataArr addObject:data];
        [data release];
        [cell release];
    }
    [self reloadData];
}


#pragma mark 现场记录列表
-(void)initWithLiveRecordData:(NSArray *)array
{
    [self releaseAllTableViewData];
    for ( int i=0; i<array.count; i++) {
        LiveRecord * data = [array objectAtIndex:i];
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 300, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_LIVE_RECORD];
        NSString * temp = [data.r_time substringToIndex:10];
        [cell setFirstLabelText:temp ];
        if (i%2==0)
            cell.backgroundColor = [UIColor whiteColor];
        else
            cell.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:205.0f/255.0f blue:211.0f/255.0f alpha:1];
        [cell setSecondLabelText:data.r_address];
        [m_allCellViewArr addObject:cell];
        [cell release];
    }
    [self reloadData];
}


#pragma mark 养车学堂--无忧贴士
-(void)initWithWorryFreeTipsData:(NSArray *)array
{
        //    [self releaseAllTableViewData];
//    [m_allCellViewArr removeAllObjects];
    for (int i=0; i<array.count; i++) {
        NSDictionary * dict = [array objectAtIndex:i];
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 302, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_WORRYFREE_TIPS];
        [cell setFirstLabelText:[dict objectForKey:@"name"]];
        if (i%2==0) {
            cell.backgroundColor = [UIColor colorWithRed:200/255. green:204/255. blue:209/255. alpha:1];
        }
        else
            cell.backgroundColor = [UIColor whiteColor];
        [cell setSecondLabelText:[dict objectForKey:@"time"]];
        [m_allCellViewArr addObject:cell];
        [cell release];
    }
    [self reloadData];
}


#pragma mark 保养指南
-(void)initWithMaintenanceGuideData:(NSArray *)data
{ 
    for (int i=0; i<data.count; i++) {
        NSDictionary * dict = [data objectAtIndex:i];
        NSMutableDictionary * sectionDict = [[NSMutableDictionary alloc] init];
        NSString * type = [dict objectForKey:@"id"];
        NSString * name = [dict objectForKey:@"name"];
        NSString * mile = [dict objectForKey:@"mile"];
        NSString * item = [dict objectForKey:@"items"];
        
        NSMutableArray * itemView = [[NSMutableArray alloc] init];
        
        CGSize s = [item sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(302-MAINTENANCEGUIDE_LEFT_OFFSET, 1000) lineBreakMode:UILineBreakModeWordWrap];//求文本的大小
        cellHeight = s.height+5;
        
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0,302, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_MAINTENANCE_GUIDE];
        NSArray * strChange = [item componentsSeparatedByString:@"更换:"]; 
        [cell setFirstLabelText:[[[strChange objectAtIndex:0] componentsSeparatedByString:@"\n"]  objectAtIndex:1]];
        [cell setFourthLabelText:[[strChange lastObject] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        [cell setCellFrame];
        NSLog(@"===%@====",[strChange lastObject]);
        cell.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        [itemView addObject:cell];
        [cell release];
        
        [sectionDict setValue:itemView forKey:@"itemsView"];
        [sectionDict setValue:type forKey:@"type"];
        [sectionDict setValue:name forKey:@"name"];
        [sectionDict setValue:mile forKey:@"mile"];
        [sectionDict setValue:@"close" forKey:@"sectionStatus"];
        [itemView release];
        [m_allSectionData setValue:sectionDict forKey:type];
        [m_allCellDataArr addObject:type];
            //        [sectionDict release];
    }
    [self reloadData];
}

#pragma mark 养车学堂-车型说明书
-(void)initWithCarInstrData:(NSArray *)array
{
    for (int i=0; i<array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 302, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CAR_INSTRU];
        [cell setFirstLabelText:[dict objectForKey:@"name"]];
        if (i%2!=0) {
            cell.backgroundColor = [UIColor colorWithRed:200/255. green:204/255. blue:209/255. alpha:1];
        }
        else
            cell.backgroundColor = [UIColor whiteColor];
        [m_allCellViewArr addObject:cell];
        [cell release];
    }
    [self reloadData];
}

#pragma mark 养车消费单
-(void)initWithConsumeData:(NSArray *)data
{
    [self releaseAllTableViewData];
    for (int i=0; i<data.count; i++) {
        NSDictionary * dict = [data objectAtIndex:i];
        NSMutableDictionary * sectionDict = [[NSMutableDictionary alloc] init];
        NSString * type = [dict objectForKey:@"type"];
        NSString * amount = [dict objectForKey:@"amount"];
        NSString * number = [dict objectForKey:@"number"];
        NSArray * item = [dict objectForKey:@"items"];
        NSMutableArray * itemView = [[NSMutableArray alloc] init];
        for (int j = 0; j<item.count; j++) {
            ConsumeData * itemData = [item objectAtIndex:j];
            CustomTableViewCell * cell = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0,302, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CARCONSUME];
            [cell setBtnTitle:[NSString stringWithFormat:@"%d",j+1]];
            [cell setFirstLabelText:itemData.m_createtime];
            [cell setSecondLabelText:[NSString stringWithFormat:@"%@元", itemData.m_amount]];
            if (j%2==0)
                cell.backgroundColor = [UIColor whiteColor];
            else
                cell.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
            
            [itemView addObject:cell];
            [cell release];
        }
        [sectionDict setValue:itemView forKey:@"itemsView"];
        [sectionDict setValue:type forKey:@"type"];
        [sectionDict setValue:number forKey:@"number"];
        [sectionDict setValue:amount forKey:@"amount"];
        [sectionDict setValue:@"close" forKey:@"sectionStatus"];
        [m_allCellDataArr addObject:type];
        [m_allSectionData setValue:sectionDict forKey:type];
        [itemView release];
            //        [sectionDict release];
    }
    [self reloadData];
}

#pragma mark实用地图列表
- (void)initUtilityMapTableViewDataSource:(NSArray *)data
{
    [m_allCellDataArr removeAllObjects];
    [m_allCellViewArr removeAllObjects];
    for (int i = 0; i < [data count]; i ++) {
        
        BMKPointAnnotation * pointAnnotation = [data objectAtIndex:i];
        NSString * title = pointAnnotation.title;
        NSString * subTitle = pointAnnotation.subtitle;
            //        CLLocationCoordinate2D coordinate = pointAnnotation.coordinate;
        CustomTableViewCell * cellView = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), cellHeight - 2) cellType:TABLE_VIEW_CELL_TYPE_UTILITY_MAP];
        [cellView setFirstLabelText:title];
        [cellView setSecondLabelText:subTitle];
        [m_allCellViewArr addObject:cellView];
        
        if (i % 2 == 0) {
            [cellView setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cellView setBackgroundColor:[UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1]];
        }
        
        
        
        [cellView release];
        
        [m_allCellDataArr addObject:pointAnnotation];
        
    }
    [self reloadData];
}
#pragma mark 配件价格
- (void)initPartsPriceTableViewDataSource:(NSArray *)data
{
    [self releaseAllTableViewData];
    int count = [data count];
    for (int i = 0; i < count; i ++) {
        NSDictionary * dic = [data objectAtIndex:i];
        NSString * partsID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];//配件编号
        NSString * partsName = [dic objectForKey:@"name"];//配件名称
        NSString * partsUnits =[dic objectForKey:@"units"] ;//单位
        NSString * partsPrice = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"price"] floatValue]];//价格
        NSString * partsDate =[dic objectForKey:@"datetime"] ;//日期
        
        
        CustomTableViewCell * cellView = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), cellHeight) cellType:TABLE_VIEW_CELL_TYPE_PARTS_PRICE];
        [cellView setFirstLabelText:partsID];
        [cellView setSecondLabelText:partsName];
        [cellView setThirdLabelText:partsUnits];
        [cellView setFourthLabelText:partsPrice];
        [cellView setFifthLabelText:partsDate];
        
        
        [m_allCellViewArr addObject:cellView];
        [cellView release];
    }
    [self reloadData];
}

#pragma mark 品牌活动
- (void)initBrandActivityTableViewDataSource:(NSArray *)data
{
    int count = [data count];
    
    for (int i = 0; i < count; i ++) {
        NSDictionary * dic = [data objectAtIndex:i];
            //        NSString * ID = [dic objectForKey:@"id"];
        NSString * name = [dic objectForKey:@"name"];
        NSString * time = [dic objectForKey:@"time"];
        NSString * intro = [dic objectForKey:@"intro"];
        NSString * path = [dic objectForKey:@"path"];
        NSString * state = [dic objectForKey:@"state"];
        NSString * url = [dic objectForKey:@"url"];
        NSString * image = [dic objectForKey:@"image"];
        
        CustomTableViewCell * cellView = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), cellHeight) cellType:TABLE_VIEW_CELL_TYPE_BRAND_ACTIVITY];
        cellView.tag = 1989;
        [cellView setFirstLabelText:name];
        [cellView setSecondLabelText:time];
        [cellView setThirdLabelText:intro];
        [cellView setImgURL:[NSString stringWithFormat:@"%@%@",BASE_IMG_DOWNLOAD_URL,path]];
        
        if (i <= 5) {
            [cellView loadImage];
        }
        
        if (i % 2 == 0) {
            cellView.backgroundColor = [UIColor colorWithRed:225.0f/255.0f green:227.0f/255.0f blue:230.0f/255.0f alpha:1];
        }else{
            cellView.backgroundColor = [UIColor whiteColor];
        }
        [m_allCellViewArr addObject:cellView];
        [cellView release];
        
        CellData * cellDt = [[CellData alloc] init];
        [cellDt setFirstStr:name];
        [cellDt setSecondStr:time];
        [cellDt setThirdStr:intro];
        [cellDt setFourthStr:path];
        [cellDt setFifthStr:state];
        [cellDt setSixthStr:url];
        [cellDt setSevenStr:image];
        [m_allCellDataArr addObject:cellDt];
        [cellDt release];
        
    }
    [self reloadData];
}


#pragma mark 经销商查询
- (void)initDealersLoctorTableViewDataSource:(NSArray *)data
{
    for (int i = 0; i < [data count]; i ++) {
        NSDictionary * dic = [data objectAtIndex:i];
        NSString * ID = [dic objectForKey:@"id"];
        NSString * name = [dic objectForKey:@"name"];
        NSString * address = [dic objectForKey:@"address"];
        NSString * phone = [dic objectForKey:@"phone"];
        NSString * tel = [dic objectForKey:@"tel"];
        NSString * lon = [NSString stringWithFormat:@"%f",[[dic objectForKey:@"lon"] floatValue]];//经度
        NSString * lan = [NSString stringWithFormat:@"%f",[[dic objectForKey:@"lan"] floatValue]];//纬度
        
        CustomTableViewCell * cellView = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), cellHeight) cellType:TABLE_VIEW_CELL_TYPE_DEALERS_LOCATOR];
        [cellView setFirstLabelText:name];
        [cellView setSecondLabelText:address];
        
        if (i % 2 == 0) {
            cellView.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:205.0f/255.0f blue:211.0f/255.0f alpha:1];
            
        }else{
            cellView.backgroundColor = [UIColor whiteColor];
        }
        
        CellData * cellDt = [[CellData alloc] init];
        [cellDt setFirstStr:name];
        [cellDt setSecondStr:address];
        [cellDt setThirdStr:phone];
        [cellDt setFourthStr:tel];
        [cellDt setFifthStr:lon];//经度
        [cellDt setSixthStr:lan];//纬度
        [cellDt setSevenStr:ID];
        
        [m_allCellDataArr addObject:cellDt];
        [m_allCellViewArr addObject:cellView];
        
        [cellDt release];
        [cellView release];
    }
    [self reloadData];
}

    //城市选择
- (void)initCitySelectedTableViewDataSource:(NSDictionary *)data showShortName:(BOOL)value
{
    NSArray * allKeys = [data allKeys];
    [m_allSectionKeyArr addObjectsFromArray:[[ConfigData shareInstance] sortedArrayByFirstChar:allKeys]];
    for (int i = 0; i < [allKeys count]; i ++) {
        NSString * key = [allKeys objectAtIndex:i];
        NSArray * provinceData = [data objectForKey:key];
        
        NSMutableArray * sectionData = [[NSMutableArray alloc] init];
        NSMutableArray * sectionView = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < [provinceData count]; j ++) {
            NSDictionary * dic = [provinceData objectAtIndex:j];
            int cityid = [[dic objectForKey:@"id"] intValue];
            NSString * name = [dic objectForKey:@"name"];
            NSString * shortname = [dic objectForKey:@"short"];
            NSString * area = [dic objectForKey:@"area"];
                //            NSString * provinceid = [dic objectForKey:@"provinceid"];
            NSString * url = [dic objectForKey:@"url"];
                //            NSString * num = [dic objectForKey:@"num"];
            NSArray * subCity = [dic objectForKey:@"subCity"];
            
            CustomTableViewCell * cellView = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CITY_SELECTED];
            
            if (!value) {
                [cellView setFirstLabelText:name];
            }else{
                [cellView setFirstLabelText:shortname];
            }
            
            [sectionView addObject:cellView];
            if (j % 2 == 0) {
                [cellView setBackgroundColor:[UIColor whiteColor]];
            }else{
                [cellView setBackgroundColor:[UIColor colorWithRed:195.0f/255.0f green:195.0f/255.0f blue:195.0f/255.0f alpha:1]];
            }
            
            [cellView release];
            
            CellData * cellDt = [[CellData alloc] init];
            [cellDt setfirstArr:subCity];
            [cellDt setFirstStr:[NSString stringWithFormat:@"%d",cityid]];
            [cellDt setSecondStr:name];
            [cellDt setThirdStr:area];
            [cellDt setFourthStr:shortname];
            [cellDt setFifthStr:url];
            [sectionData addObject:cellDt];
            [cellDt release];
        }
        
        [m_allSectionData setObject:sectionData forKey:key];
        [m_allSectionView setObject:sectionView forKey:key];
        [sectionData release];
        [sectionView release];
    }
    
    if (!value) {
        NSMutableArray * sectionData = [[NSMutableArray alloc] init];
        NSMutableArray * sectionView = [[NSMutableArray alloc] init];
        NSString * cityname = [[[ConfigData shareInstance] curCityData] objectForKey:@"cityname"];
        NSString * cityid = [[[ConfigData shareInstance] curCityData] objectForKey:@"cityid"];
        NSString * url = [[[ConfigData shareInstance] curCityData] objectForKey:@"url"];
        
        CustomTableViewCell * cellView = [[CustomTableViewCell alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, cellHeight) cellType:TABLE_VIEW_CELL_TYPE_CITY_SELECTED];
        
        BOOL userLocationStatus = [[ConfigData shareInstance] userLocationStatus];
        if (userLocationStatus) {
            [cellView setFirstLabelText:[NSString stringWithFormat:@"自动定位 (当前:%@)",cityname]];            
        }else{
            [cellView setFirstLabelText:@"自动定位 (定位失败)"];            
        }
        
        [sectionView addObject:cellView];
        [cellView setBackgroundColor:[UIColor whiteColor]];
        [cellView release];
        CellData * cellDt = [[CellData alloc] init];
        [cellDt setfirstArr:nil];
        [cellDt setFirstStr:cityid];
        [cellDt setSecondStr:[NSString stringWithFormat:@"自动定位 (当前:%@)",cityname]];
        [cellDt setFourthStr:cityname];
        [cellDt setFifthStr:url];
        [sectionData addObject:cellDt];
        [cellDt release];
        
        [m_allSectionData setObject:sectionData forKey:@"自动定位"];
        [m_allSectionView setObject:sectionView forKey:@"自动定位"];
        [m_allSectionKeyArr insertObject:@"自动定位" atIndex:0];
        [sectionView release];
        [sectionData release];
    }
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    switch (m_type) {
        case TABLE_VIEW_TYPE_CARCONSUME:
        case TABLE_VIEW_TYPE_CITY_SELECTED:
        case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
            return m_allSectionData.count;
            break;
            
        default:
            return 1;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (m_type) {
        case TABLE_VIEW_TYPE_CARCONSUME:
        case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
        {
        NSString * key = [m_allCellDataArr objectAtIndex:section];
        NSDictionary * dict = [m_allSectionData objectForKey:key];
        NSString * temp = [dict objectForKey:@"sectionStatus"];
        if ([temp isEqualToString:@"close"]) {
            return 0;
        }
        else
            {
            return [[dict objectForKey:@"itemsView"] count];
            }
        
        }
            break;
        case TABLE_VIEW_TYPE_CITY_SELECTED:
        {
            //NSArray * allKeys = [m_allSectionData allKeys];
            //allKeys = [[ConfigData shareInstance] sortedArrayByFirstChar:allKeys];
        NSString * key = [m_allSectionKeyArr objectAtIndex:section];
        return [[m_allSectionData objectForKey:key] count];
        }
            break;
        default:
            
            return [m_allCellViewArr count];
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        switch (m_type) {
            case TABLE_VIEW_TYPE_PARTS_PRICE:
            case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
            {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
                break;
                    //            default:
                    //            {
                    //                UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
                    //                view.backgroundColor =[UIColor colorWithRed:182/255.0 green:236/255.0 blue:254/255.0 alpha:1];
                    //                [cell setSelectedBackgroundView:view];
                    //                [view release];
                    //            }
                    //                break;
        }
    }
    
    for (UIView * v in cell.subviews)
        {
        if ([v isKindOfClass:[CustomTableViewCell class]])
            [v removeFromSuperview];
        
        }
    int row = indexPath.row;
    int section = indexPath.section;
    
    switch (m_type) {
        case TABLE_VIEW_TYPE_CARCONSUME:
        case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
        {
        NSString * key = [m_allCellDataArr objectAtIndex:section];
        NSDictionary * dict = [m_allSectionData objectForKey:key];
        NSArray * tempView = [dict objectForKey:@"itemsView"];
        [cell addSubview:[tempView objectAtIndex:row]];
        }
            break;
        case TABLE_VIEW_TYPE_CITY_SELECTED:
        { 
            NSString * key = [m_allSectionKeyArr objectAtIndex:section];
            NSArray * sectionView = [m_allSectionView objectForKey:key];
            [cell addSubview:[sectionView objectAtIndex:row]];
        }
            break;
        default:
            [cell addSubview:[m_allCellViewArr objectAtIndex:row]];
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (m_type) {
        case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
        { 
            NSString * key = [m_allCellDataArr objectAtIndex:indexPath.section];
            CustomTableViewCell *cell = [[[m_allSectionData objectForKey:key]objectForKey:@"itemsView" ] objectAtIndex:indexPath.row];
            
            return CGRectGetHeight(cell.frame);
        }
            break;
            
        default:
            return cellHeight;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (m_type) {
        case TABLE_VIEW_TYPE_CARCONSUME:
            return 140/2;
            break;
        case TABLE_VIEW_TYPE_CITY_SELECTED:
            return 25;
            break;
        case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
            return 60/2;
            break;
        default:
            return 0;
            break;
    }
}

-(void)sectionOpen:(UIButton *)sender
{ 
    for (int i= 0; i<m_allCellDataArr.count; i++) {
        if (i == sender.tag) {
            NSString * key = [m_allCellDataArr objectAtIndex:sender.tag];
            NSMutableDictionary * dict = [m_allSectionData objectForKey:key];
            NSString * status = [dict objectForKey:@"sectionStatus"];
            [dict removeObjectForKey:@"sectionStatus"];
            if ([status isEqualToString:@"close"]) {
                [dict setValue:@"open" forKey:@"sectionStatus"];
                
            }
            else
                [dict setValue:@"close" forKey:@"sectionStatus"];
            [m_allSectionData removeObjectForKey:key];
            [m_allSectionData setValue:dict forKey:key];
        }
        else
            {
            NSString * key = [m_allCellDataArr objectAtIndex:i];
            NSMutableDictionary * dict = [m_allSectionData objectForKey:key];
                //            NSString * status = [dict objectForKey:@"sectionStatus"];
            [dict removeObjectForKey:@"sectionStatus"];
            [dict setValue:@"close" forKey:@"sectionStatus"];
            [m_allSectionData removeObjectForKey:key];
            [m_allSectionData setValue:dict forKey:key];
            }
    }
    
    [self reloadData];
    
    [self refreshLoadMoreBtnFrame];
}

-(void)deleteSection:(UIGestureRecognizer *)sender
{
    for (int i= 0; i<m_allCellDataArr.count; i++) {
        UIButton *tempBtn = (UIButton *)[self viewWithTag:i+100];
        tempBtn.hidden = YES;
    }
    UIButton * tempview = (UIButton *)[sender view];
    int tempTag = tempview.tag+100;
    UIButton * tempDelete = (UIButton *)[self viewWithTag:tempTag];
    
    CGRect tempRect = tempDelete.frame;
    tempRect.origin.x = tempRect.origin.x+20;
    tempDelete.frame = tempRect;
    
    tempRect.origin.x = tempRect.origin.x-20;
    [UIView animateWithDuration:DO_ANIMATION_TIME animations:^{
        tempDelete.hidden= NO;
        tempDelete.frame=tempRect;
    } completion:^(BOOL finished) {
    }];
}

-(void)deleteClick:(UIButton *)sender
{
    int tag = sender.tag-100;
    if ([tableViewDelegate respondsToSelector:@selector(tableViewCellSectionDelete:)]) {
        [tableViewDelegate tableViewCellSectionDelete:tag];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    switch (m_type) {
        case TABLE_VIEW_TYPE_CARCONSUME:
        {
        NSString * key = [m_allCellDataArr objectAtIndex:section];
        NSDictionary * dict = [m_allSectionData objectForKey:key];
        NSString * type = [dict objectForKey:@"type"];
        NSString * amount = [dict objectForKey:@"amount"];
        NSString * number = [dict objectForKey:@"number"];
        
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH-9*2 , 140/2);
        UIButton * bgView = [[UIButton alloc] initWithFrame:rect];
        bgView.tag = section;
        UISwipeGestureRecognizer * guesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSection:)];
        guesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [bgView addGestureRecognizer:guesture];
        
        if (section%2==0) {
            bgView.backgroundColor =  [UIColor colorWithRed:199.0f/255.0f green:204.0f/255.0f blue:210.0f/255.0f alpha:1.0f];
        }
        else
            bgView.backgroundColor =  [UIColor colorWithRed:168.0f/255.0f green:173.0f/255.0f blue:179.0f/255.0f alpha:1.0f];
        [bgView addTarget:self action:@selector(sectionOpen:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString * fileName = [NSString stringWithFormat:@"img_car_origin_%@.png",type];
        UIImage * image = [[UIImage  alloc] initWithContentsOfFile:FILENAME(fileName)];
        rect =  CGRectMake(10, 10, image.size.width/2, image.size.height/2);
        UIImageView * imageview= [[UIImageView alloc] initWithFrame:rect];
        imageview.image = image;
        [bgView addSubview:imageview];
        [image release];
        [imageview release];
        
        rect =  CGRectMake(CGRectGetMaxX(rect)+20, 10, 50 , 104/2);
        UILabel * label = [[UILabel alloc] initWithFrame:rect];
        label.text = [NSString stringWithFormat: @" %@ 笔",number];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:95.0f/255.0f green:98.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [bgView addSubview:label];
        [label release];
        
        rect =  CGRectMake(CGRectGetMaxX(rect)+20, 10, SCREEN_WIDTH-(CGRectGetMaxX(rect)+20)-18-5 , 104/2);
        label = [[UILabel alloc] initWithFrame:rect];
        label.text = [NSString stringWithFormat: @" %@ 元",amount];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentRight;
        label.textColor = [UIColor colorWithRed:95.0f/255.0f green:98.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
        [bgView addSubview:label];
        [label release];
        
        UIButton * btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-9-124/2, 20, 124/2, 61/2)];
        [btnDelete setBackgroundImage: [UIImage imageNamed:@"img_secion_delete.png"] forState:UIControlStateNormal];
        [btnDelete addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        btnDelete.hidden = YES;
        btnDelete.tag = section+100;
        [bgView addSubview:btnDelete];
        [btnDelete release];
        
        image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_dotted.png"]];
        UIImageView * dotLineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width/2,1)];
        dotLineImgView.image = image;
        dotLineImgView.backgroundColor = [UIColor clearColor];
        [bgView addSubview:dotLineImgView];
        [dotLineImgView release];
        [image release];
        
        return bgView;
        }
            break;
        case TABLE_VIEW_TYPE_CITY_SELECTED:
        {
            //NSArray * allKeys = [m_allSectionData allKeys];
            //allKeys = [[ConfigData shareInstance] sortedArrayByFirstChar:allKeys];
        NSString * key = [m_allSectionKeyArr objectAtIndex:section];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, 25)];
        label.text = [NSString stringWithFormat:@"    %@",key];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:13];
        [[label layer] setCornerRadius:10];
        label.backgroundColor = [UIColor colorWithRed:121.0f/255.0f green:127.0f/255.0f blue:138.0f/255.0f alpha:1];
        return [label autorelease];
        }
            break;
        case TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE:
        {
        NSString * key = [m_allCellDataArr objectAtIndex:section];
        NSDictionary * dict = [m_allSectionData objectForKey:key];
        NSString * name = [dict objectForKey:@"name"];
        NSString * mile = [dict objectForKey:@"mile"];
        
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH-9*2 , 140/2);
        UIButton * bgView = [[UIButton alloc] initWithFrame:rect];
        [bgView addTarget:self action:@selector(sectionOpen:) forControlEvents:UIControlEventTouchUpInside];
        bgView.tag = section;
        UIImage * image =[[UIImage alloc] initWithContentsOfFile:FILENAME(@"img_section_bg.png")];
        [bgView setBackgroundImage:image forState:UIControlStateNormal];
        [image release];
        
        rect =  CGRectMake(10, 0, 120-10, 30);
        UILabel * label = [[UILabel alloc] initWithFrame:rect];
        label.text = [NSString stringWithFormat: @" %@ ",mile];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [bgView addSubview:label];
        [label release];
        
        rect =  CGRectMake(CGRectGetMaxX(rect), 0, 300 , 30);
        label = [[UILabel alloc] initWithFrame:rect];
        label.text = [NSString stringWithFormat: @" %@ ",name];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        [bgView addSubview:label];
        [label release];
        
        return [bgView autorelease];
        }
            break;
        default:
            return nil;
            break;
    }
}
#pragma mark 行编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (m_type) {
        case TABLE_VIEW_TYPE_LIVERECORD:
        case TABLE_VIEW_TYPE_CARCONSUME:
            return  YES;
            break;
        default:
            break;
    }
    return NO;
} 

#pragma mark 删除执行事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if ([tableViewDelegate respondsToSelector:@selector(tableViewCellDelete:section:)]) {
            [tableViewDelegate tableViewCellDelete:indexPath.row section:indexPath.section];
        } 
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
#pragma mark  滑动显示文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}
#pragma mark -
#pragma mark Tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    int section = [indexPath section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (m_type) {
        case TABLE_VIEW_TYPE_CITY_SELECTED:
        {
            //NSArray * allKeys = [m_allSectionData allKeys];
            //allKeys = [[ConfigData shareInstance] sortedArrayByFirstChar:allKeys];
        
        NSString * key = [m_allSectionKeyArr objectAtIndex:section];
        
        if (row == 0 && section == 0 && [key isEqualToString:@"自动定位"]) {
            BOOL userLocationStatus = [[ConfigData shareInstance] userLocationStatus];
            if (!userLocationStatus) {
                return;
            }            
        } 
        
        if ([tableViewDelegate respondsToSelector:@selector(tableViewCellSelectedWithCellData:)]) {
            [tableViewDelegate tableViewCellSelectedWithCellData:[[m_allSectionData objectForKey:key] objectAtIndex:row]];
        }
        }
            break;
        case TABLE_VIEW_TYPE_CAR_SELECTED:
        case TABLE_VIEW_TYPE_CAR_TYPE_SELECTED:
        {
        if ([tableViewDelegate respondsToSelector:@selector(tableViewCellSelectedWithCarData:row:)]) {
            [tableViewDelegate tableViewCellSelectedWithCarData:[m_allCellDataArr objectAtIndex:row] row:row];
        }
        }
            break;
        default:
            if ([tableViewDelegate respondsToSelector:@selector(tableViewCellSelectedWithCellData:)]) {
                [tableViewDelegate tableViewCellSelectedWithCellData:[m_allCellDataArr objectAtIndex:row]];
            }
            break;
    }
    
    
    if ([tableViewDelegate respondsToSelector:@selector(tableViewCellSelected:)]) {
        [tableViewDelegate tableViewCellSelected:row];
    }
    
    if ([tableViewDelegate respondsToSelector:@selector(tableViewCellSelected:section:)]) {
        [tableViewDelegate tableViewCellSelected:row section:indexPath.section];
    }
    
    
}


@end
