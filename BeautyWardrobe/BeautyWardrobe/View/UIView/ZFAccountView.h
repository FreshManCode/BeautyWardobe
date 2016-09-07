//
//  ZFAccountView.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFAccountView : UIView

@property (nonatomic,strong) UITextField *textFiled;

- (ZFAccountView *)accoutViewFrame:(CGRect)frame leftImageName:(NSString *)iamgeName placeHolder:(NSString *)placeHoler rightText:(NSString *)text;

@end
