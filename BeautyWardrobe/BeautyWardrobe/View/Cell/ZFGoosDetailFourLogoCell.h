//
//  ZFGoosDetailFourLogoCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFGoodsDetailModel.h"
@interface ZFGoosDetailFourLogoCell : UITableViewCell

@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel     *titleLab;
@property (nonatomic,strong) UIView      *sepratorLine;
@property (nonatomic,strong) NSArray     *contentArray;

@property (nonatomic,strong) ZFGoodsDetailModel *detailModel;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
