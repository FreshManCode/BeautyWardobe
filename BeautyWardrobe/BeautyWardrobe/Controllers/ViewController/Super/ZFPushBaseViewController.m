//
//  ZFPushBaseViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFPushBaseViewController.h"
#import <RealReachability.h>
@interface ZFPushBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZFPushBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBarHidden = YES;
    [self initSubViews];
}

- (void)initSubViews {
    float top = 0;
    if (!_navBarView) {
        _navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, top, ZFScreenWidth, 64)];
        _navBarView.backgroundColor = ZFRGBColor(245, 245, 245);
    }
    [self.view addSubview:_navBarView];
    
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 34.0, 34.0)];
//        [_leftButton setImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [_navBarView addSubview:_leftButton];
    
    if (!_titleLabel ) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, ZFScreenWidth, 44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    [_navBarView addSubview:_titleLabel];
    
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-54, 25, 44, 24)];
    }
    [_navBarView addSubview:_rightButton];
    
    if (!_swipeGesture) {
        _swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureAction:)];
        _swipeGesture.delegate = self;
        _swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    [self.view addGestureRecognizer:_swipeGesture];
    
}

- (void)swipeGestureAction:(UISwipeGestureRecognizer *)swipeGesture {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (float)getStartOriginY {
    CGFloat originY;
    if (ZF_IS_IOS7_AND_UP) {
        originY = 64;
    } else {
        originY = 44;
    }
    return originY;
}

- (float)getContentViewHeight {
    CGFloat height;
    CGFloat originY = [self getStartOriginY];
    if (ZF_IS_IOS7_AND_UP) {
        height = ZFScreenHeight - originY;
    } else {
        height = ZFScreenHeight - 44;
    }
    return height;
}

- (void)leftButtonItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (ZF_IS_IOS7_AND_UP) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
