//
//  ZFPushBaseViewController.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFPushBaseViewController : UIViewController

@property (nonatomic,strong) UILabel  *titleLabel;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIView   *navBarView;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UISwipeGestureRecognizer *swipeGesture;
@property (nonatomic,assign) BOOL     isConnect;

- (float)getStartOriginY;
- (float)getContentViewHeight;
- (void)leftButtonItemClick;



@end
