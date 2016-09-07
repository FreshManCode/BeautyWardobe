//
//  ZCategoryCell.h
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ZCategoryModel.h"

@class ZCategoryButton;
@interface ZCategoryCell : UITableViewCell

@property (nonatomic, strong)ZCategoryButton *categoryBtn;
@property (nonatomic, copy) NSString *nameTitle;

@end
