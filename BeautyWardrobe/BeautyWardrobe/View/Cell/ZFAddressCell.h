//
//  ZFAddressCell.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/25.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFAddressButton.h"
#import "ZFMyAddressModel.h"

@protocol ZFAddressCellDelegate <NSObject>

@optional
- (void)didClickButtonTag:(NSInteger)tagIndex addressModel:(ZFMyAddressModel *)model selectedBtn:(ZFAddressButton *)staticBtn;

@end

@interface ZFAddressCell : UITableViewCell

@property (nonatomic,strong) UILabel  *nameLab;
@property (nonatomic,strong) UILabel  *phoneLab;
@property (nonatomic,strong) UILabel  *addressLab;
@property (nonatomic,strong) ZFMyAddressModel *addreddModel;
@property (nonatomic,assign) id <ZFAddressCellDelegate>delegate;
@property (nonatomic,strong) ZFAddressButton *staticAddressBtn;
@property (nonatomic,strong) ZFAddressButton *editBtn;
@property (nonatomic,strong) ZFAddressButton *deleteBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
