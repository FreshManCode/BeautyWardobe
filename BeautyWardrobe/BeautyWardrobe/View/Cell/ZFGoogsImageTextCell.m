
//
//  ZFGoogsImageTextCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoogsImageTextCell.h"

@implementation ZFGoogsImageTextCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = ZFMyViewCellIdentifier;
    ZFGoogsImageTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFGoogsImageTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, (self.height-20)/2.0, 20, 20)];
    }
    [self.contentView addSubview:_leftIcon];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_leftIcon.right+5, 0, 155, self.height)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = ZFRGBColor(100, 100, 100);
        _titleLab.font = [UIFont systemFontOfSize:13.0];
 
    }
    [self.contentView addSubview:_titleLab];
    if (!_moreImage) {
        _moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-22, (self.height-8)/2.0, 8, 8)];
        _moreImage.image = [UIImage imageNamed:@"msgc_ic_arrow"];
    }
    [self.contentView addSubview:_moreImage];
    
    if (!_contetntLab) {
        _contetntLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth-_moreImage.width-2-130, 0, 110, self.height)];
        _contetntLab.textAlignment = NSTextAlignmentRight;
        _contetntLab.font = [UIFont systemFontOfSize:13.0f];
        _contetntLab.textColor = ZFRGBColor(100, 100, 100);
        _contetntLab.text = @"更多热销宝贝";
    }
    [self.contentView addSubview:_contetntLab];
}


- (void)setBrandModel:(ZFGoodsBrandModel *)brandModel {
    _brandModel = brandModel;
    if (_brandModel) {
        _titleLab.textColor = ZFRGBColor(219, 81, 128);
        self.leftIcon.image = [UIImage imageNamed:@"BrandProductPopup"];
        self.titleLab.text = [NSString stringWithFormat:@"%@:%@",@"品牌店铺",_brandModel.titile];
    }
}



@end
