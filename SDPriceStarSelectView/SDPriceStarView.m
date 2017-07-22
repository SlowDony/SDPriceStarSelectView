//
//  SDPriceStarView.m
//  SDPriceStarSelectView
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "SDPriceStarView.h"



#define mDeviceWidth [UIScreen mainScreen].bounds.size.width
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height


#define mRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define mHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define mHexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define fontHightRedColor mHexRGB(0xeb3027) //字体深红色
#define fontHightColor mHexRGB(0x585858) //字体深色
#define fontNomalColor mHexRGB(0x999999) //字体浅色



#define bjviewheight   290


@interface SDPriceStarView ()

{
    NSMutableArray *subSmallArr; //星级选择
    NSMutableArray* jiageArr; //价格
    NSMutableArray* xingjiArr; //星际
    UIView *bjTableView;
    
    UIView *jiageV; //价格v
    UIView *xingjiV; //星级v
    NSString *subStr;  //星级选择
}


@property (nonatomic,strong)UIView *starView; //星级view
@property (nonatomic,strong)UIView *priceView; //价格view
@property (nonatomic,strong)UIView *bjView ;  //背景
/*
确定按钮
 */
@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)UIButton *cancelBtn;//取消按钮




@end


@implementation SDPriceStarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIView *)starView{
    if (!_starView){
        _starView =[[UIView alloc]init];
        _starView.backgroundColor=[UIColor whiteColor];
        _starView.frame=CGRectMake(0, 150,mDeviceWidth, 140);
        [_starView setUserInteractionEnabled:YES];
        
        UILabel *starLabel = [[UILabel alloc] init];
        starLabel.frame = CGRectMake(20,0,mDeviceWidth, 40);
        starLabel.backgroundColor = [UIColor clearColor];
        starLabel.textColor = fontHightColor;
        starLabel.text = @"星级";
        starLabel.textAlignment = NSTextAlignmentLeft;
        starLabel.font = [UIFont systemFontOfSize:14];
        starLabel.numberOfLines = 0;
        [_starView addSubview:starLabel];
        
        
    }
    return _starView;
}

-(UIView *)priceView{
    if (!_priceView){
        _priceView =[[UIView alloc]init];
        _priceView.backgroundColor=[UIColor whiteColor];
        _priceView.frame=CGRectMake(0, 40,mDeviceWidth, 70+40);
        [_priceView setUserInteractionEnabled:YES];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.frame = CGRectMake(20,0,mDeviceWidth, 40);
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = fontHightColor;
        priceLabel.text = @"价格";
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.numberOfLines = 0;
        
        [_priceView addSubview:priceLabel];

    }
    return _priceView;
}

-(UIView *)bjView{
    if (!_bjView) {
        _bjView =[[UIView alloc]init];
        _bjView.frame=CGRectMake(0, mDeviceHeight,mDeviceWidth, 0);
        _bjView.backgroundColor=[UIColor redColor];
        [_bjView addSubview:self.cancelBtn];
        [_bjView addSubview:self.sureBtn];
        [_bjView addSubview:self.priceView];
        [_bjView addSubview:self.starView];
    }
    
    return _bjView;
}

-(UIButton *)sureBtn{
   
    if (!_sureBtn) {
        //确认
        _sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _sureBtn.frame = CGRectMake(mDeviceWidth-60, 0, 40, 40);
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.titleLabel.font =[UIFont systemFontOfSize:14];
        [_sureBtn  addTarget:self action:@selector(chongzhiClicked:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.tag=299;
    }
    return _sureBtn;
}

-(UIButton *)cancelBtn{
    if (!_sureBtn){
        //取消
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(20, 0, 40, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font =[UIFont systemFontOfSize:14];
        [_cancelBtn  addTarget:self action:@selector(chongzhiClicked:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.tag=199;
    }
    return _cancelBtn;
}



-(NSMutableArray *)starArr{
    if (!_starArr) {
        
        NSArray* arr = @[@{@"title":@"不限",@"value":@""},
                         @{@"title":@"二星/经济",@"value":@"1"},
                         @{@"title":@"三星/舒适",@"value":@"2"},
                         @{@"title":@"四星/高档",@"value":@"3"},
                         @{@"title":@"五星/豪华",@"value":@"4"},
                         ];
        _starArr =[[NSMutableArray alloc]initWithArray:arr];
    }
    return _starArr;
}

-(NSMutableArray *)priceArr{
    if (!_priceArr)
    {
        NSArray *  arr = @[@{@"title":@"不限",@"value":@"0"},
                           @{@"title":@"¥150以内",@"value":@"1"},
                           @{@"title":@"¥150-300",@"value":@"2"},
                           @{@"title":@"¥301-450",@"value":@"3"},
                           @{@"title":@"¥451-600",@"value":@"4"},
                           @{@"title":@"¥601-1000",@"value":@"5"},
                           @{@"title":@"¥1000以上",@"value":@"6"},
                           ];
       
        _priceArr =[[NSMutableArray alloc]initWithArray:arr];
    }
    return _priceArr;
}



//-(void)setStarArr:(NSMutableArray *)starArr{
  //  _starArr =starArr;
    
    
//}

//-(void)setPriceArr:(NSMutableArray *)priceArr{
  //  _priceArr =priceArr;
 
//}

+(instancetype)sdPriceStarView
{
    SDPriceStarView *starView =[[SDPriceStarView alloc]init];
    [starView setUI];
    return starView;
}


- (instancetype)initWithFrame:(CGRect)frame AndJiageArr:(NSArray *)jgArr AndXingjiArr:(NSArray *)xjArr
{
    self = [super initWithFrame:frame];
    if (self) {
        jiageArr =[[NSMutableArray alloc]initWithArray:jgArr];
        xingjiArr =[[NSMutableArray alloc]initWithArray:xjArr];
        
        
        
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    subSmallArr =[[NSMutableArray alloc]init];

    self.frame =CGRectMake(0, 0, mDeviceWidth, mDeviceHeight);
    [self addSubview:self.bjView];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bjView.frame=CGRectMake(0, mDeviceHeight -bjviewheight,mDeviceWidth, bjviewheight);
    }];
   
    //
    
    [self setupBtnWithBtnArr:self.priceArr];

    [self setupBtnWithXijiBtnArr:self.starArr];
    
}

/**
 *  添加九宫格按钮
 */
-(void)setupBtnWithBtnArr:(NSMutableArray *)arr {
    
    //
    int totalloc =4;
    CGFloat btnVW = (mDeviceWidth-10*5)/4; //宽
    CGFloat btnVH = 30; //高
    CGFloat margin =10; //间距
    int count =(int)arr.count;
    for (int i=0;i<count;i++){
        int row =i/totalloc;  //行号
        int loc =i%totalloc;  //列号
        CGFloat btnVX =margin+(margin +btnVW)*loc; //x
        CGFloat btnVY =40+(margin +btnVH)*row; //y
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnVX, btnVY, btnVW, btnVH);
        [btn setTitle:[NSString stringWithFormat:@"%@",arr[i][@"title"]] forState:UIControlStateNormal];
        
        [btn setTitleColor:fontHightRedColor forState:UIControlStateSelected];
        [btn setTitleColor:fontNomalColor forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:10];
        btn.tag=i+1000;
        btn.layer.cornerRadius=5;
        btn.layer.borderColor =[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        
        btn.layer.borderWidth=0.6;
        [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.priceView addSubview: btn];
    }
}
-(void)btnClick:(UIButton *)cender{
    
    for (int i=0;i<self.priceArr.count;i++){
        
        UIButton *btn = [self viewWithTag:i+1000];
        
        if(btn.tag!=cender.tag){
            btn.layer.borderColor =[UIColor colorWithWhite:0.6 alpha:1].CGColor;
            btn.layer.borderWidth=0.6;
            btn.selected=NO;
            
        }else {
            
            btn.layer.borderColor =fontHightRedColor.CGColor;
            btn.layer.borderWidth=0.6;
            btn.selected=YES;
            
            
            if (self.sdJiageBlock){
                self.sdJiageBlock([self.priceArr[i] objectForKey:@"value"]  );
            }
            
            
        }
    }
}

#pragma mark - 选择星级标签

-(void)setupBtnWithXijiBtnArr:(NSArray *)arr {
    
    //
    int totalloc =3;
    CGFloat btnVW = (mDeviceWidth-10*4)/3; //宽
    CGFloat btnVH = 30; //高
    CGFloat margin =10; //间距
    int count =(int)arr.count;
    for (int i=0;i<count;i++){
        int row =i/totalloc;  //行号
        int loc =i%totalloc;  //列号
        CGFloat btnVX =margin+(margin +btnVW)*loc;
        CGFloat btnVY =40+(margin +btnVH)*row;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnVX, btnVY, btnVW, btnVH);
        [btn setTitle:[NSString stringWithFormat:@"%@",arr[i][@"title"]] forState:UIControlStateNormal];
        [btn setTitleColor:fontHightRedColor forState:UIControlStateSelected];
        [btn setTitleColor:fontNomalColor forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:10];
        btn.tag=i+100;
        btn.layer.cornerRadius=5;
        btn.layer.borderColor =[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        btn.layer.borderWidth=0.6;
        [btn  addTarget:self action:@selector(btnClicke1:) forControlEvents:UIControlEventTouchUpInside];
        [self.starView addSubview: btn];
    }
}

-(void)btnClicke1:(UIButton *)sender{
    
    if (sender.tag == 100) {
        
        [subSmallArr removeAllObjects];
        sender.layer.borderColor=fontHightRedColor.CGColor;
        sender.selected = YES;
        
        for ( int i =1; i<5; i++) {
            
            UIButton *button1 = (UIButton *)[self viewWithTag:100+i];
            button1.selected = NO;
            button1.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        }
        
    }
    else
    {
        UIButton *button = (UIButton *)[self viewWithTag:100];
        
        button.selected = NO;
        button.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
        
        sender.selected = !sender.selected;
        
        if (sender.selected) {
            
            [subSmallArr addObject:self.starArr[sender.tag - 100][@"value"]];
            sender.layer.borderColor=fontHightRedColor.CGColor;
        }else {
            sender.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
            [subSmallArr removeObject:self.starArr[sender.tag - 100][@"value"]];
        }
        
    }
    
    subStr  =[subSmallArr componentsJoinedByString:@","];
    NSLog(@"subStr:%@",subStr);
    
    if (self.sdXingjiBlock) {
        self.sdXingjiBlock (subStr);
    }
    
}


-(void)chongzhiClicked:(UIButton *)sender{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bjView.frame =CGRectMake(0, mDeviceHeight, mDeviceWidth, 0);

    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];
    
  
  
    if (sender.tag ==199){ //取消
        
    }else if (sender.tag==299){ //确定
        if (self.sdSureBlock){
            self.sdSureBlock();
        }
        
        
    }
}

@end
