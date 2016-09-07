//
//  ZFGoodsDetailCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFGoodsDetailModel.h"

@protocol ZFGoodsDetailHeadCellDelegate <NSObject>

- (void)didClickImage:(ZFGoodsDetailModel *)detailMoel;

@end

@interface ZFGoodsDetailHeadCell : UITableViewCell
@property (nonatomic,strong) UIImageView *topGoodsImage;
@property (nonatomic,strong) UILabel     *topPriceLab;
@property (nonatomic,strong) UILabel     *describeLab;
@property (nonatomic,assign) CGFloat     contentHeight;
@property (nonatomic,strong) UIView      *sepratorLine;
@property (nonatomic,strong) ZFGoodsDetailModel *detailModel;
@property (nonatomic,strong) UILabel     *originalLab;
@property (nonatomic,strong) UIView      *deleteLine;
@property (nonatomic,strong) UIButton    *discountBtn;
@property (nonatomic,strong) UIButton    *collectBtn;
@property (nonatomic,copy)   NSString    *object_id;
@property (nonatomic,strong) UIView      *topImageBottomView;
@property (nonatomic,assign) id <ZFGoodsDetailHeadCellDelegate>delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (CGFloat)cellContentHeight;


@end

