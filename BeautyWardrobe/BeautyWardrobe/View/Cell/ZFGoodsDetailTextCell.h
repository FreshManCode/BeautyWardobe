//
//  ZFGoodsDetailTextCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFGoodsDetailModel.h"
typedef NS_ENUM(NSInteger, ZFGoodsDetailTextCellType) {
    ZFGoodsDetailTextCellTypeLineCell,
    ZFGoodsDetailTextCellTypeDesCell,
    ZFGoodsDetailTextCellTypeDescribe,
};

@interface ZFGoodsDetailTextCell : UITableViewCell

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *detailLab;
@property (nonatomic,strong) UILabel *desTitleLab;
@property (nonatomic,strong) UILabel *desContentLab;
@property (nonatomic,assign) ZFGoodsDetailTextCellType cellType;
@property (nonatomic,assign) CGFloat contentHeight;
@property (nonatomic,strong) UIView *sepratorLine;
@property (nonatomic,strong) ZFGoodsPropsNameModel *nameModel;
@property (nonatomic,strong) ZFGoodsDetailModel *detailModel;
@property (nonatomic,strong) UILabel *infoLab;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellContentHeight;

@end
