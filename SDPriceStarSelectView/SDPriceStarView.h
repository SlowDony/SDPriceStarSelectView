//
//  SDPriceStarView.h
//  SDPriceStarSelectView
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPriceStarView : UIView
- (instancetype)initWithFrame:(CGRect)frame AndJiageArr:(NSArray *)jiageArr AndXingjiArr:(NSArray *)xingjiArr;
+(instancetype)sdPriceStarView;
@property (nonatomic,copy) void (^sdJiageBlock)(NSString *jiageID);

@property (nonatomic,copy) void (^sdXingjiBlock)(NSString *xingjiID);

@property (nonatomic,copy) void (^sdSureBlock)();


@property (nonatomic,strong) NSMutableArray *starArr;//   星级arr
@property (nonatomic,strong) NSMutableArray *priceArr;//  价格arr
@end
