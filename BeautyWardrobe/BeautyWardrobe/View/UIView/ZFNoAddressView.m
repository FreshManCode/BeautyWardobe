//
//  ZFNoAddressView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/25.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFNoAddressView.h"

@implementation ZFNoAddressView
{
    UIImageView *_positionImage;
    UILabel     *_addressLab;
    UIButton    *_addBtn;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _positionImage = [[UIImageView alloc]initWithFrame:CGRectMake((ZFScreenWidth-100)/2.0, 80, 100, 100)];
    _positionImage.layer.cornerRadius = _positionImage.width/2.0;
    [_positionImage.layer masksToBounds];
    _positionImage.clipsToBounds = YES;
    _positionImage.image = [UIImage imageNamed:@"map_pin"];
    [self addSubview:_positionImage];
    
    _addressLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _positionImage.bottom+45, ZFScreenWidth-20, 20)];
    _addressLab.text = @"你还没有添加地址哦~";
    _addressLab.textColor = ZFRGBColor(100, 100, 100);
    _addressLab.textAlignment = NSTextAlignmentCenter;
    _addressLab.font = ZFFont(15.0f);
    [self addSubview:_addressLab];
    
    _addBtn = [[UIButton alloc]initWithFrame:CGRectMake((ZFScreenWidth-80)/2.0, _addressLab.bottom+15, 80, 35)];
    [_addBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [_addBtn setTitle:@"去添加" forState:UIControlStateNormal];
    _addBtn.titleLabel.font = ZFFont(15.0f);
    [_addBtn addTarget:self action:@selector(addAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];

}

- (void)addAddressEvent:(UIButton *)sender {
    if (_btnDelegate &&[_btnDelegate respondsToSelector:@selector(didClickAddAddressButton)] ) {
        [_btnDelegate didClickAddAddressButton];
    }
}


@end
