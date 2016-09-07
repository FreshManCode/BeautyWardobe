//
//  ZFMyItemCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFHeadADsProductModel.h"

@protocol ZFMyItemCellDelegate <NSObject>

- (void)didClickDeleteBtnWithModel:(ZFMyItemModel *)itemModel;
- (void)didClickLeftPicImageWithModel:(ZFMyItemModel *)itemModel;


@end

@interface ZFMyItemCell : UITableViewCell

@property (nonatomic,strong) CALayer *verticaLayer;
@property (nonatomic,strong) CALayer *bottomVerticalLayer;
@property (nonatomic,strong) UIView  *loopView;;
@property (nonatomic,strong) UILabel *monthLab;
@property (nonatomic,strong) UILabel *dayLab;
@property (nonatomic,strong) UILabel *topLab;
@property (nonatomic,strong) UIImageView *bgImage;

@property (nonatomic,strong) UIImageView *leftImage;
@property (nonatomic,strong) UILabel  *brandLab;
@property (nonatomic,strong) UILabel  *accurateTimeLab;
@property (nonatomic,strong) UILabel  *descriptionLab;
@property (nonatomic,strong) UILabel  *priceLab;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UILabel  *originalLab;
@property (nonatomic,strong) UIView   *poingView;

@property (nonatomic,strong) ZFMyItemModel *itemModel;
@property (nonatomic,assign) id <ZFMyItemCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
