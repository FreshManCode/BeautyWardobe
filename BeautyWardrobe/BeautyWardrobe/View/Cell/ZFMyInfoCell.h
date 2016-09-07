//
//  ZFMyInfoCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/31.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFPushBaseViewController.h"

typedef NS_ENUM(NSInteger,ZFMyInfoCellType) {
    ZFMyInfoCellTypeText,
    ZFMyInfoCellTypeImage,
    ZFMyInfoCellTypeOnlyText
};

@interface ZFMyInfoCell : UITableViewCell

@property (nonatomic,strong) UILabel *leftLab;
@property (nonatomic,strong) UIImageView *headImage;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UILabel *rightLab;
@property (nonatomic,assign) ZFMyInfoCellType cellType;

@property (nonatomic,strong) UIView  *sepratorLine;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
