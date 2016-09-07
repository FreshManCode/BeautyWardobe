//
//  ZFTipsView.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFTipsView : UIView

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UILabel *textLabel;

@property (nonatomic,assign)NSTimeInterval during;

- (void)showInView:(UIView *)superView;
- (void)dismiss;

+ (void)showText:(NSString *)text;
+ (void)showText:(NSString *)text withOriginY:(CGFloat)y;
+ (void)showText:(NSString *)text inView:(UIView *)superView withOriginY:(CGFloat)y;



@end
