//
//  ZFSearchView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFSearchView.h"

@implementation ZFSearchView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpSubviews];
    }
    return self;
}


- (void)setUpSubviews {
    if (!_inputTf) {
        _inputTf = [[UITextField alloc]initWithFrame:CGRectMake(8, 8, self.width-50, self.height)];
        _inputTf.placeholder = @"搜索你喜欢的宝贝";
        _inputTf.background = [UIImage imageNamed:@"搜索框背景"];
        
        UIImageView *serachIcon = [[UIImageView alloc]init];
        serachIcon.image = [UIImage imageNamed:@"搜索按钮"];
        serachIcon.contentMode = UIViewContentModeCenter;
        serachIcon.size = CGSizeMake(30, 30);
        _inputTf.leftView = serachIcon;
        _inputTf.leftViewMode = UITextFieldViewModeAlways;
    }
    [self addSubview:_inputTf];
    
    
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-45, 0, 45, self.height)];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_cancelBtn addTarget:self action:@selector(cancelEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self addSubview:_cancelBtn];
}

- (void)cancelEvent:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(didCancelSearchEvent)]) {
        [_delegate didCancelSearchEvent];
    }
}


@end
