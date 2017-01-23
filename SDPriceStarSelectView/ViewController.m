//
//  ViewController.m
//  SDPriceStarSelectView
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import "ViewController.h"

#import "SDPriceStarView.h"
#define mDeviceWidth [UIScreen mainScreen].bounds.size.width
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
{
    SDPriceStarView *priceStarView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUI{
    
    //
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 50);
    [btn setTitle:@"星级价格选择" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    btn.backgroundColor =[UIColor redColor];
    [btn  addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    
    
    
    
    
}
-(void)btnClick:(UIButton *)sender{
//    __weak __typeof__(self) weakSelf = self;
  NSArray *  jgArr = @[@{@"title":@"不限",@"value":@"0"},
              @{@"title":@"¥150以内",@"value":@"1"},
              @{@"title":@"¥150-300",@"value":@"2"},
              @{@"title":@"¥301-450",@"value":@"3"},
              @{@"title":@"¥451-600",@"value":@"4"},
              @{@"title":@"¥601-1000",@"value":@"5"},
              @{@"title":@"¥1000以上",@"value":@"6"},
              ];
    
    NSArray* xjArr = @[@{@"title":@"不限",@"value":@""},
              @{@"title":@"二星/经济",@"value":@"1"},
              @{@"title":@"三星/舒适",@"value":@"2"},
              @{@"title":@"四星/高档",@"value":@"3"},
              @{@"title":@"五星/豪华",@"value":@"4"},
              ];
    
    priceStarView =[[SDPriceStarView alloc]initWithFrame:CGRectMake(0, 0, mDeviceWidth, mDeviceHeight)AndJiageArr:jgArr AndXingjiArr:xjArr];
    
    
    priceStarView.sdJiageBlock=^(NSString *jiageID){
        
        NSLog(@"价格ID:%@",jiageID);
        
        
        
    };
    
    priceStarView.sdXingjiBlock=^(NSString *xingjiID){
        NSLog(@"星级ID:%@",xingjiID);
        
    };
    
    priceStarView.sdSureBlock=^(){
        //刷新数据
//        [weakSelf Refreshing];
    };
    
    [self.view addSubview:priceStarView];

}
@end
