//
//  ZFPersonalInfoViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/20.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFPersonalInfoViewController.h"

@interface ZFPersonalInfoViewController ()

@end

@implementation ZFPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    // Do any additional setup after loading the view.
}

- (void)setUpSubViews {
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    self.titleLabel.text = @"个人信息";

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
