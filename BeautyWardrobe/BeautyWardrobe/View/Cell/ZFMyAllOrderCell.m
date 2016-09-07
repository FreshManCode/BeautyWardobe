//
//  ZFMyAllOrderCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyAllOrderCell.h"
#import <Masonry.h>

@implementation ZFMyAllOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableview {
    static NSString *identifier = @"customFiveLogonCell";
    ZFMyAllOrderCell * cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFMyAllOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    if (!_allBtn) {
        NSArray *titleArray = [NSArray arrayWithObjects:@"待付款",@"待发货",@"代收货",@"已收货" ,@"退款中",nil];
        NSArray *imageArray = [NSArray arrayWithObjects:@"user_sendment",@"user_payment",@"user_recement",@"user_recevied" ,@"user_refundment",nil];
        CGFloat width  = ZFScreenWidth/5.0;
        CGFloat offSet = 35;
        for (int i=0;i<5;i++) {
            _allBtn = [[UIButton alloc]initWithFrame:CGRectMake(offSet +i*width-15, 5, width-offSet, width-offSet)];
            _allBtn.backgroundColor = [UIColor whiteColor];
            [_allBtn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            _allBtn.tag = 100+i;
            _allBtn.layer.cornerRadius = (width-offSet)/2.0;
            [_allBtn addTarget:self action:@selector(fiveBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [_allBtn clipsToBounds];
            [self.contentView addSubview:_allBtn];
            _titleLab = [UILabel new];
            _titleLab.text = titleArray[i];
            _titleLab.font = [UIFont systemFontOfSize:14];
            _titleLab.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_titleLab];
            [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(_allBtn);
                make.top.equalTo(_allBtn).offset(_allBtn.height +5);
                make.height.mas_equalTo(17);
            }];
        }
    }

}

- (void)fiveBtnClickEvent:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(getCurrentTag:)]) {
        [_delegate getCurrentTag:sender.tag];
    }
}




@end
