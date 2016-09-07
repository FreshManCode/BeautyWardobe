//
//  ZFInfoView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFAddressView.h"

@implementation ZFAddressView
- (ZFAddressView *)initWithFrame:(CGRect)frame leftIcon:(NSString *)leftIcon title:(NSString *)title rightImageIcon:(NSString *)rightImage {
    
    ZFAddressView *addressView = [[ZFAddressView alloc]initWithFrame:frame];
    addressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, (addressView.height-35)/2.0, 35, 35)];
    leftImage.image = [UIImage imageNamed:leftIcon];
    [addressView addSubview:leftImage];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(leftImage.right, 0, 70, addressView.height)];
    titleLab.text = title;
    titleLab.font = ZFFont(15.0f);
    titleLab.textColor = ZFRGBColor(100, 100, 100);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [addressView addSubview:titleLab];
    
    if ([rightImage length]>0) {
        UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(addressView.width-30, (addressView.height-45)/2.0, 45, 45)];
        rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [rightBtn setImage:[UIImage imageNamed:rightImage] forState:UIControlStateNormal];
        [addressView addSubview:rightBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(addressView.width-40, 10, 1.0f, addressView.height-20)];
        line.backgroundColor =  ZFRGBColor(216, 216, 216);
        [addressView addSubview:line];
    }
    CGFloat width = [rightImage length]>0? addressView.width-titleLab.right-5-45:addressView.width-titleLab.right-5;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(titleLab.right+5, 0, width, addressView.height)];
    textField.font = ZFFont(13.0f);
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.inputFiled = textField;
    [addressView addSubview:self.inputFiled];
    
    return addressView;
    
    
}
@end
