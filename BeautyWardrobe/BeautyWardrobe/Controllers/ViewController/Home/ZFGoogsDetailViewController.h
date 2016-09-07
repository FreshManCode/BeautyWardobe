//
//  ZFGoogsDetailViewController.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFPushBaseViewController.h"
#import "ZHHomeListModel.h"
#import "ZFHeadADsProductModel.h"
#import "ZFBrandListModel.h"
@interface ZFGoogsDetailViewController : ZFPushBaseViewController

@property (nonatomic,strong) ZFHomeContentModel    *contentModel;
@property (nonatomic,strong) ZFHomeHotGoodsModel   *hotGoodsModel;
@property (nonatomic,strong) ZFHeadADsProductModel *productModel;
@property (nonatomic,strong) ZFBrandInfoModel      *brandInfoModel;

@property (nonatomic,strong) ZFMyItemModel         *itemModel;

@end
