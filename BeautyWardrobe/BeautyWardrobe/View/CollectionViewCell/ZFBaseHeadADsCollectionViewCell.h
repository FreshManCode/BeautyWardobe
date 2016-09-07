//
//  ZFBaseHeadADsCollectionViewCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/29.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFHeadADsProductModel.h"
#import "ZHHomeListModel.h"

@interface ZFBaseHeadADsCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *bgPicture;
@property (nonatomic,strong) UILabel     *descriptionLabel;
@property (nonatomic,strong) UILabel     *priceLabel;
@property (nonatomic,strong) UIImageView *tagImage;
@property (nonatomic,strong)  ZFHeadADsProductModel *model;

@property (nonatomic,strong)  ZFHomeHotGoodsModel *goodsModel;

@property (nonatomic,strong)  ZFBrandInfoModel *brandInfoModel;


@end
