//
//  ZFGoodsDetailImageCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/18.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFGoodsDetailModel.h"

@protocol ZFGoodsDetailImageCellDelegate <NSObject>

- (void)didClickTaobaoInfoImageWithModel:(ZFGoodsMobileDescModel *)mobileModel;

@end

@interface ZFGoodsDetailImageCell : UITableViewCell
@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) ZFGoodsMobileDescModel *mobileModel;
@property (nonatomic,assign) id <ZFGoodsDetailImageCellDelegate> delegate;
+ (instancetype)cellWithTablView:(UITableView *)tableView;


@end
