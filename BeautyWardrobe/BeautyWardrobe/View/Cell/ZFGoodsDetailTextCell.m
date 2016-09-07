//
//  ZFGoodsDetailTextCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoodsDetailTextCell.h"

@implementation ZFGoodsDetailTextCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"goodsDetailTextCell";
    ZFGoodsDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFGoodsDetailTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.cellType = ZFGoodsDetailTextCellTypeLineCell;
        [self addObserver:self forKeyPath:@"cellType" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)initSubViews {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = ZFFont(13.0f);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_titleLab];
    
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.font = ZFFont(13.0f);
        _detailLab.textAlignment = NSTextAlignmentLeft;
        _detailLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_detailLab];
    
    if (!_sepratorLine) {
        _sepratorLine = [[UIView alloc]init];
        _sepratorLine.backgroundColor = ZFRGBColor(228, 228, 228);
    }
    [self.contentView addSubview:_sepratorLine];
    
    if (!_desTitleLab) {
        _desTitleLab = [UILabel new];
        _desTitleLab.text = @"小编说";
        _desTitleLab.textAlignment = NSTextAlignmentLeft;
        _desTitleLab.font = ZFFont(14.0f);
        _desTitleLab.textColor = ZFRGBColor(100, 100, 100);
        _desTitleLab.backgroundColor = [UIColor clearColor];
    }
    [self.contentView addSubview:_desTitleLab];
    
    if (!_desContentLab) {
        _desContentLab = [UILabel new];
        _desContentLab.numberOfLines = 0;
        _desContentLab.textAlignment = NSTextAlignmentLeft;
        _desContentLab.font = ZFFont(14.0f);
        _desContentLab.textColor = ZFRGBColor(100, 100, 100);
        _desContentLab.backgroundColor = [UIColor clearColor];
    }
    [self.contentView addSubview:_desContentLab];
    
    if (!_infoLab) {
        _infoLab = [UILabel new];
        _infoLab.numberOfLines = 0;
        _infoLab.textAlignment = NSTextAlignmentLeft;
        _infoLab.font = ZFFont(14.0f);
        _infoLab.textColor = ZFRGBColor(100, 100, 100);
        _infoLab.backgroundColor = [UIColor clearColor];
    }
    [self.contentView addSubview:_infoLab];
    
}



- (void)layoutSubviews {
    [self initSubViews];
    switch (self.cellType) {
        case ZFGoodsDetailTextCellTypeLineCell:
            _titleLab.frame = CGRectMake(12, 0, 90, self.height);
            _detailLab.frame = CGRectMake(_titleLab.right+30, 0, ZFScreenWidth-_titleLab.right-35, self.height);
            _sepratorLine.frame = CGRectMake(0, self.height-1, ZFScreenWidth, 1.0);
            [_desTitleLab setHidden:YES];
            [_desContentLab setHidden:YES];
            _contentHeight = 40;
            break;
        case ZFGoodsDetailTextCellTypeDesCell:
            self.backgroundColor = ZFRGBColor(245, 245, 245);
            [_titleLab setHidden:YES];
            [_detailLab setHidden:YES];
            [_sepratorLine setHidden:YES];
            break;
        case ZFGoodsDetailTextCellTypeDescribe:
            [_titleLab setHidden:YES];
            [_detailLab setHidden:YES];
            [_desTitleLab setHidden:YES];
            [_desContentLab setHidden:YES];
            _contentHeight = 40;
            _infoLab.frame = CGRectMake(10, 0, ZFScreenWidth-50, self.height);
         default:
            break;
    }
}
- (CGFloat)cellContentHeight {
    return _contentHeight;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"cellType"]) {
        ZFGoodsDetailTextCellType type = [change[NSKeyValueChangeNewKey] integerValue];
        _cellType = type;
        [self layoutIfNeeded];
    }
}

- (void)setNameModel:(ZFGoodsPropsNameModel *)nameModel {
    _nameModel = nameModel;
    if (self.cellType ==ZFGoodsDetailTextCellTypeLineCell) {
        _titleLab.text  = _nameModel.pname;
        _detailLab.text = _nameModel.vname;
    }
}

- (void)setDetailModel:(ZFGoodsDetailModel *)detailModel {
    _detailModel = detailModel;
    _desTitleLab.frame = CGRectMake(12.0, 8, ZFScreenWidth-15, 12.0);
    CGSize size = [ZFPublic sizeWithString:_detailModel.taobao_subtitle font:ZFFont(14.0f) maxSize:CGSizeMake(ZFScreenWidth-30, MAXFLOAT)];
    _desContentLab.frame = CGRectMake(12.0f, _desTitleLab.bottom+12, ZFScreenWidth-30, size.height);
    _desContentLab.text  = _detailModel.taobao_subtitle;
    _contentHeight = _desContentLab.bottom +10;

}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"cellType"];
}





@end
