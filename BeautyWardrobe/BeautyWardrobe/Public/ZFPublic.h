//
//  ZFPublic.h
//  PaySDKDemo
//
//  Created by ZhangJunjun on 16/4/22.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RealReachability.h>

@interface ZFPublic : NSObject

+ (UIImage *)bundleImageName:(NSString *)imageName;

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize;

+ (void)showMessage:(NSString *)message;

+ (void)updateWindowsWithTitle:(NSString *)title;
+ (void)updateWindowsWithTitle:(NSString *)title withTime:(CGFloat)time;
+ (void)updateWindowsWithTitle:(NSString *)title subTitle:(NSString *)subTitle expiredTime:(NSString *)time;

+ (BOOL)userIsLogin;




@end
