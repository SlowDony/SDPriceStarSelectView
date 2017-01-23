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
@property (nonatomic,copy) void (^sdJiageBlock)(NSString *jiageID);

@property (nonatomic,copy) void (^sdXingjiBlock)(NSString *xingjiID);

@property (nonatomic,copy) void (^sdSureBlock)();
@end
