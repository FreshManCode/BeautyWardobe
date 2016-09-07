//
//  ZFSignInViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFSignInViewController.h"
#import "ZFExplanationViewController.h"
@interface ZFSignInViewController ()
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIImageView  *topImageView;
@property (nonatomic,strong) UIButton     *signBtn;
@property (nonatomic,strong) UIImageView  *bagImage;
@property (nonatomic,strong) UILabel      *myCoinLab;
@property (nonatomic,strong) UILabel      *coinNumLab;
@property (nonatomic,strong) UILabel      *rateLab;
@property (nonatomic,strong) UILabel      *serialSignLab;
@property (nonatomic,strong) UIButton     *numBtn;
@property (nonatomic,strong) UILabel      *dayLab;
@end

@implementation ZFSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    self.titleLabel.text = @"签到中心";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"赚美丽币" forState:UIControlStateNormal];
    self.rightButton.frame =CGRectMake(ZFScreenWidth-74, 25, 64, 24);
    self.rightButton.titleLabel.font = ZFFont(13.0f);
    [self.rightButton addTarget:self action:@selector(earnBeautyCoinEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight- [self getStartOriginY])];
        _bgScrollView.backgroundColor = ZFRGBColor(246, 228, 160);
        _bgScrollView.contentSize = CGSizeMake(ZFScreenWidth, ZFScreenHeight);
        _bgScrollView.bounces = YES;
    }
    [self.view addSubview:_bgScrollView];
    
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 230/2.0)];
        _topImageView.image = [UIImage imageNamed:@"user_sign_top"];
    }
    [_bgScrollView addSubview:_topImageView];
    
    if (!_signBtn) {
        _signBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, _topImageView.bottom+20, ZFScreenWidth-100, 45)];
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"user_sign_sign"] forState:UIControlStateNormal];
        [_signBtn setBackgroundImage:[UIImage imageNamed:@"user_sign_signed"] forState:UIControlStateSelected];
        [_signBtn addTarget:self action:@selector(signInEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_bgScrollView addSubview:_signBtn];
    
    if (!_bagImage) {
        _bagImage = [[UIImageView alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0-30, _signBtn.bottom+20, 25, 35)];
        _bagImage.image = [UIImage imageNamed:@"user_sign_mycoin"];
    }
    [_bgScrollView addSubview:_bagImage];
    
    if (!_myCoinLab) {
        _myCoinLab = [UILabel new];
        _myCoinLab.center = CGPointMake(_bagImage.center.x, _bagImage.center.y+35/2.0+8);
        _myCoinLab.bounds = CGRectMake(0, 0, 100, 13.0f);
        _myCoinLab.text = @"我的美丽币";
        _myCoinLab.textAlignment = NSTextAlignmentCenter;
        _myCoinLab.font = ZFFont(13.0f);
        _myCoinLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [_bgScrollView addSubview:_myCoinLab];
    
    if (!_coinNumLab) {
        _coinNumLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0+15, _signBtn.bottom+30, 100, 24.0)];
        _coinNumLab.font = ZFFont(24.0f);
        _coinNumLab.text = @"95枚";
        _coinNumLab.textAlignment = NSTextAlignmentLeft;
        _coinNumLab.textColor = ZFRGBColor(225, 71, 127);
    }
    [_bgScrollView addSubview:_coinNumLab];
    
    if (!_rateLab ) {
        _rateLab =[[UILabel alloc]initWithFrame:CGRectMake(10, _myCoinLab.bottom+25, ZFScreenWidth-20, 17.0)];
        _rateLab.text = @"100枚美丽币=人民币1元";
        _rateLab.textAlignment = NSTextAlignmentCenter;
        _rateLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [_bgScrollView addSubview:_rateLab];
    
    if (!_serialSignLab) {
        _serialSignLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0-100, _rateLab.bottom+30, 90, 14.0f)];
        _serialSignLab.text =@"已经连续签到";
        _serialSignLab.textAlignment = NSTextAlignmentRight;
        _serialSignLab.font = ZFFont(14.0f);
        _serialSignLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [_bgScrollView addSubview:_serialSignLab];
    
    if (!_numBtn) {
        _numBtn = [[UIButton alloc]initWithFrame:CGRectMake(_serialSignLab.right+5, _rateLab.bottom+10, 50, 50)];
        _numBtn.titleEdgeInsets = UIEdgeInsetsMake(13.0, 0, 0, 0);
        [_numBtn setBackgroundImage:[UIImage imageNamed:@"user_sign_continue"] forState:UIControlStateNormal];
        [_numBtn setTitle:@"5" forState:UIControlStateNormal];
        [_numBtn setTitleColor:ZFRGBColor(225, 71, 127) forState:UIControlStateNormal];
    }
    [_bgScrollView addSubview:_numBtn];
    
    if (!_dayLab) {
        _dayLab = [[UILabel alloc]initWithFrame:CGRectMake(_numBtn.right+5, _serialSignLab.top, 20, 14.0f)];
        _dayLab.textAlignment = NSTextAlignmentLeft;
        _dayLab.font = ZFFont(14.0f);
        _dayLab.text = @"天";
        _dayLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [_bgScrollView addSubview:_dayLab];
    
    UILabel *signOneLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0-320/2.0, _serialSignLab.bottom+45, 65, 17.0)];
    signOneLab.text = @"连续签到";
    signOneLab.font = ZFFont(15.0f);
    signOneLab.textAlignment =NSTextAlignmentRight;
    signOneLab.textColor =ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:signOneLab];
    
    UIButton *oneDayBtn=  [[UIButton alloc]initWithFrame:CGRectMake(signOneLab.right+10, _serialSignLab.bottom+25, 50, 50)];
    [oneDayBtn setBackgroundImage:[UIImage imageNamed:@"user_sign_day"] forState:UIControlStateNormal];
    [oneDayBtn setTitle:@"1" forState:UIControlStateNormal];
    [_bgScrollView addSubview:oneDayBtn];
    
    UILabel *oneDayLab = [[UILabel alloc]initWithFrame:CGRectMake(oneDayBtn.right+12, signOneLab.top, 20, 17.0f)];
    oneDayLab.text = @"天";
    oneDayLab.font = ZFFont(15.0f);
    oneDayLab.textAlignment =NSTextAlignmentLeft;
    oneDayLab.textColor = ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:oneDayLab];
    
    UILabel *sendOneLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0+12, oneDayLab.top, 15, 17.0f)];
    sendOneLab.textColor = ZFRGBColor(100, 100, 100);
    sendOneLab.text = @"送";
    sendOneLab.font = ZFFont(15.0f);
    [_bgScrollView addSubview:sendOneLab];
    
    UILabel *symbolOne = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0, sendOneLab.bottom-15, 6, 17.0)];
    symbolOne.text = @",";
    symbolOne.font = ZFFont(17.0);
    symbolOne.textColor =ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:symbolOne];
    
    UIButton *fiveConinBtn = [[UIButton alloc]initWithFrame:CGRectMake(sendOneLab.right+12, oneDayBtn.top, 50, 50)];
    [fiveConinBtn setImage:[UIImage imageNamed:@"user_sign_coin"] forState:UIControlStateNormal];
    [_bgScrollView addSubview:fiveConinBtn];
    
    UILabel *fiveConinLab = [[UILabel alloc]initWithFrame:CGRectMake(fiveConinBtn.right+12, sendOneLab.top, 50, 17.0f)];
    fiveConinLab.text = @"5枚";
    fiveConinLab.font = ZFFont(15.0f);
    fiveConinLab.textAlignment =NSTextAlignmentLeft;
    fiveConinLab.textColor = ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:fiveConinLab];
    
    
    UILabel *signThrityLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0-320/2.0, signOneLab.bottom+35, 65, 17.0)];
    signThrityLab.text = @"连续签到";
    signThrityLab.textAlignment =NSTextAlignmentRight;
    signThrityLab.font = ZFFont(15.0f);
    signThrityLab.textColor =ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:signThrityLab];
    
    UIButton *thrityDayBtn=  [[UIButton alloc]initWithFrame:CGRectMake(signThrityLab.right+10, oneDayBtn.bottom+10, 50, 50)];
    [thrityDayBtn setBackgroundImage:[UIImage imageNamed:@"user_sign_day"] forState:UIControlStateNormal];
    [thrityDayBtn setTitle:@"30" forState:UIControlStateNormal];
    [_bgScrollView addSubview:thrityDayBtn];
    
    UILabel *thirtyDayLab = [[UILabel alloc]initWithFrame:CGRectMake(thrityDayBtn.right+12, signThrityLab.top, 20, 17.0f)];
    thirtyDayLab.text = @"天";
    thirtyDayLab.font = ZFFont(15.0f);
    thirtyDayLab.textAlignment =NSTextAlignmentLeft;
    thirtyDayLab.textColor = ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:thirtyDayLab];
    
    UILabel *sendthrityLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0+12, thirtyDayLab.top, 15, 17.0f)];
    sendthrityLab.textColor = ZFRGBColor(100, 100, 100);
    sendthrityLab.text = @"送";
    sendthrityLab.font = ZFFont(15.0f);
    [_bgScrollView addSubview:sendthrityLab];
    
    UILabel *symbolTwo = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth/2.0, thirtyDayLab.bottom-15, 6, 17.0)];
    symbolTwo.text = @",";
    symbolTwo.font = ZFFont(17.0);
    symbolTwo.textColor =ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:symbolTwo];
    
    UIButton *thrityConinBtn = [[UIButton alloc]initWithFrame:CGRectMake(sendthrityLab.right+12, thrityDayBtn.top, 50, 50)];
    [thrityConinBtn setImage:[UIImage imageNamed:@"user_sign_coin"] forState:UIControlStateNormal];
    [_bgScrollView addSubview:thrityConinBtn];
    
    UILabel *thrityConinLab = [[UILabel alloc]initWithFrame:CGRectMake(thrityConinBtn.right+12, sendthrityLab.top, 50, 17.0f)];
    thrityConinLab.text = @"500枚";
    thrityConinLab.textAlignment =NSTextAlignmentLeft;
    thrityConinLab.textColor = ZFRGBColor(100, 100, 100);
    [_bgScrollView addSubview:thrityConinLab];


}

- (void)signInEvent:(UIButton *)sender {
}



- (void)earnBeautyCoinEvent:(UIButton *)sender {
    ZFExplanationViewController *explainVC = [[ZFExplanationViewController alloc]init];
    explainVC.titleName = @"赚美丽币";
    explainVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:explainVC animated:YES];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
