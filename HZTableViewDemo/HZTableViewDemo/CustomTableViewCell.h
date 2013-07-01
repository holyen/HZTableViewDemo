//
//  CustomTableViewCell.h
//  Forum
//
//  Created by Lei Zhu on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TABLE_VIEW_CELL_TYPE
{
    TABLE_VIEW_CELL_TYPE_DEFAULT,
    TABLE_VIEW_CELL_TYPE_LIVE_RECORD,//现在记录
    TABLE_VIEW_CELL_TYPE_UTILITY_MAP,//实用地图列表
    TABLE_VIEW_CELL_TYPE_CARCONSUME,//养车消费单
    TABLE_VIEW_CELL_TYPE_PARTS_PRICE,//配件价格
    TABLE_VIEW_CELL_TYPE_BRAND_ACTIVITY,//品牌活动
    TABLE_VIEW_CELL_TYPE_DEALERS_LOCATOR,//经销商查询
    TABLE_VIEW_CELL_TYPE_WORRYFREE_TIPS,//养车学堂-无忧贴士
    TABLE_VIEW_CELL_TYPE_MAINTENANCE_GUIDE,//养车学堂-保养指南
    TABLE_VIEW_CELL_TYPE_CITY_SELECTED, //城市选择
    TABLE_VIEW_CELL_TYPE_CAR_SELECTED,//车型选择
    TABLE_VIEW_CELL_TYPE_CAR_TYPE_SELECTED,//子车型的选择
    TABLE_VIEW_CELL_TYPE_CAR_INSTRU,//养车学堂-车型说明书
}TABLE_VIEW_CELL_TYPE;

typedef enum IMAGE_VIEW_TAG
{
    IMAGE_VIEW_TAG_UNLOADED = 0,
    IMAGE_VIEW_TAG_LOADED = 1
}IMAGE_VIEW_TAG;


@protocol CustomTableViewCellDelegate;

@interface CustomTableViewCell : UIView
{
    id <CustomTableViewCellDelegate> delegate;
    TABLE_VIEW_CELL_TYPE m_cellType;
	UIImageView * m_imageView;
    UIImageView * m_seperateLine;
	    
    UILabel * m_firstLabel;
	UILabel * m_secondLabel;
	UILabel * m_thirdLabel;
	UILabel * m_fourthLabel;
    UILabel * m_fifthLabel;
    UILabel * m_sixthLabel;
    
    UITextView *m_firstTxt;
    
    UIButton * m_firstBtn;
    UIButton * m_secondBtn;
    UIButton * m_thirdBtn;
    
    UIImageView * left_imgView;
    UIImageView * right_imgView;
    
    NSString * imgURL;
    
    id m_cellDt;
    int m_index;
}

@property(nonatomic,retain)id <CustomTableViewCellDelegate> delegate;
@property(nonatomic,retain)id m_cellDt;

- (id)initWithFrame:(CGRect)frame cellType:(TABLE_VIEW_CELL_TYPE)type;

- (void)setFirstLabelText:(NSString *)txt;
- (void)setSecondLabelText:(NSString *)txt;
- (void)setThirdLabelText:(NSString *)txt;
- (void)setFourthLabelText:(NSString *)txt;
- (void)setFifthLabelText:(NSString *)txt;
- (void)setSixthLabelText:(NSString *)txt;
- (void)setFirstBtnTitle:(NSString *)txt;


-(void)setCellFrame;
- (void)setIndex:(int)index;
- (void)setTarget:(id)target;
- (void)clearAllSubViews;

-(void)setBtnBackGroundImage:(NSString * )imgName;
-(void)setBtnTitle:(NSString * )txt;
- (void)setCellData:(id)cellDt;

-(void)setFirstTxt:(NSString *)str;

-(void)setImgView:(NSString *)name;
- (BOOL)hasImage;
- (void)setImgURL:(NSString *)url;
- (void)loadImage;

@end

@protocol CustomTableViewCellDelegate <NSObject>
@optional

- (void)firstBtnPressedAtIndex:(int)index tableViewCell:(CustomTableViewCell *)cell;
- (void)secondBtnPressedAtIndex:(int)index;
- (void)thirdBtnPressedAtIndex:(int)index;
@end
