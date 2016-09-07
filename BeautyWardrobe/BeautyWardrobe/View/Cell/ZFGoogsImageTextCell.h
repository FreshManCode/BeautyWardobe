//
//  ZFGoogsImageTextCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFGoodsDetailModel.h"
@interface ZFGoogsImageTextCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UILabel     *titleLab;
@property (nonatomic,strong) UILabel     *contetntLab;
@property (nonatomic,strong) UIImageView *moreImage;
@property (nonatomic,strong) ZFGoodsBrandModel *brandModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
