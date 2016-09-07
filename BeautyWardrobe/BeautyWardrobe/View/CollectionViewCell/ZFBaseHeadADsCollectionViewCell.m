//
//  ZFBaseHeadADsCollectionViewCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/29.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBaseHeadADsCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation ZFBaseHeadADsCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews {
    if (!_bgPicture) {
        _bgPicture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, 430/2.0)];
    }
    [self.contentView addSubview:_bgPicture];
    
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(7.5,_bgPicture.bottom+9, self.width-14, 35)];
        _descriptionLabel.font = [UIFont systemFontOfSize:12.0f];
        _descriptionLabel.numberOfLines = 0;
    }
    [self.contentView addSubview:_descriptionLabel];
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(7.5, _descriptionLabel.bottom+12, _descriptionLabel.width, 12.0)];
        _priceLabel.textColor = ZFRGBColor(244, 93, 139);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    [self.contentView addSubview:_priceLabel];

    if (!_tagImage) {
        _tagImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-40, 0, 35, 35)];
    }
    [self.contentView addSubview:_tagImage];
    
}

- (void)setModel:(ZFHeadADsProductModel *)model {
    _model = model;
    [_bgPicture sd_setImageWithURL:[NSURL URLWithString:model.taobao_pic_url] placeholderImage:nil];
    if (model.tag_url) {
        [_tagImage sd_setImageWithURL:[NSURL URLWithString:model.tag_url] placeholderImage:nil];
    }else {
        [_tagImage setHidden:YES];
    }
    _descriptionLabel.text = model.taobao_title;
    NSString *price = [NSString stringWithFormat:@"%@%@",model.money_symbol,model.taobao_selling_price];
    _priceLabel.text = price;
}



- (void)setGoodsModel:(ZFHomeHotGoodsModel *)goodsModel {
    _goodsModel = goodsModel;
    [_bgPicture sd_setImageWithURL:[NSURL URLWithString:_goodsModel.taobao_pic_url] placeholderImage:nil];
    if (_goodsModel.tag_url) {
        [_tagImage sd_setImageWithURL:[NSURL URLWithString:_goodsModel.tag_url] placeholderImage:nil];
    }else {
        [_tagImage setHidden:YES];
    }
    _descriptionLabel.text = _goodsModel.taobao_title;
    if ([_goodsModel.taobao_selling_price length]>0) {
        NSString *price = [NSString stringWithFormat:@"%@%@",_goodsModel.money_symbol,_goodsModel.taobao_selling_price];
        _priceLabel.text = price;
    }

}

- (void)setBrandInfoModel:(ZFBrandInfoModel *)brandInfoModel {
    _brandInfoModel = brandInfoModel;
    [_bgPicture sd_setImageWithURL:[NSURL URLWithString:_brandInfoModel.taobao_pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    if (_brandInfoModel.tag_url) {
        [_tagImage sd_setImageWithURL:[NSURL URLWithString:_brandInfoModel.tag_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    }else {
        [_tagImage setHidden:YES];
    }
    _descriptionLabel.text = _brandInfoModel.taobao_title;
    if ([_brandInfoModel.taobao_selling_price length]>0) {
        NSString *price = [NSString stringWithFormat:@"%@%@",_brandInfoModel.money_symbol,_brandInfoModel.taobao_selling_price];
        _priceLabel.text = price;
    }
}





@end
