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
@end
@implementation SDPriceStarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame AndJiageArr:(NSArray *)jgArr AndXingjiArr:(NSArray *)xjArr
{
    self = [super initWithFrame:frame];
    if (self) {
        jiageArr =[[NSMutableArray alloc]initWithArray:jgArr];
        xingjiArr =[[NSMutableArray alloc]initWithArray:xjArr];
        
        subSmallArr =[[NSMutableArray alloc]init];
        
        
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    int height = mDeviceHeight - 364;
     UIView *bjView =[[UIView alloc]init];
    bjView.backgroundColor=fontHightRedColor;
    
    
    bjView.frame=CGRectMake(0, height,mDeviceWidth, 40);
    
    [self addSubview:bjView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(20, 0, 40, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    cancelBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    
    [cancelBtn  addTarget:self action:@selector(chongzhiClicked:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.tag=199;
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bjView addSubview: cancelBtn];
    
    
    //确认
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(self.frame.size.width-60, 0, 40, 40);
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    
    sureBtn.titleLabel.font =[UIFont systemFontOfSize:14];
    
    [sureBtn  addTarget:self action:@selector(chongzhiClicked:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag=299;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bjView addSubview: sureBtn];
    
    
    
    bjTableView =[[UIView alloc]init];
    bjTableView.backgroundColor=[UIColor whiteColor];
    bjTableView.frame=CGRectMake(0, height+40,mDeviceWidth, 300);
    [bjTableView setUserInteractionEnabled:YES];
    [self addSubview:bjTableView];
    
    //
    UILabel *jiagelabel = [[UILabel alloc] init];
    jiagelabel.frame = CGRectMake(20,0,mDeviceWidth, 40);
    jiagelabel.backgroundColor = [UIColor clearColor];
    jiagelabel.textColor = fontHightColor;
    jiagelabel.text = @"价格";
    jiagelabel.textAlignment = NSTextAlignmentLeft;
    jiagelabel.font = [UIFont systemFontOfSize:14];
    jiagelabel.numberOfLines = 0;
    [bjTableView addSubview:jiagelabel];
    
    jiageV =[[UIView alloc]init];
    jiageV.backgroundColor=[UIColor whiteColor];
    jiageV.frame=CGRectMake(0, 40,mDeviceWidth, 70);
    [jiageV setUserInteractionEnabled:YES];
    [bjTableView addSubview:jiageV];
    
    
    UILabel *xingjilabel = [[UILabel alloc] init];
    xingjilabel.frame = CGRectMake(20,110,mDeviceWidth, 40);
    xingjilabel.backgroundColor = [UIColor clearColor];
    xingjilabel.textColor = fontHightColor;
    xingjilabel.text = @"星级";
    xingjilabel.textAlignment = NSTextAlignmentLeft;
    xingjilabel.font = [UIFont systemFontOfSize:14];
    xingjilabel.numberOfLines = 0;
    [bjTableView addSubview:xingjilabel];
    
    xingjiV =[[UIView alloc]init];
    xingjiV.backgroundColor=[UIColor whiteColor];
    xingjiV.frame=CGRectMake(0, 150,mDeviceWidth, 100);
    [xingjiV setUserInteractionEnabled:YES];
    [bjTableView addSubview:xingjiV];
    
    // subArr =[[NSMutableArray alloc]initWithObjects:@"不限",@"¥150以下",@"¥150-300",@"¥301-450",@"¥451-600",@"¥601-1000",@"¥1000以上",nil];
    
    [self setupBtnWithBtnArr:jiageArr];
    
    // NSArray *arr =[[NSArray alloc]initWithObjects:@"不限",@"二星/经济",@"三星/舒适",@"四星/高档",@"五星/豪华",nil];
    [self setupBtnWithXijiBtnArr:xingjiArr];
    
    
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
        CGFloat btnVY =(margin +btnVH)*row; //y
        
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
        [jiageV addSubview: btn];
    }
}
-(void)btnClick:(UIButton *)cender{
    
    for (int i=0;i<jiageArr.count;i++){
        
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
                self.sdJiageBlock([jiageArr[i] objectForKey:@"value"]  );
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
        CGFloat btnVY =(margin +btnVH)*row;
        
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
        [xingjiV addSubview: btn];
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
            
            [subSmallArr addObject:xingjiArr[sender.tag - 100][@"value"]];
            sender.layer.borderColor=fontHightRedColor.CGColor;
        }else {
            sender.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
            [subSmallArr removeObject:xingjiArr[sender.tag - 100][@"value"]];
        }
        
    }
    
    subStr  =[subSmallArr componentsJoinedByString:@","];
    NSLog(@"subStr:%@",subStr);
    
    if (self.sdXingjiBlock) {
        self.sdXingjiBlock (subStr);
    }
    
}


/*
-(void)btnClicke:(UIButton *)sender{
    
    UIButton *btn =[self viewWithTag:sender.tag];
    UIButton *btn1 =[self viewWithTag:100];
    
    int index =(int)(sender.tag-100);
    
    if(btn.selected==YES){
        
        if (sender ==btn1){
            
            [subSmallArr removeAllObjects];
            btn.selected=YES;
            btn.layer.borderColor=fontHightRedColor.CGColor;
            [subSmallArr addObject:xingjiArr[index][@"value"]];
            
        }else {
            btn.selected=NO;
            btn.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
            [subSmallArr removeObject:xingjiArr[index][@"value"]];
        }
        
        
        
    } else {
        
        if (sender ==btn1){
            
            [subSmallArr removeObject:xingjiArr[index][@"value"]];
            
            btn.selected=NO;
            btn.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
            btn1.selected=YES;
            btn1.layer.borderColor=fontHightRedColor.CGColor;
            
        }else {
            btn.selected=YES;
            btn.layer.borderColor=fontHightRedColor.CGColor;
            [subSmallArr addObject:xingjiArr[index][@"value"]];
            btn1.selected=NO;
            btn1.layer.borderColor=[UIColor colorWithWhite:0.6 alpha:1].CGColor;
            
            
        }
        
        
        
    }
    
    
    //}
    
    
    subStr  =[subSmallArr componentsJoinedByString:@","];
    
    if (self.sdXingjiBlock) {
        self.sdXingjiBlock (subStr);
    }
}*/
-(void)chongzhiClicked:(UIButton *)sender{
    [self removeFromSuperview];
    if (sender.tag ==199){ //取消
        
    }else if (sender.tag==299){ //确定
        if (self.sdSureBlock){
            self.sdSureBlock();
        }
        
        
    }
}

@end
