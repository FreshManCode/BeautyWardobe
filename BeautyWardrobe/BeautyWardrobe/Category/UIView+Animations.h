//
//  UIView+Animations.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <QuartzCore/QuartzCore.h>

@interface UIView (Animations)
- (void)opacityFrameAnimation:(UIView *)fromView toPoint:(CGPoint)point;

- (void)opacityFrameAnimation:(UIView *)fromView toTopPoint:(CGPoint)point;


- (UIImage *)createRoundedRectImage:(UIImage*)image size:(CGSize)size;


@end
