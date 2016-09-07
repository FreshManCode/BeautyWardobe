//
//  ZFMyCouponCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFMyCouponModel.h"

@interface ZFMyCouponCell : UITableViewCell
@property (nonatomic,strong) UIImageView *couponBg;
@property (nonatomic,strong) UILabel     *priceLab;
@property (nonatomic,strong) UIImageView *leftPriceImage;
@property (nonatomic,strong) UIImageView *rightPriceImage;
@property (nonatomic,strong) UILabel     *usePlaceLab;
@property (nonatomic,strong) UILabel     *useConditionLab;
@property (nonatomic,strong) UILabel     *expireTimeLab;
@property (nonatomic,strong) UIImageView *expireImage;
@property (nonatomic,strong) ZFMyCouponModel *couponModel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;





@end
