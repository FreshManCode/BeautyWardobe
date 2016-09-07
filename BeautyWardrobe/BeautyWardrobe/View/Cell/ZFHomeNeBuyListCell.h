//
//  ZFHomeNeBuyListCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/5.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHHomeListModel.h"

@interface ZFHomeNeBuyListCell : UITableViewCell


@property (nonatomic,strong) UIImageView *leftImage;
@property (nonatomic,strong) UIImageView *rightTopImage;
@property (nonatomic,strong) UIImageView *rightBottomImage;
@property (nonatomic,strong) UILabel     *subTitleLab;
@property (nonatomic,strong) UIView      *headView;
@property (nonatomic,strong) UILabel     *headTitleLab;
@property (nonatomic,strong) ZHHomeListModel    *leftPictueModel;
@property (nonatomic,strong) ZFHomeContentModel *titleModel;
@property (nonatomic,strong) ZHHomeListModel    *rightTopModel;
@property (nonatomic,strong) ZHHomeListModel    *rightBottomModel;


@property (nonatomic,strong) ZFHomeHotGoodsModel *leftPictureModel;
@property (nonatomic,strong) ZFHomeHotGoodsModel *rightPictureModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
