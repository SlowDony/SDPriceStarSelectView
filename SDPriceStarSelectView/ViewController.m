//
//  ViewController.m
//  SDPriceStarSelectView
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 slowdony. All rights reserved.
//

/*
 github: https://github.com/SlowDony/SDPriceStarSelectView
 如果有好的建议或者意见 ,欢迎指出.
 我的邮箱：devslowdony@gmail.com
 您的支持是对我最大的鼓励,谢谢. 求STAR ..😆
 */

#import "ViewController.h"

#import "SDPriceStarView.h"
#define mDeviceWidth [UIScreen mainScreen].bounds.size.width
#define mDeviceHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

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
    SDPriceStarView *priceStarView =[SDPriceStarView sdPriceStarView];
    
    priceStarView.sdPriceBlock=^(NSString *priceID){
        
        NSLog(@"价格ID:%@",priceID);

    };
    
    priceStarView.sdStarBlock=^(NSString *starID){
        
        NSLog(@"星级ID:%@",starID);
        
    };
    
    priceStarView.sdSureBlock=^(){
        //刷新数据
//        [weakSelf Refreshing];
    };
    
    [self.view addSubview:priceStarView];

}
@end
