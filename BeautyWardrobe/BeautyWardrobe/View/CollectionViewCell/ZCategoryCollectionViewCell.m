//
//  ZCategoryCollectionViewCell.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/11.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZCategoryCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface ZCategoryCollectionViewCell ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UILabel *nameLabel;

@end

@implementation ZCategoryCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.nameLabel];
        
        __weak __typeof(&*self)weakSelf = self;
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(0);
            make.rightMargin.mas_equalTo(0);
            make.topMargin.mas_equalTo(0);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-20);
        }];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(0);
            make.rightMargin.mas_equalTo(0);
            make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(0);
            make.bottomMargin.mas_equalTo(0);
        }];
    }
    return self;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _imageView.layer.borderWidth = 0.5;
    }
    return _imageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:11];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (void)setModel:(ZCategoryModel *)model
{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:nil];
    
    self.nameLabel.text = model.taobao_title;
//    [self.nameLabel sizeToFit];
}



@end
