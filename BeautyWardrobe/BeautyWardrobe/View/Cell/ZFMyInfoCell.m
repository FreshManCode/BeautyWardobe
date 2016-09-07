//
//  ZFMyInfoCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/31.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyInfoCell.h"
#import <UIImageView+WebCache.h>

@implementation ZFMyInfoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZFMyInfoCellIdentifier";
    ZFMyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFMyInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addObserver:self forKeyPath:@"cellType" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)initSubViews {
    if (!_leftLab) {
        _leftLab = [UILabel new];
        _leftLab.font = ZFFont(16.0f);
        _leftLab.textAlignment = NSTextAlignmentLeft;
        _leftLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_leftLab];
    
    if (!_rightArrow) {
        _rightArrow = [UIImageView new];
        _rightArrow.image = [UIImage imageNamed:@"msgc_ic_arrow"];
    }
    [self.contentView addSubview:_rightArrow];
    
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(ZFScreenWidth-102, 9, 174/2.0-18, 174/2.0-18)];
        _headImage.layer.cornerRadius = _headImage.width/2.0;
        [_headImage.layer masksToBounds];
        _headImage.clipsToBounds = YES;
    }
    [self.contentView addSubview:_headImage];
    
    if (!_rightLab) {
        _rightLab = [UILabel new];
        _rightLab.textColor = ZFRGBColor(100, 100, 100);
        _rightLab.textAlignment = NSTextAlignmentRight;
        _rightLab.font = ZFFont(15.0f);
    }
    [self.contentView addSubview:_rightLab];
    
    if (!_sepratorLine) {
        _sepratorLine = [UIView new];
        _sepratorLine.backgroundColor = ZFRGBColor(231, 231, 231);
    }
    [self.contentView addSubview:_sepratorLine];
    
    
}

- (void)layoutSubviews {
    [self initSubViews];
    switch (self.cellType) {
        case ZFMyInfoCellTypeOnlyText:
            _leftLab.frame = CGRectMake(10, 0, 130, 36);
            [_sepratorLine setHidden:YES];
            [_rightArrow setHidden:YES];
            [_rightLab setHidden:YES];
            [_headImage setHidden:YES];
            self.backgroundColor = ZFRGBColor(231, 231, 231);
            break;
        case ZFMyInfoCellTypeImage:
            _rightArrow.frame = CGRectMake(ZFScreenWidth-20, (self.height-12)/2.0, 9, 12);
            _leftLab.frame = CGRectMake(10, 0, 50, 174/2.0);
            [_rightLab setHidden:YES];
            _sepratorLine.frame = CGRectMake(20, 174/2.0-0.5, ZFScreenWidth-20, 0.5);
            break;
        case ZFMyInfoCellTypeText:
            _rightArrow.frame = CGRectMake(ZFScreenWidth-20, (self.height-12)/2.0, 9, 12);
            _rightLab.frame = CGRectMake(60, 0, ZFScreenWidth-85, self.height);
            _leftLab.frame = CGRectMake(10, 0, 50, 52);
            _sepratorLine.frame = CGRectMake(20, 52-0.5, ZFScreenWidth-20, 0.5);
            [_headImage setHidden:YES];
            break;
        default:
            break;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"cellType"]) {
        ZFMyInfoCellType cellType =(ZFMyInfoCellType) [change[NSKeyValueChangeNewKey] integerValue];
        _cellType = cellType;
        [self layoutIfNeeded];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"cellType"];
}


@end
