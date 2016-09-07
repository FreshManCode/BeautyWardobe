//
//  ZFSettingCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFSettingCell.h"

@implementation ZFSettingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"settingCustomCell";
    ZFSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.type = ZFSettingCellTypeDefault;
        self.backgroundColor = [UIColor whiteColor];
        [self addObserver:self forKeyPath:@"type" options:NSKeyValueObservingOptionNew context:NULL];
        
    }
    return self;
}

- (void)initSubViews {
    if (!_leftIcon) {
        _leftIcon = [UIImageView new];
    }
    [self.contentView addSubview:_leftIcon];
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:15.0f];
        _titleLab.textColor =ZFRGBColor(129, 129, 129);
    }
    [self.contentView addSubview:_titleLab];
    
    if (!_subTitleLab) {
        _subTitleLab = [UILabel new];
        _subTitleLab.textAlignment = NSTextAlignmentLeft;
        _subTitleLab.font = [UIFont systemFontOfSize:13.0f];
        _subTitleLab.textColor =ZFRGBColor(129, 129, 129);
    }
    [self.contentView addSubview:_subTitleLab];
    
    if (!_moreImage) {
        _moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-22, (self.height-8)/2.0, 8, 8)];
        _moreImage.image = [UIImage imageNamed:@"msgc_ic_arrow"];
    }
    [self.contentView addSubview:_moreImage];

    if (!_loginOutLab) {
        _loginOutLab = [UILabel new];
        _loginOutLab.text = @"退出登录";
        _loginOutLab.textAlignment = NSTextAlignmentCenter;
        _loginOutLab.font = [UIFont systemFontOfSize:15.0f];
        _loginOutLab.textColor = [UIColor whiteColor];
        _loginOutLab.backgroundColor = ZFRGBColor(219, 81, 128);
    }
    [self.contentView addSubview:_loginOutLab];
    
    if (!_sepratorLine) {
        _sepratorLine = [UIView  new];
        _sepratorLine.backgroundColor = ZFRGBColor(228, 228, 228);
    }
    [self.contentView addSubview:_sepratorLine];
    
}

- (void)layoutSubviews {
    [self initSubViews];
    switch (self.type) {
        case ZFSettingCellTypeDefault:
            _leftIcon.frame = CGRectMake(10, (self.height-30)/2.0, 25, 30);
            _titleLab.frame = CGRectMake(_leftIcon.right+8, (self.height-30)/2.0,250/2.0, 30);
            _sepratorLine.frame = CGRectMake(_titleLab.left, self.height-1, ZFScreenWidth-_titleLab.left, 1.0);
            [_subTitleLab setHidden:YES];
            [_loginOutLab setHidden:YES];
            
            break;
        case ZFSettingCellTypeSubtitle:
            _leftIcon.frame = CGRectMake(10, (self.height-30)/2.0, 25, 30);
            _titleLab.frame = CGRectMake(_leftIcon.right+8, (self.height-30)/2.0,250/2.0, 30);
            _subTitleLab.frame = CGRectMake(_titleLab.right+12, (self.height-30)/2.0, 45, 30);
            _sepratorLine.frame = CGRectMake(_titleLab.left, self.height-1, ZFScreenWidth-_titleLab.left, 1.0);
            [_loginOutLab setHidden:YES];
            break;
        case ZFSettingCellTypeOnltTitle:
            _loginOutLab.frame  = CGRectMake(12, 0, (ZFScreenWidth-24), self.height);
            [_leftIcon setHidden:YES];
            [_titleLab setHidden:YES];
            [_subTitleLab setHidden:YES];
            [_sepratorLine setHidden:YES];
            break;
        default:
            break;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"type"]) {
        ZFSettingCellType type = [change[NSKeyValueChangeNewKey] integerValue];
        _type = type;
        [self layoutIfNeeded];
    }
}


- (void)dealloc {
    [self removeObserver:self forKeyPath:@"type"];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
