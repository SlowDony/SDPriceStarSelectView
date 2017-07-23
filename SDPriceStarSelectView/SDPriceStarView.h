//
//  SDPriceStarView.h
//  SDPriceStarSelectView
//
//  Created by apple on 2017/1/23.
//  Copyright © 2017年 slowdony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDPriceStarView : UIView

+(instancetype)sdPriceStarView;

@property (nonatomic,copy) void (^sdPriceBlock)(NSString *priceID);

@property (nonatomic,copy) void (^sdStarBlock)(NSString *starID);

@property (nonatomic,copy) void (^sdSureBlock)();


/**
 星级arr
 */
@property (nonatomic,strong) NSMutableArray *starArr;


/**
 价格arr
 */
@property (nonatomic,strong) NSMutableArray *priceArr;
@end
