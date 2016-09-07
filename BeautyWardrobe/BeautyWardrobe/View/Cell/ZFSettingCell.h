//
//  ZFSettingCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ZFSettingCellType){
    ZFSettingCellTypeDefault,
    ZFSettingCellTypeSubtitle,
    ZFSettingCellTypeOnltTitle,
};

@interface ZFSettingCell : UITableViewCell

@property (nonatomic,strong) UIImageView *leftIcon;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *subTitleLab;
@property (nonatomic,strong) UIImageView *moreImage;
@property (nonatomic,assign) ZFSettingCellType type;
@property (nonatomic,strong) UILabel *loginOutLab;
@property (nonatomic,strong) UIView  *sepratorLine;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
