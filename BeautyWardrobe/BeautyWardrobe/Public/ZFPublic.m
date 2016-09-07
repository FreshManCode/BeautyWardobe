//
//  ZFPublic.m
//  PaySDKDemo
//
//  Created by ZhangJunjun on 16/4/22.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFPublic.h"
#import "ZFAddressView.h"
#import "ZFUserDefaults.h"


@implementation ZFPublic

+ (UIImage *)bundleImageName:(NSString *)imageName {
    static NSString *heepayImageBundle = @"MBProghud.bundle";
    NSString *bundlePath = [[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:heepayImageBundle];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (image) {
        return image;
    } else {
        NSArray *array = [imageName componentsSeparatedByString:@".png"];
        imageName = [NSString stringWithFormat:@"%@%@%@",array[0],@"@2x",@".png"];
        return [UIImage imageWithContentsOfFile:[bundlePath stringByAppendingPathComponent:imageName]];
    }
}


+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *dic  = @{NSFontAttributeName:font};
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

+ (void)showMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
    
}

+ (void)updateWindowsWithTitle:(NSString *)title {
    UIWindow *windoe = [[UIApplication sharedApplication]keyWindow];
    CGSize size = [ZFPublic sizeWithString:title font:[UIFont systemFontOfSize:15.0f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat viewWidth  = size.width  +40;
    CGFloat viewHeight = size.height +50;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((ZFScreenWidth -viewWidth)/2.0, (ZFScreenHeight -viewHeight)/2.0, viewWidth, viewHeight)];
    view.backgroundColor = ZFRGBColor(219, 81, 128);
    view.layer.cornerRadius = 8.0f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, size.width, size.height)];
    label.text = title;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [windoe addSubview:view];
    [view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
}

+ (void)updateWindowsWithTitle:(NSString *)title withTime:(CGFloat)time {
    UIWindow *windoe = [[UIApplication sharedApplication]keyWindow];
    CGSize size = [ZFPublic sizeWithString:title font:[UIFont systemFontOfSize:15.0f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat viewWidth  = size.width  +40;
    CGFloat viewHeight = size.height +50;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((ZFScreenWidth -viewWidth)/2.0, (ZFScreenHeight -viewHeight)/2.0, viewWidth, viewHeight)];
    view.backgroundColor = ZFRGBColor(219, 81, 128);
    view.layer.cornerRadius = 8.0f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, size.width, size.height)];
    label.text = title;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [windoe addSubview:view];
    [view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });

}
+ (void)updateWindowsWithTitle:(NSString *)title subTitle:(NSString *)subTitle expiredTime:(NSString *)time {
    UIWindow *winodw = [[UIApplication sharedApplication]keyWindow];
    CGSize size  = [ZFPublic sizeWithString:time font:ZFFont(15.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize size1 = [ZFPublic sizeWithString:title font:ZFFont(17.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize size2 = [ZFPublic sizeWithString:subTitle font:ZFFont(15.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize maxSize;
    if (size.width >size1.width) {
        if (size.width >size2.width) {
            maxSize = size;
        }
    }else if (size1.width >size2.width){
        maxSize = size1;
    }else {
        maxSize = size2;
    }
    
    CGFloat viewWidth  = maxSize.width +100;
    CGFloat viewHeight = 260;
    ZFAddressView *view = [[ZFAddressView alloc]initWithFrame:CGRectMake((ZFScreenWidth -viewWidth)/2.0, (ZFScreenHeight -viewHeight)/2.0, viewWidth, viewHeight)];
    view.tag = 100;
    view.backgroundColor = [UIColor whiteColor];
    [winodw addSubview:view];
    
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 110)];
    topImage.image = [UIImage imageNamed:@"image_shake_success"];
    [view addSubview:topImage];
    
//    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(topImage.width-50, 10, 50, 50)];
//    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"商品详情页关闭按钮"] forState:UIControlStateNormal];
//    [deleteBtn addTarget:self action:@selector(deleteRewardsInfoView) forControlEvents:UIControlEventTouchUpInside];
//    [topImage addSubview:deleteBtn];
//    UIView *tapView = [[UIView alloc]initWithFrame:deleteBtn.frame];
//    [view addSubview:tapView];
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteRewardsInfoView)];
//    [tapView addGestureRecognizer:tapGesture];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, topImage.bottom+10, viewWidth, 17)];
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = ZFRGBColor(219, 81, 128);
    [view addSubview:titleLab];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLab.bottom+15, viewWidth, 15.0f)];
    infoLabel.text = subTitle;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = ZFRGBColor(100, 100, 100);
    infoLabel.font = ZFFont(15.0f);
    [view addSubview:infoLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, infoLabel.bottom+8, viewWidth, 15.0f)];
    timeLabel.text = time;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = ZFRGBColor(100, 100, 100);
    timeLabel.font = ZFFont(15.0f);
    [view addSubview:timeLabel];
    
    UIButton *lookBtn = [[UIButton alloc]initWithFrame:CGRectMake((viewWidth -maxSize.width)/2.0, viewHeight-40, maxSize.width, 30)];
    [lookBtn setBackgroundColor:ZFRGBColor(219, 81, 128)];
    [lookBtn setTitle:@"查看" forState:UIControlStateNormal];
    [lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lookBtn.titleLabel.font = ZFFont(15.0f);
    [lookBtn addTarget:self action:@selector(lookRewardsInfo:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lookBtn];
    
}

+ (BOOL)userIsLogin {
    if ([[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID].length>0) {
        return YES;
    }else{
        return NO;
    }
}


#pragma mark-----方法传到摇一摇界面进行处理
- (void)lookRewardsInfo:(UIButton *)sender {
//    [[NSNotificationCenter defaultCenter]postNotificationName:kUserLookReward object:nil];
}






@end
