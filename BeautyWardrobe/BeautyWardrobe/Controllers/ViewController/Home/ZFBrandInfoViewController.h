//
//  ZFBrandInfoViewController.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/10.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFBrandListModel.h"
#import "ZHHomeListModel.h"

@interface ZFBrandInfoViewController : UIViewController

@property (nonatomic,strong) ZFBrandListContentModel *model;
@property (nonatomic,strong) ZHHomeListModel *listModel;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,copy)   NSString *brandID;



@end
