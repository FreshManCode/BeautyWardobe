//
//  ZFMyWalletCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ZFMyWalletCellType){
    ZFMyWalletCellTypeText,
    ZFMyWalletCellTypeTwoText,
    ZFMyWalletCellTypeHybrideTextImage,
};

@interface ZFMyWalletCell : UITableViewCell
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *rightTitleLab;
@property (nonatomic,strong) UILabel *leftPriceLab;
@property (nonatomic,strong) UILabel *rightPriceLab;
@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) CALayer *pointLayer;
@property (nonatomic,strong) CALayer *sepratorLayer;
@property (nonatomic,assign) ZFMyWalletCellType cellType;
@property (nonatomic,strong) UIView  *verticalLine;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
