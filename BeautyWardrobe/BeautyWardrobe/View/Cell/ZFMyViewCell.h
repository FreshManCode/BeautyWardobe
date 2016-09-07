//
//  ZFMyViewCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/6.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFGoodsDetailModel.h"

@interface ZFMyViewCell : UITableViewCell


@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UILabel     *titleLab;
@property (nonatomic,strong) UILabel     *contetntLab;
@property (nonatomic,strong) UIImageView *moreImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
