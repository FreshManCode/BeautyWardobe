//
//  ZCategoryCell.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZCategoryCell.h"

#import "ZCategoryButton.h"

@interface ZCategoryCell ()



@end

@implementation ZCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (ZCategoryButton *)categoryBtn
{
    if (!_categoryBtn) {
        _categoryBtn = [[ZCategoryButton alloc] initWithFrame:self.bounds];
        [_categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_categoryBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _categoryBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _categoryBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_categoryBtn];
    }
    return _categoryBtn;
}

- (void)setNameTitle:(NSString *)nameTitle
{
    [self.categoryBtn setTitle:nameTitle forState:UIControlStateNormal];
}

@end
