//
//  ZFInfoView.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFAddressView : UIView
@property (nonatomic,strong) UITextField *inputFiled;

- (ZFAddressView *)initWithFrame:(CGRect)frame leftIcon:(NSString *)leftIcon title:(NSString *)title rightImageIcon:(NSString *)rightImage ;

@end
