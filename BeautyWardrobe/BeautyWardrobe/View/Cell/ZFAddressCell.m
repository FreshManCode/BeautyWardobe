//
//  ZFAddressCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/25.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFAddressCell.h"
#import "NetwokeManager.h"
#import "ZFUserDefaults.h"

@implementation ZFAddressCell
{
   }

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZFAddressCellIdentifier";
    ZFAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = ZFFont(15.0f);
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    [self.contentView addSubview:_nameLab];
    
    if (!_phoneLab) {
        _phoneLab = [UILabel new];
        _nameLab.font = ZFFont(15.0f);
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    [self.contentView addSubview:_nameLab];
    
    if (!_addressLab) {
        _addressLab = [UILabel new];
        _addressLab.font = ZFFont(14.0f);
        _addressLab.textColor = ZFRGBColor(100, 100, 100);
        _addressLab.textAlignment = NSTextAlignmentLeft;
    }
    [self.contentView addSubview:_addressLab];
    
    
    if (!_staticAddressBtn) {
        _staticAddressBtn = [ZFAddressButton new];
        [_staticAddressBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        [_staticAddressBtn setImage:[UIImage imageNamed:@"insertalbum_ng"] forState:UIControlStateNormal];
        [_staticAddressBtn setImage:[UIImage imageNamed:@"insertalbum_gg"] forState:UIControlStateSelected];
        [_staticAddressBtn setTitleColor:ZFRGBColor(100, 100, 100) forState:UIControlStateNormal];
        _staticAddressBtn.titleLabel.font = ZFFont(14.0f);
        [_staticAddressBtn addTarget:self action:@selector(addressCellEvent:) forControlEvents:UIControlEventTouchUpInside];
        _staticAddressBtn.tag = 10;
    }
    [self.contentView addSubview:_staticAddressBtn];
    
    if (!_editBtn) {
        _editBtn = [ZFAddressButton new];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"MyShopAddCellEdit"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(addressCellEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_editBtn setTitleColor:ZFRGBColor(100, 100, 100) forState:UIControlStateNormal];
        _editBtn.titleLabel.font = ZFFont(14.0f);

        _editBtn.tag = 11;
    }
    [self.contentView addSubview:_editBtn];
    
    if (!_deleteBtn) {
        _deleteBtn = [ZFAddressButton new];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setImage:[UIImage imageNamed:@"MyShopAddCellDelete"] forState:UIControlStateNormal];
        _deleteBtn.tag = 12;
        [_deleteBtn addTarget:self action:@selector(addressCellEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitleColor:ZFRGBColor(100, 100, 100) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = ZFFont(14.0f);

    }
    [self.contentView addSubview:_deleteBtn];
}



- (void)setAddreddModel:(ZFMyAddressModel *)addreddModel {
    _addreddModel = addreddModel;
    NSString *name = addreddModel.name;
    CGSize size = [ZFPublic sizeWithString:name font:ZFFont(15.0f) maxSize:CGSizeMake(MAXFLOAT, 15.0f)];
    _nameLab.frame  = CGRectMake(10, 12, size.width+5, 15.0f);
    _nameLab.text   = name;
    _phoneLab.frame = CGRectMake(_nameLab.right+5, 12.0f, ZFScreenWidth-_nameLab.right-10-5, 15.0f);
    _phoneLab.text  = _addreddModel.phone;
    _addressLab.frame = CGRectMake(10, _phoneLab.bottom+10, ZFScreenWidth-20, 14.0f);
    _addressLab.text = [NSString stringWithFormat:@"%@ %@ %@",addreddModel.province,addreddModel.city,addreddModel.area];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _addressLab.bottom+10, ZFScreenWidth, 0.5f)];
    lineView.backgroundColor = ZFRGBColor(100, 100, 100);
    [self.contentView addSubview:lineView];
    _staticAddressBtn.frame = CGRectMake(10, lineView.bottom+10, 120, 25);
    _editBtn.frame = CGRectMake(self.width-160, lineView.bottom+10, 55, 25);
    _deleteBtn.frame = CGRectMake(self.width-85, lineView.bottom+10, 55, 25);
    if ([_addreddModel.is_default isEqualToString:@"1"]) {
        self.layer.borderColor = ZFRGBColor(219, 81, 128).CGColor;
        self.layer.borderWidth = 1.0f;
        _staticAddressBtn.selected = YES;
    }else{
        _staticAddressBtn.selected = NO;
        self.layer.borderWidth = 0.0f;
    }
}

- (void)addressCellEvent:(ZFAddressButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:
                     @selector(didClickButtonTag:addressModel:selectedBtn:)]) {
        [_delegate didClickButtonTag:sender.tag addressModel:_addreddModel selectedBtn:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
