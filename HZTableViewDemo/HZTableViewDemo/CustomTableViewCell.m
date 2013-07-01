//
//  CustomTableViewCell.m
//  Forum
//
//  Created by Lei Zhu on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CustomTableView.h"
@implementation CustomTableViewCell

@synthesize delegate,m_cellDt;

- (id)initWithFrame:(CGRect)frame cellType:(TABLE_VIEW_CELL_TYPE)type
{
    self = [super initWithFrame:frame];
    if (self) {
        m_cellType = type;
        switch (m_cellType) {
            case TABLE_VIEW_CELL_TYPE_DEFAULT:
            {
                m_firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,10,215,20)];
                
				m_firstLabel.backgroundColor = [UIColor clearColor];
				m_firstLabel.textAlignment = NSTextAlignmentCenter;
				m_firstLabel.font = [UIFont boldSystemFontOfSize:17];
				[self addSubview:m_firstLabel];
                
                m_secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,30,215,20)];
				m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.textColor = [UIColor darkGrayColor];
				m_secondLabel.textAlignment = NSTextAlignmentCenter;
				m_secondLabel.font = [UIFont systemFontOfSize:13];
				[self addSubview:m_secondLabel];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_LIVE_RECORD:
            {
                CGRect rect = CGRectMake(30, 0, 75, 50);
                m_firstLabel =[[UILabel alloc] initWithFrame:rect];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:12];
                [self addSubview:m_firstLabel];
                
                rect.origin.x = CGRectGetMaxX(rect)+10;
                rect.size.width = CGRectGetWidth(frame)-rect.origin.x -30;
                m_secondLabel = [[UILabel alloc] initWithFrame:rect];
                m_secondLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_secondLabel.font = [UIFont boldSystemFontOfSize:12];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                [self addSubview:m_secondLabel];
               
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_arrow_right.png"]];
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(540/2, (frame.size.height-image.size.height/2)/2, image.size.width/2,image.size.height/2)];
                imageView.image = image;
                imageView.backgroundColor = [UIColor clearColor];
                [self addSubview:imageView];
                [image release];
                [imageView release];
                
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, CGRectGetWidth(frame),1)];
                 image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_line.png"]];
                imageView.image = image;
                [self addSubview:imageView];
                [image release];
                [imageView release];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_UTILITY_MAP:
            {
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 15, 250, 20)];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:13];
                [self addSubview:m_firstLabel];
                
                m_secondLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(m_firstLabel.frame), 250, 30)];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_secondLabel.numberOfLines = 2;
				m_secondLabel.font = [UIFont systemFontOfSize:12];
                [self addSubview:m_secondLabel];
                
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_arrow_right.png"]];
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(540/2, (frame.size.height-image.size.height/2)/2, image.size.width/2,image.size.height/2)];
                imageView.image = image;
                imageView.backgroundColor = [UIColor clearColor];
                [self addSubview:imageView];
                [image release];
                [imageView release];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_CARCONSUME:
            {
                int kheight = CGRectGetHeight(frame);
                
                int kwidth = CGRectGetWidth(frame);
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_circle.png"]];
                CGRect rect = CGRectMake(50, (kheight-image.size.height/2)/2, image.size.width/2, image.size.height/2);
                m_firstBtn = [[UIButton alloc] initWithFrame:rect];
                [m_firstBtn setBackgroundImage:image forState:UIControlStateNormal];
//                [m_firstBtn setImage:image forState:UIControlStateNormal];
                m_firstBtn.titleLabel.font = [UIFont systemFontOfSize:12];
                [self addSubview:m_firstBtn];
                [image release];
                
                rect.origin.x = CGRectGetMaxX(rect)+15;//日期
                rect.size.width = 100;
                m_firstLabel = [[UILabel alloc] initWithFrame:rect];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.font = [UIFont systemFontOfSize:12];
                m_firstLabel.textColor = [UIColor colorWithRed:95.0f/255.0f green:98.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
                
                [self addSubview:m_firstLabel];
                
                rect.origin.x =  kwidth-20- 80;
                rect.size.width = kwidth - rect.origin.x-5;
                m_secondLabel = [[UILabel alloc] initWithFrame:rect];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.font = [UIFont systemFontOfSize:12];
                m_secondLabel.textColor = [UIColor colorWithRed:95.0f/255.0f green:98.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
                m_secondLabel.textAlignment = UITextAlignmentRight;
                [self addSubview:m_secondLabel];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_PARTS_PRICE:
            {
                int kTopSpacing = 0;
                CGRect rect = CGRectMake(0, kTopSpacing, 128/2, CGRectGetHeight(frame));
                m_firstLabel =[[UILabel alloc] initWithFrame:rect];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
                m_firstLabel.numberOfLines = 3;
                m_firstLabel.textAlignment = NSTextAlignmentCenter;
				m_firstLabel.font = [UIFont systemFontOfSize:11];
                m_firstLabel.adjustsFontSizeToFitWidth = YES;
                [self addSubview:m_firstLabel];
                
              
                
                rect = CGRectMake(CGRectGetMaxX(rect), kTopSpacing, 139/2,  CGRectGetHeight(frame));
                m_secondLabel =[[UILabel alloc] initWithFrame:rect];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_secondLabel.numberOfLines = 3;
                m_secondLabel.textAlignment = NSTextAlignmentCenter;
				m_secondLabel.font = [UIFont systemFontOfSize:10];
                [self addSubview:m_secondLabel];
                
                
                
                
                
                rect = CGRectMake(CGRectGetMaxX(rect), kTopSpacing, 39/2,  CGRectGetHeight(frame));
                m_thirdLabel  =[[UILabel alloc] initWithFrame:rect];
                m_thirdLabel.backgroundColor = [UIColor clearColor];
                m_thirdLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_thirdLabel.numberOfLines = 3;
                m_thirdLabel.textAlignment = NSTextAlignmentCenter;
				m_thirdLabel.font = [UIFont systemFontOfSize:11];
                [self addSubview:m_thirdLabel];
                
                
                
                
                rect = CGRectMake(CGRectGetMaxX(rect), kTopSpacing, 76/2,  CGRectGetHeight(frame));
                m_fourthLabel  =[[UILabel alloc] initWithFrame:rect];
                m_fourthLabel.backgroundColor = [UIColor clearColor];
                m_fourthLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_fourthLabel.numberOfLines = 3;
                m_fourthLabel.textAlignment = NSTextAlignmentCenter;
				m_fourthLabel.font = [UIFont systemFontOfSize:11];
                [self addSubview:m_fourthLabel];
                
                
                 
                rect = CGRectMake(CGRectGetMaxX(rect), kTopSpacing, 160/2,  CGRectGetHeight(frame));
                m_fifthLabel  =[[UILabel alloc] initWithFrame:rect];
                m_fifthLabel.backgroundColor = [UIColor clearColor];
                m_fifthLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_fifthLabel.numberOfLines = 3;
                m_fifthLabel.textAlignment = NSTextAlignmentCenter;
				m_fifthLabel.font = [UIFont systemFontOfSize:11];
                [self addSubview:m_fifthLabel];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_WORRYFREE_TIPS:
            {
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, 5, 250, 20)];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:13];
                [self addSubview:m_firstLabel];
                
                m_secondLabel =[[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(m_firstLabel.frame), 250, 30)];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_secondLabel.numberOfLines = 2;
				m_secondLabel.font = [UIFont systemFontOfSize:12];
                [self addSubview:m_secondLabel];
                
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_arrow_right.png"]];
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(540/2, 25, image.size.width/2,image.size.height/2)];
               
                imageView.image = image;
                [self addSubview:imageView];
                [image release];
                [imageView release];
                
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height-1, CGRectGetWidth(frame),1)];
                image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_line.png"]];
                imageView.image = image;
                [self addSubview:imageView];
                [image release];
                [imageView release];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_BRAND_ACTIVITY:
            {
                m_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 100, 70)];
                NSString * path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"image_temp_1.png"];
                UIImage * img = [[UIImage alloc] initWithContentsOfFile:path];
                m_imageView.tag = IMAGE_VIEW_TAG_UNLOADED;
                m_imageView.image = img;
                [self addSubview:m_imageView];
                [img release];
                
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(135, 14, 145, 15)];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:15];
                [self addSubview:m_firstLabel];
                
                m_secondLabel =[[UILabel alloc] initWithFrame:CGRectMake(135, CGRectGetMaxY(m_firstLabel.frame)+6, 140, 15)];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_secondLabel.numberOfLines = 2;
				m_secondLabel.font = [UIFont systemFontOfSize:12];
                [self addSubview:m_secondLabel];
                
                m_thirdLabel =[[UILabel alloc] initWithFrame:CGRectMake(135, CGRectGetMaxY(m_secondLabel.frame), 140, 15)];
                m_thirdLabel.backgroundColor = [UIColor clearColor];
                m_thirdLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_thirdLabel.numberOfLines = 2;
				m_thirdLabel.font = [UIFont systemFontOfSize:12];
                [self addSubview:m_thirdLabel];
                
                
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:FILENAME(@"image_show_detail.png")];
                UIImageView *detailImgView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(m_imageView.frame)+10, CGRectGetMaxY(m_thirdLabel.frame) - 2, image.size.width/2, image.size.height/2)];
                detailImgView.image = image;
                [self addSubview:detailImgView];
                [image release];
                [detailImgView release];
                
            }
                break;
            case TABLE_VIEW_CELL_TYPE_DEALERS_LOCATOR:
            {
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 250, 25)];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:13];
                [self addSubview:m_firstLabel];
                
                m_secondLabel =[[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(m_firstLabel.frame), 250, 25)];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.numberOfLines = 2;
                m_secondLabel.textColor = [UIColor colorWithRed:70/255.0 green:76/255.0 blue:71/255.0 alpha:1];
                m_secondLabel.numberOfLines = 2;
				m_secondLabel.font = [UIFont systemFontOfSize:11];
                [self addSubview:m_secondLabel];

            }
                break;
            case TABLE_VIEW_CELL_TYPE_CITY_SELECTED:
            {
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, CGRectGetHeight(frame))];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:13];
                [self addSubview:m_firstLabel];

            }
                break;
            case TABLE_VIEW_CELL_TYPE_MAINTENANCE_GUIDE:
            {
                frame.origin.x = MAINTENANCEGUIDE_LEFT_OFFSET;
                frame.size.width -=MAINTENANCEGUIDE_LEFT_OFFSET;
                m_secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(MAINTENANCEGUIDE_LEFT_OFFSET, 0, CGRectGetWidth(frame), 20)];
                m_secondLabel.backgroundColor = [UIColor clearColor];
                m_secondLabel.lineBreakMode = UILineBreakModeWordWrap;
                m_secondLabel.numberOfLines = 0;
                m_secondLabel.text = @"检查:";
                m_secondLabel.font = [UIFont boldSystemFontOfSize:14];
                [self addSubview:m_secondLabel];
                
                m_firstLabel = [[UILabel alloc] initWithFrame:frame];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.lineBreakMode = UILineBreakModeWordWrap;
                m_firstLabel.numberOfLines = 0;
                m_firstLabel.font = [UIFont systemFontOfSize:14];
                [self addSubview:m_firstLabel];
                
                
                m_thirdLabel = [[UILabel alloc] initWithFrame:frame];
                m_thirdLabel.backgroundColor = [UIColor clearColor];
                m_thirdLabel.lineBreakMode = UILineBreakModeWordWrap;
                m_thirdLabel.numberOfLines = 0;
                m_thirdLabel.text = @"更换:";
                m_thirdLabel.font = [UIFont boldSystemFontOfSize:14];
                [self addSubview:m_thirdLabel];
                
                m_fourthLabel = [[UILabel alloc] initWithFrame:frame];
                m_fourthLabel.backgroundColor = [UIColor clearColor];
                m_fourthLabel.lineBreakMode = UILineBreakModeWordWrap;
                m_fourthLabel.numberOfLines = 0;
                m_fourthLabel.font = [UIFont systemFontOfSize:14];
                [self addSubview:m_fourthLabel];
                
            }
                break;
            case TABLE_VIEW_CELL_TYPE_CAR_SELECTED:
            {
                m_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 224/2, 150/2)];
                [self addSubview:m_imageView];
                
                m_firstLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(m_imageView.frame)+15, 10, 130, 75)];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:100/255.0 green:105/255.0 blue:110/255. alpha:1];
                [self addSubview:m_firstLabel];
                
                
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_arrow_right.png"]];
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(540/2, 40, image.size.width/2,image.size.height/2)];
                
                imageView.image = image;
                [self addSubview:imageView];
                [image release];
                [imageView release];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_CAR_TYPE_SELECTED:
            {
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, CGRectGetHeight(frame))];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:13];
                [self addSubview:m_firstLabel];
            }
                break;
            case TABLE_VIEW_CELL_TYPE_CAR_INSTRU:
            {   
                m_firstLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 250, CGRectGetHeight(frame))];
                m_firstLabel.backgroundColor = [UIColor clearColor];
                m_firstLabel.textColor = [UIColor colorWithRed:80/255.0 green:86/255.0 blue:91/255.0 alpha:1];
				m_firstLabel.font = [UIFont boldSystemFontOfSize:13];
                [self addSubview:m_firstLabel];
                
                
                UIImage * image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"img_arrow_right.png"]];
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(540/2, (CGRectGetHeight(frame)-image.size.height/2)/2, image.size.width/2,image.size.height/2)];
                imageView.image = image;
                [self addSubview:imageView];
                [image release];
                [imageView release];
            }
                break;
            default:
            {
                
            }
                break;
        }
    }
    return self;
}

-(void)setBtnBackGroundImage:(NSString * )imgName
{
    UIImage * img = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:imgName]];
    [m_firstBtn setBackgroundImage:img forState:UIControlStateNormal];
    [img release];
}

-(void)setImgView:(NSString *)name
{
    UIImage * image = [[UIImage alloc] initWithContentsOfFile:FILENAME(name)];
    if (m_cellType == TABLE_VIEW_CELL_TYPE_CAR_SELECTED) {
        
        m_imageView.frame = CGRectMake(m_imageView.frame.origin.x-15, m_imageView.frame.origin.y, image.size.width/2, image.size.height/2);
    }
    m_imageView.image = image;
    [image release];
}

-(void)setBtnTitle:(NSString * )txt
{
    [m_firstBtn setTitle:txt forState:UIControlStateNormal];
}

- (void)setFirstLabelText:(NSString *)txt
{
    if ([txt isEqualToString:@""]) {
        txt = @"-";
    }
    m_firstLabel.text = txt;    
}


-(void)setFirstTxt:(NSString *)str
{
    m_firstTxt.text = str;
}

- (void)setSecondLabelText:(NSString *)txt
{
    
    m_secondLabel.text = txt;
    switch (m_cellType) {
        case TABLE_VIEW_CELL_TYPE_UTILITY_MAP:
        {
            CGSize size = [[ConfigData shareInstance] getSizeOfStr:txt font:[UIFont systemFontOfSize:12]];
            //NSLog(@"%.2f",size.width);
            if (size.width >= CGRectGetWidth(m_secondLabel.frame)) {
                CGRect frame = m_firstLabel.frame;
                frame.origin.y -= 5;
                m_firstLabel.frame = frame;
                frame = m_secondLabel.frame;
                frame.origin.y -= 5;
                m_secondLabel.frame = frame;
            }else{
                CGRect frame = m_secondLabel.frame;
                frame.size.height -= 13;
                m_secondLabel.frame = frame;
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)setCellFrame
{
    CGRect  cellFrame = m_secondLabel.frame;
    
    CGSize s = [m_firstLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(CGRectGetWidth(cellFrame), 1000) lineBreakMode:UILineBreakModeWordWrap];//求文本的大小
    m_firstLabel.font =[UIFont systemFontOfSize:14];//不能少这句话，与上边的字大小一致
    int cnt= s.height;
    m_firstLabel.lineBreakMode = UILineBreakModeWordWrap;
    m_firstLabel.numberOfLines = 0;
    cellFrame.origin.y = CGRectGetMaxY(cellFrame);
    cellFrame.size.height = s.height;
    m_firstLabel.frame = cellFrame;
    
    cellFrame.origin.y = CGRectGetMaxY(cellFrame);
    cellFrame.size.height = 20;
    m_thirdLabel.frame = cellFrame;
    
    
    s = [m_fourthLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(CGRectGetWidth(cellFrame), 1000) lineBreakMode:UILineBreakModeWordWrap];//求文本的大小
    m_fourthLabel.font =[UIFont systemFontOfSize:14];//不能少这句话，与上边的字大小一致
    m_fourthLabel.lineBreakMode = UILineBreakModeWordWrap;
    m_fourthLabel.numberOfLines = 0;
    m_fourthLabel.backgroundColor = [UIColor clearColor];
    cellFrame.origin.y = CGRectGetMaxY(cellFrame);
    cellFrame.size.height = s.height;
    m_fourthLabel.frame = cellFrame;
}

- (void)setThirdLabelText:(NSString *)txt
{
    m_thirdLabel.text = txt;
}

- (void)setFourthLabelText:(NSString *)txt
{
    m_fourthLabel.text = txt;
}

- (void)setFifthLabelText:(NSString *)txt
{
    m_fifthLabel.text = txt;
}

- (void)setSixthLabelText:(NSString *)txt
{
    m_sixthLabel.text = txt;
}

- (void)firstBtnPressed:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(firstBtnPressedAtIndex:tableViewCell:)]) {
        [delegate firstBtnPressedAtIndex:m_index tableViewCell:self];
    }
}

- (void)secondBtnPressed:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(secondBtnPressedAtIndex:)]) {
        [delegate secondBtnPressedAtIndex:m_index];
    }
}

- (void)thirdBtnPressed:(UIButton *)sender
{
    if ([delegate respondsToSelector:@selector(thirdBtnPressedAtIndex:)]) {
        [delegate thirdBtnPressedAtIndex:m_index];
    }
}

- (void)clearAllSubViews
{
    for (id view in [self subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            ((UIImageView *)view).image = nil;
        }
        [view removeFromSuperview];
    }
}

- (void)setIndex:(int)index
{
	m_index = index;
}

- (void)setCellData:(id)cellDt
{
    m_cellDt = cellDt;
}

- (void)setImgURL:(NSString *)url
{
    NSLog(@"url====%@",url);
    imgURL = url;
    [imgURL retain];
}

- (BOOL)hasImage
{
    if (m_imageView.tag == IMAGE_VIEW_TAG_UNLOADED) {
        return NO;
    }else if (m_imageView.tag == IMAGE_VIEW_TAG_LOADED){
        return YES;
    }
    return YES;
}

- (void)loadImage
{
    NSURL * URL = [NSURL URLWithString:imgURL];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    UIImage *cachedImage = [manager imageWithURL:URL];
    if (cachedImage) {
            m_imageView.image = cachedImage;
    } else {
        // Start an async download
        [manager downloadWithURL:URL delegate:self];
         
    }
}

-(void)doAnimation:(UIView*)views
{
	CATransition *animation = [CATransition animation];
	animation.delegate = self;
	animation.duration = 0.5f;
	animation.timingFunction = UIViewAnimationCurveEaseInOut;
	animation.fillMode = kCAFillModeForwards;
	animation.endProgress = 1;
	animation.removedOnCompletion = NO;
	animation.type = @"oglFlip";//---
	[views.layer addAnimation:animation forKey:@"animation"];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image forURL:(NSURL *)url
{
    
    NSLog(@"url__finshload====%@",url);
    m_imageView.image = image;
    m_imageView.tag = IMAGE_VIEW_TAG_LOADED;
//    [self performSelectorOnMainThread:@selector(doAnimation:) withObject:m_imageView waitUntilDone:YES];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error forURL:(NSURL *)url
{
    
}


- (void)dealloc {
	if (m_imageView) {
        m_imageView.image = nil;
//        [m_imageView.image release];
		[m_imageView release];
	}
    if (m_seperateLine) {
        m_seperateLine.image = nil;
//        [m_seperateLine.image release];
		[m_seperateLine release];
	}
    
    if (left_imgView) {
        left_imgView.image = nil;
//        [left_imgView.image release];
		[left_imgView release];
	}
    
    if (right_imgView) {
        right_imgView.image = nil;
//        [right_imgView.image release];
		[right_imgView release];
	}
	if (m_firstLabel) {
		[m_firstLabel release];
	}
	if (m_secondLabel) {
		[m_secondLabel release];
	}
	if (m_thirdLabel) {
		[m_thirdLabel release];
	}
	if (m_fourthLabel) {
		[m_fourthLabel release];
	}
	if (m_fifthLabel) {
		[m_fifthLabel release];
	}
	if (m_sixthLabel) {
		[m_sixthLabel release];
	}
    if (imgURL) {
        [imgURL release];
    }
    [super dealloc];
}


@end
