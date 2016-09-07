//
//  ZFGoodsDetailImageCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/18.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoodsDetailImageCell.h"
#import <UIImageView+WebCache.h>

@implementation ZFGoodsDetailImageCell

+ (instancetype)cellWithTablView:(UITableView *)tableView {
    static NSString *identifier = @"GoogsDetailImageCell";
    ZFGoodsDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFGoodsDetailImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_imageV) {
            _imageV  = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 565/2.0)];
            _imageV.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookBigPictureEvent:)];
            [_imageV addGestureRecognizer:gesture];
        }
        [self.contentView addSubview:_imageV];
    }
    return self;
}

- (void)setMobileModel:(ZFGoodsMobileDescModel *)mobileModel {
    _mobileModel = mobileModel;
    if ([_mobileModel.content length]>0) {
        [_imageV sd_setImageWithURL:[NSURL URLWithString:_mobileModel.content] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    }
}


- (void)lookBigPictureEvent:(UITapGestureRecognizer *)gesture {
    if (_delegate &&[_delegate respondsToSelector:@selector(didClickTaobaoInfoImageWithModel:)]) {
        [_delegate didClickTaobaoInfoImageWithModel:_mobileModel];
    }
}



@end
