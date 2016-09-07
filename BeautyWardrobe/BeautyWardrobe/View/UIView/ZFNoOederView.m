//
//  ZFNoOederView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/24.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFNoOederView.h"

@implementation ZFNoOederView
{
    UIImageView *_noOrderImage;
    UILabel     *_noOrderLab;
    UILabel     *_loadAllLab;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    if (!_noOrderImage) {
        _noOrderImage = [[UIImageView alloc]initWithFrame:CGRectMake((ZFScreenWidth-60)/2.0, 120, 60, 90)];
        _noOrderImage.image = [UIImage imageNamed:@"order_empty"];
    }
    [self addSubview:_noOrderImage];
    
    if (!_noOrderLab) {
        _noOrderLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _noOrderImage.bottom+45, ZFScreenWidth-20, 20)];
        _noOrderLab.textAlignment = NSTextAlignmentCenter;
        _noOrderLab.textColor = ZFRGBColor(100, 100, 100);
        _noOrderLab.font = ZFFont(15.0f);
        _noOrderLab.text = @"亲~暂无订单喔~~";
    }
    [self addSubview:_noOrderLab];
    
    if (!_loadAllLab) {
        _loadAllLab = [[UILabel alloc]initWithFrame:CGRectMake(20, self.height+30, ZFScreenWidth-40, 15.0)];
        _loadAllLab.textAlignment = NSTextAlignmentCenter;
        _loadAllLab.font = ZFFont(13.0f);
        _loadAllLab.text = @"已加载全部";
    }
    [self addSubview:_loadAllLab];
    
    
}








@end
