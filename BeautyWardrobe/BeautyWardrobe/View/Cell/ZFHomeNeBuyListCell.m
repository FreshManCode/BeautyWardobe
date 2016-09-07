//
//  ZFHomeNeBuyListCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/5.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFHomeNeBuyListCell.h"
#import <UIImageView+WebCache.h>

@implementation ZFHomeNeBuyListCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"customTwoPictureCell";
    ZFHomeNeBuyListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell =[[ZFHomeNeBuyListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)initSubViews {
    
    if (!_headView) {
        _headView = [UIView new];
        _headView.backgroundColor = ZFRGBColor(242, 242, 242);
    }
    [self.contentView addSubview:_headView];
    
    if (!_headTitleLab) {
        _headTitleLab = [UILabel new];
        _headTitleLab.textAlignment = NSTextAlignmentLeft;
        _headTitleLab.text = @"热门商品";
    }
    [_headView addSubview:_headTitleLab];
    
    if (!_leftImage) {
        _leftImage = [UIImageView new];
        _leftImage.tag = 100;
    }
    [self.contentView addSubview:_leftImage];
    
    if (!_rightTopImage) {
        _rightTopImage = [UIImageView new];
        _rightTopImage.tag = 101;
    }
    [self.contentView addSubview:_rightTopImage];
    
    if (!_rightBottomImage) {
        _rightBottomImage = [UIImageView new];
        _rightBottomImage.tag = 102;
    }
    [self.contentView addSubview:_rightBottomImage];
    
    if (!_subTitleLab) {
        _subTitleLab = [UILabel new];
        _subTitleLab.font = [UIFont systemFontOfSize:13.0];
        _subTitleLab.textColor = [UIColor lightGrayColor];
        _subTitleLab.textAlignment = NSTextAlignmentLeft;
    }
    [_headView addSubview:_subTitleLab];
    
}

- (void)layoutSubviews {
    [self initSubViews];
    _headView.frame      = CGRectMake(0, 0, ZFScreenWidth, 35.0);
    _headTitleLab.frame  = CGRectMake(10, 0, 100, 35.0);
    _subTitleLab.frame   = CGRectMake(_headTitleLab.right, 0, 100, 35.0);
    _leftImage.frame = CGRectMake(0, _headView.bottom, ZFScreenWidth/2.0, 387/2.0);
    _rightTopImage.frame = CGRectMake(_leftImage.right+1, _headView.bottom, ZFScreenWidth/2.0, 195/2.0-1);
    _rightBottomImage.frame = CGRectMake(_rightTopImage.left, _rightTopImage.bottom+1, ZFScreenWidth/2.0, _rightTopImage.height-1);
}

- (void)setTitleModel:(ZFHomeContentModel *)titleModel {
        _titleModel = titleModel;
        _headTitleLab.text = _titleModel.title;
        _subTitleLab.text  = _titleModel.sub_title;
}

- (void)setRightTopModel:(ZHHomeListModel *)rightTopModel {
    _rightTopModel = rightTopModel;
    [_rightTopImage sd_setImageWithURL:[NSURL URLWithString:_rightTopModel.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
}


- (void)setRightBottomModel:(ZHHomeListModel *)rightBottomModel {
    _rightBottomModel = rightBottomModel;
    [_rightBottomImage sd_setImageWithURL:[NSURL URLWithString:_rightBottomModel.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
}


@end
