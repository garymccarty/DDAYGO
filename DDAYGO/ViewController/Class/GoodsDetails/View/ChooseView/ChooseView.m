//
//  ChooseView.m
//  LvjFarm
//
//  Created by 张仁昊 on 16/4/14.
//  Copyright © 2016年 _____ZXHY_____. All rights reserved.
//

#import "ChooseView.h"
#import "UIView+Additions.h"
#import "PrefixHeader.pch"
#define FONT(s)       [UIFont systemFontOfSize:s]
#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height

#define BackgroundColor [UIColor colorWithRed:240/255.0f green:240/255.0f blue:244/255.0f alpha:1]
#define MainColor        [UIColor colorWithRed:24/255.0f green:161/255.0f blue:76/255.0f alpha:1]
@interface ChooseView ()

//规格分类
@property(nonatomic,strong)NSArray *rankArr;

@end

@implementation ChooseView

@synthesize alphaView,whiteView,headImage,LB_detail,LB_line,LB_price,LB_stock,LB_showSales,mainscrollview,cancelBtn,addBtn,buyBtn,stockBtn;

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.showSales = @"200";
        [self creatUI];
    }
    return self;
}



-(void)creatUI{
    
//   半透明视图
    alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_Width, screen_Height)];
    alphaView.backgroundColor = [UIColor clearColor];
    alphaView.alpha = 0.3;
    [self addSubview:alphaView];
    
//   装载商品信息的视图
    whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 280, screen_Width, screen_Height-280)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
//   商品图片
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, -10, 90, 90)];
    headImage.image = [UIImage imageNamed:@"product_04"];
    headImage.layer.cornerRadius = 4;
    headImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    headImage.layer.borderWidth = 1;
    [headImage.layer setMasksToBounds:YES];
    [whiteView addSubview:headImage];
    
    cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(screen_Width-40, 10, 25, 25);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:0];
    [whiteView addSubview:cancelBtn];
    
    
//   商品价格
    LB_price = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, 10, 150, 20)];
    LB_price.text = @"NT100";
    LB_price.textColor = MainColor;
    LB_price.font = ZP_NavTextdetaFont;
    [whiteView addSubview:LB_price];
    
//   商品库存
    LB_stock = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, CGRectGetMaxY(LB_price.frame), 80, 20)];
    LB_stock.text = NSLocalizedString(@"庫存100件", nil);
    LB_stock.textColor = [UIColor blackColor];
    LB_stock.font = ZP_stockFont;
    [whiteView addSubview:LB_stock];
    
//   已售件数
    LB_showSales = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(LB_stock.frame), CGRectGetMaxY(LB_price.frame), 80, 20)];
    LB_showSales.textColor = [UIColor blackColor];
    NSString *sellStr = [NSString stringWithFormat:NSLocalizedString(@"已售 %@ 件", nil),self.showSales];
    NSDictionary*subStrAttribute = @{
                                      NSForegroundColorAttributeName: [UIColor redColor],
                                      };
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:sellStr];
    [attributedText setAttributes:subStrAttribute range:NSMakeRange([sellStr rangeOfString:[self.showSales description]].location, [sellStr rangeOfString:[self.showSales description]].length)];
 
    LB_showSales.attributedText = attributedText;

    LB_showSales.font = ZP_stockFont;
    [whiteView addSubview:LB_showSales];
    
//   用户所选择商品的尺码和颜色
    LB_detail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+20, CGRectGetMaxY(LB_stock.frame), 150, 20)];
    LB_detail.text = NSLocalizedString(@"請選擇尺碼 顏色 規格", nil);
    LB_detail.numberOfLines = 0;
    LB_detail.textColor = [UIColor blackColor];
    LB_detail.font = ZP_stockFont;
    [whiteView addSubview:LB_detail];
//   分界线
    LB_line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame)+10, screen_Width, 0.5)];
    LB_line.backgroundColor = BackgroundColor;
    [whiteView addSubview:LB_line];
    
//   加入购物车按钮
    addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, whiteView.height-40, whiteView.frame.size.width/2, 40);
    [addBtn setBackgroundColor:MainColor];
    [addBtn setTitleColor:[UIColor whiteColor] forState:0];
    addBtn.titleLabel.font = ZP_addBtnTextdetaFont;
    [addBtn setTitle:NSLocalizedString(@"加入購物車", nil) forState:0];
    [whiteView addSubview:addBtn];
    
//   立即购买按钮
    buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(whiteView.frame.size.width/2,  whiteView.height-40, whiteView.frame.size.width/2, 40);
    [buyBtn setBackgroundColor:[UIColor colorWithRed:245/255.0f green:143/255.0f blue:43/255.0f alpha:1]];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:0];
    buyBtn.titleLabel.font = ZP_addBtnTextdetaFont;
    [buyBtn setTitle:NSLocalizedString(@"立即購買", nil) forState:0];
    [whiteView addSubview:buyBtn];
    
//   库存不足按钮
    stockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stockBtn.frame = CGRectMake(0,  whiteView.height-40, screen_Width, 40);
    [stockBtn setBackgroundColor:[UIColor lightGrayColor]];
    [stockBtn setTitleColor:[UIColor blackColor] forState:0];
    stockBtn.titleLabel.font = ZP_addBtnTextdetaFont;
    [stockBtn setTitle:NSLocalizedString(@"庫存不足", nil) forState:0];
    [whiteView addSubview:stockBtn];
//   默认隐藏
    stockBtn.hidden = YES;

//   有的商品尺码和颜色分类特别多 所以用UIScrollView 分类过多显示不全的时候可滑动查看
    mainscrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headImage.frame) + 10, screen_Width, whiteView.height-CGRectGetMaxY(headImage.frame)+10-60)];
    mainscrollview.backgroundColor = [UIColor clearColor];
    mainscrollview.contentSize = CGSizeMake(0, 200);
    mainscrollview.showsHorizontalScrollIndicator = NO;
    mainscrollview.showsVerticalScrollIndicator = NO;
    [whiteView addSubview:mainscrollview];

}




@end








