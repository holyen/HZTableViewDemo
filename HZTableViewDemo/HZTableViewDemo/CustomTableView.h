//
//  CustomTableView.h
//  Forum
//
//  Created by Lei Zhu on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import <QuartzCore/QuartzCore.h>
#import "CustomTableViewCell.h"

@interface CellData : NSObject
{
    NSString *firstStr;
    NSString *secondStr; 
    NSString *thirdStr;
    NSString *fourthStr;                
    NSString *fifthStr;                
    NSString *sixthStr;
    NSString *sevenStr;
    NSArray * firstArr;
	int index;
}

@property (nonatomic,retain,setter = setFirstStr:,getter = getFirstStr) NSString * firstStr;
@property (nonatomic,retain,setter = setSecondStr:,getter = getSecondStr) NSString * secondStr;
@property (nonatomic,retain,setter = setThirdStr:,getter = getThirdStr) NSString * thirdStr;
@property (nonatomic,retain,setter = setFourthStr:,getter = getFourthStr) NSString * fourthStr;
@property (nonatomic,retain,setter = setFifthStr:,getter = getFifthStr) NSString * fifthStr;
@property (nonatomic,retain,setter = setSixthStr:,getter = getSixthStr) NSString * sixthStr;
@property (nonatomic,retain,setter = setSevenStr:,getter = getSevenStr) NSString * sevenStr;
@property (nonatomic,retain,setter = setfirstArr:,getter = getfirstArr) NSArray * firstArr;
@property (nonatomic,assign,setter = setIndex:,getter = getIndex) int index;
@end


typedef enum TABLE_VIEW_TYPE
{
    TABLE_VIEW_TYPE_DEAFAULT,
    TABLE_VIEW_TYPE_LIVERECORD,//事故列表
    TABLE_VIEW_TYPE_UTILITY_MAP,//实用地图列表
    TABLE_VIEW_TYPE_CARCONSUME,//养车消费单
    TABLE_VIEW_TYPE_PARTS_PRICE, //配件价格
    TABLE_VIEW_TYPE_PARTS_DISTINGUISH, //配件价格
    TABLE_VIEW_TYPE_BRAND_ACTIVITY,//品牌活动
    TABLE_VIEW_TYPE_DEALER_LOCATOR,//经销商查询
    TABLE_VIEW_TYPE_WORRYFREETIPS,//无忧贴士
    TABLE_VIEW_TYPE_MAINTERNANCE_GUIDE,//保养
    TABLE_VIEW_TYPE_CITY_SELECTED,//城市选择
    TABLE_VIEW_TYPE_CAR_SELECTED,//车型选择
    TABLE_VIEW_TYPE_CAR_TYPE_SELECTED,//车子项的选择
    TABLE_VIEW_TYPE_CAR_INSTRU,//车型说明书
}TABLE_VIEW_TYPE;


@protocol CustomTableViewDelegate;

@interface CustomTableView : UITableView
<UITableViewDataSource,UITableViewDelegate,CustomTableViewCellDelegate>
{
    id <CustomTableViewDelegate>tableViewDelegate;
    TABLE_VIEW_TYPE m_type;
    id m_target;
    NSMutableArray * m_allCellViewArr;
	NSMutableArray * m_allCellDataArr;
    NSMutableDictionary * m_allSectionData;
    NSMutableDictionary * m_allSectionView;
    NSMutableArray * m_allSectionKeyArr;
    
    NSMutableArray * m_allCellHeightArr;
    NSArray * m_allCellTitleData;
    UIButton *m_loadMoreBtn;
    UIActivityIndicatorView * m_indicatorView;
    BOOL _reloading;
    float cellHeight;
    float loadMoreViewheight;
    BOOL loadMoreData;
}

@property(nonatomic,assign)id <CustomTableViewDelegate>tableViewDelegate;

- (id)initWithFrame:(CGRect)frame type:(TABLE_VIEW_TYPE)type;
- (void)setType:(TABLE_VIEW_TYPE)type;

- (void)setTarget:(id)target;
- (void)clearAllTableViewData;
- (void)releaseAllTableViewData;

- (void)removeReloadMoreDataBtn;
- (void)addReloadMoreDataBtn;
- (void)doneLoadingTableViewData;

//车型选择
-(void)initWithCarData:(NSArray *)array;

//车型选择
-(void)initWithCarTypeData:(NSDictionary *)dict;
//过滤价格

-(void)initWithCarTypeFilterPriceData:(NSDictionary *)dict;
// 现场记录列表
-(void)initWithLiveRecordData:(NSArray *)array;

//实用地图列表
- (void)initUtilityMapTableViewDataSource:(NSArray *)data;

//养车消费单
-(void)initWithConsumeData:(NSArray *)array;

// 养车学堂-保养指南
-(void)initWithMaintenanceGuideData:(NSArray *)array;

// 养车学堂-车型说明书
-(void)initWithCarInstrData:(NSArray *)array;

//养车学堂 -无忧贴士
-(void)initWithWorryFreeTipsData:(NSArray *)array;


//配件价格
- (void)initPartsPriceTableViewDataSource:(NSArray *)data;

//品牌活动
- (void)initBrandActivityTableViewDataSource:(NSArray *)data;

//经销商查询
- (void)initDealersLoctorTableViewDataSource:(NSArray *)data;

//城市选择
- (void)initCitySelectedTableViewDataSource:(NSDictionary *)data showShortName:(BOOL)value;
@end

@protocol CustomTableViewDelegate <NSObject>
@optional

- (void)getMoreListData;
- (void)tableViewCellSelected:(int)rowIndex;
- (void)tableViewCellSelected:(int)rowIndex section:(int)sectionIndex;

- (void)tableViewCellDelete:(int)rowIndex section:(int)sectionIndex;
- (void)tableViewCellSectionDelete:(int)rowIndex;

@end
