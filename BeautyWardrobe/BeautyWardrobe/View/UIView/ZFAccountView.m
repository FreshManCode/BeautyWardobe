//
//  ZFAccountView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFAccountView.h"

@implementation ZFAccountView

- (ZFAccountView *)accoutViewFrame:(CGRect)frame leftImageName:(NSString *)iamgeName placeHolder:(NSString *)placeHoler rightText:(NSString *)text {
    
    ZFAccountView *accountView   = [[ZFAccountView alloc]initWithFrame:frame];
    accountView.backgroundColor  = ZFRGBColor(231, 231, 231);
    accountView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIImageView *leftIconImage   = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 25, accountView.height-10)];
    leftIconImage.image          = [UIImage imageNamed:iamgeName];
    [accountView addSubview:leftIconImage];
    
    UIView *lineView             = [[UIView alloc]initWithFrame:CGRectMake(leftIconImage.right+10, 5, 0.5, accountView.height-10)];
    lineView.backgroundColor = ZFRGBColor(216, 216, 216);
    [accountView addSubview:lineView];
    
    UITextField *textFiled       =[[UITextField alloc]initWithFrame:CGRectMake(lineView.right+2, 0, accountView.width-lineView.right-2-75, accountView.height)];
    textFiled.autoresizingMask   = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
    textFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textFiled.placeholder        = placeHoler;
    textFiled.font               = [UIFont systemFontOfSize:(ZF_IS_IPHONE4OR5?15:17)];
    self.textFiled               = textFiled;
    [accountView addSubview:self.textFiled];
    
    UILabel *rightLabel          = [[UILabel alloc]initWithFrame:CGRectMake(accountView.right-90, 0, 75, accountView.height-5)];
    rightLabel.text              = text;
    rightLabel.font              = [UIFont systemFontOfSize:15];
    rightLabel.textColor         = ZFRGBColor(255, 69, 125);
    [accountView addSubview:rightLabel];
    
    CGSize  size                 = [ZFPublic sizeWithString:text font:rightLabel.font  maxSize:CGSizeMake(75, MAXFLOAT)];
    UIView *bottomLine           = [[UIView alloc]init];
    bottomLine.center            = CGPointMake(rightLabel.center.x-4, rightLabel.bottom-8);
    bottomLine.bounds            = CGRectMake(0, 0, size.width, 1.0);
    bottomLine.backgroundColor   = ZFRGBColor(255, 69, 125);
    [accountView addSubview:bottomLine];
    
    if ([text length]<1) {
        [rightLabel setHidden:YES];
        [bottomLine setHidden:YES];
    }
    return accountView;
    
}
@end
