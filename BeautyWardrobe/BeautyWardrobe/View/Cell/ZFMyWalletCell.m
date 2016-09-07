//
//  ZFMyWalletCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyWalletCell.h"

@implementation ZFMyWalletCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZFMyWalletCell";
    ZFMyWalletCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFMyWalletCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = ZFFont(15.0f);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_titleLab];
    
    if (!_leftPriceLab) {
        _leftPriceLab = [UILabel new];
        _leftPriceLab.font = ZFFont(13.0f);
        _leftPriceLab.textColor = ZFRGBColor(100, 100, 100);
        _leftPriceLab.textAlignment = NSTextAlignmentCenter;
    }
    [self.contentView addSubview:_leftPriceLab];
    
    if (!_verticalLine) {
        _verticalLine = [UIView new];
        _verticalLine.backgroundColor = ZFRGBColor(239, 239, 239);
    }
    [self.contentView addSubview:_verticalLine];
        
    if (!_rightTitleLab) {
        _rightTitleLab = [UILabel new];
        _rightTitleLab.font = ZFFont(15.0f);
        _rightTitleLab.textAlignment =NSTextAlignmentCenter;
        _rightTitleLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_rightTitleLab];
    
    if (!_rightPriceLab) {
        _rightPriceLab = [UILabel new];
        _rightPriceLab.font = ZFFont(13.0f);
        _rightPriceLab.textAlignment = NSTextAlignmentCenter;
        _rightPriceLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_rightPriceLab];
    
    if (!_leftIcon) {
        _leftIcon = [UIImageView new];
    }
    [self.contentView addSubview:_leftIcon];
    
    if (!_rightArrow) {
        _rightArrow = [UIImageView new];
        _rightArrow.image = [UIImage imageNamed:@"msgc_ic_arrow"];
    }
    [self.contentView addSubview:_rightArrow];
    
    if (!_pointLayer) {
        _pointLayer = [CALayer layer];
        _pointLayer.cornerRadius = 3.0;
        _pointLayer.backgroundColor = ZFRGBColor(225, 71, 127).CGColor;
    }
    [self.layer addSublayer:_pointLayer];
    
    if (!_sepratorLayer) {
        _sepratorLayer = [CALayer layer];
        _sepratorLayer.backgroundColor = ZFRGBColor(239, 239, 239).CGColor;
    }
    [self.layer addSublayer:_sepratorLayer];
    
    
}
- (void)layoutSubviews {
    [self initSubViews];
    switch (self.cellType) {
        case ZFMyWalletCellTypeText:
            _titleLab.frame = CGRectMake(12, (self.height-15)/2.0, 90, 15.0f);
            _rightPriceLab.frame = CGRectMake(ZFScreenWidth-116/2.0, (self.height-15)/2.0, 116/2.0, 15.0f);
            _rightPriceLab.textColor = ZFRGBColor(225, 71, 127);
            _sepratorLayer.frame = CGRectMake(10, self.height-0.5, ZFScreenWidth-10, 0.5);
            [_leftIcon setHidden:YES];
            [_leftPriceLab setHidden:YES];
            [_rightTitleLab setHidden:YES];
            [_pointLayer setHidden:YES];
            [_rightArrow setHidden:YES];
            [_verticalLine setHidden:YES];
            break;
        case ZFMyWalletCellTypeTwoText:
            [_pointLayer setHidden:YES];
            [_rightArrow setHidden:YES];
            [_leftIcon setHidden:YES];
            [_sepratorLayer setHidden:YES];
            _titleLab.frame = CGRectMake(12, (self.height-15)/2.0, 75, 15.0f);
            _leftPriceLab.frame = CGRectMake(ZFScreenWidth/2.0-55, (self.height-13)/2.0, 55, 13.0f);
            _verticalLine.frame = CGRectMake(ZFScreenWidth/2.0, 5, 1, self.height-10);
            _rightTitleLab.frame = CGRectMake(ZFScreenWidth/2.0+12, (self.height-15)/2.0, 90, 15.0f);
            _rightPriceLab.frame = CGRectMake(ZFScreenWidth-55, (self.height-13)/2.0, 55, 13.0f);
            _rightPriceLab.textColor = ZFRGBColor(100, 100, 100);
            break;
        case ZFMyWalletCellTypeHybrideTextImage:
            _rightArrow.frame = CGRectMake(ZFScreenWidth-20, (self.height-12)/2.0, 9, 12);
            _pointLayer.frame = CGRectMake(ZFScreenWidth-35, (self.height-6)/2.0, 6.0, 6.0);
            _sepratorLayer.frame = CGRectMake(10, self.height-0.5, ZFScreenWidth-10, 0.5);
            _leftIcon.frame = CGRectMake(12, (self.height-30)/2.0, 24, 30.0);
            _titleLab.frame = CGRectMake(_leftIcon.right+12, (self.height-15)/2.0, 90, 15.0f);
            [_verticalLine setHidden:YES];
            [_rightPriceLab setHidden:YES];
            [_rightTitleLab setHidden:YES];
            [_leftPriceLab setHidden:YES];
            break;
            
        default:
            break;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"cellType"]) {
        ZFMyWalletCellType type = [change[NSKeyValueChangeNewKey] integerValue];
        _cellType = type;
        [self layoutIfNeeded];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"cellType"];
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
