//
//  ZFMyAllOrderCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFMyAllOrderCellDelegate <NSObject>
@optional
- (void)getCurrentTag:(NSInteger)clickTag;

@end

@interface ZFMyAllOrderCell : UITableViewCell
@property (nonatomic,assign) id<ZFMyAllOrderCellDelegate>delegate;
@property (nonatomic,strong) UIButton *allBtn;
@property (nonatomic,strong) UILabel  *titleLab;
+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
