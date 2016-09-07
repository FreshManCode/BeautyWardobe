//
//  ZCategoryButton.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/18.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZCategoryButton.h"

@interface ZCategoryButton ()

@property (nonatomic, strong) UILabel *verline;

@end

@implementation ZCategoryButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initBody];
    }
    return self;
}

- (void)initBody
{
    [self addSubview:self.verline];
}

- (UILabel *)verline
{
    if (!_verline) {
        _verline = [[UILabel alloc] init];
        _verline.frame = CGRectMake(0, 0, 5, self.bounds.size.height);
        _verline.backgroundColor = [UIColor redColor];
    }
    return _verline;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.selected) {
        _verline.hidden = NO;
    }else
    {
        _verline.hidden = YES;
    }
}

@end
