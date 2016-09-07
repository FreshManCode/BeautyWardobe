//
//  ZFLoginViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFLoginViewController.h"
#import "ZFAccountView.h"
#import "NetwokeManager.h"
#import <Masonry.h>
#import "ZFTipsView.h"
#import "ZFUserDefaults.h"
#import "ZFHomeViewController.h"
#import "ZFMainTabbarController.h"
#import "ZFMyViewController.h"
@interface ZFLoginViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong) UIScrollView  *bgScroll;
@property (nonatomic,strong) ZFAccountView *accountView;
@property (nonatomic,strong) UITextField   *accountTextTf;

@property (nonatomic,strong) ZFAccountView *passwordView;
@property (nonatomic,strong) UITextField   *passwordTextTf;

@property (nonatomic,strong) UIView        *thirdView;
@property (nonatomic,strong) UIButton      *loginBtn;
@property (nonatomic,strong) UILabel       *forgetLab;

@end

@implementation ZFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpSubViews {
    self.titleLabel.text = @"登录";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    CGFloat x = 10;
    CGFloat y = 20;
    CGFloat w = ZFScreenWidth;
    CGFloat h = 40;
    if (!_bgScroll) {
        _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-64)];
        _bgScroll.showsVerticalScrollIndicator = YES;
        _bgScroll.backgroundColor = [UIColor whiteColor];
        _bgScroll.delegate        = self;
        _bgScroll.contentSize     = CGSizeMake(ZFScreenWidth,ZFScreenHeight+ (ZF_IS_IPHONE4?100:10)-[self getStartOriginY]);
        _bgScroll.bounces         = YES;
    }
    [self.view addSubview:_bgScroll];
    
    if (!_accountView) {
        _accountView = [[ZFAccountView alloc]accoutViewFrame:CGRectMake(x, y, w-20, h) leftImageName:@"login_pass_icon" placeHolder:@"手机号" rightText:nil];
        _accountView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_accountView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UITextField class]]) {
                _accountTextTf = obj;
                _accountTextTf.autocorrectionType = UITextAutocorrectionTypeNo;
                _accountTextTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
                _accountTextTf.keyboardType = UIKeyboardTypeNumberPad;
                
            }
        }];
    }
    [_bgScroll addSubview:_accountView];
    
    y += h + 16;
    if (!_passwordView) {
        _passwordView = [[ZFAccountView alloc]accoutViewFrame:CGRectMake(x, y, w-20, h) leftImageName:@"login_user_icon" placeHolder:@"密码" rightText:@"忘记密码?"];
        _passwordView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_passwordView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UITextField class]]) {
                _passwordTextTf = obj;
                _passwordTextTf.autocorrectionType = UITextAutocorrectionTypeNo;
                _passwordTextTf.autocapitalizationType = UITextAutocapitalizationTypeNone;
                _passwordTextTf.returnKeyType = UIReturnKeyDone;
                _passwordTextTf.keyboardType = UIKeyboardTypeEmailAddress;
                _passwordTextTf.secureTextEntry = YES;
            }else if ([obj isKindOfClass:[UILabel class]]){
                _forgetLab = obj;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetPasswordEvent)];
                _forgetLab.userInteractionEnabled = YES;
                [_forgetLab addGestureRecognizer:tap];
            }
            
            
        }];
    }
    [_bgScroll addSubview:_passwordView];
    
    y += h+41;
    _loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w-20,h)];
    _loginBtn.backgroundColor = ZFRGBColor(255, 69, 125);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginEventClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScroll addSubview:_loginBtn];
    
    y += h+16;
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w-20, h)];
    registerBtn.backgroundColor = [UIColor whiteColor];
    registerBtn.layer.borderWidth = 1.0;
    registerBtn.layer.borderColor = ZFRGBColor(255, 69, 125).CGColor;
    [registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:ZFRGBColor(255, 69, 125) forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerEventClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScroll addSubview:registerBtn];
    
    
    if (!_thirdView) {
        _thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, _bgScroll.height-140, ZFScreenWidth, 120)];
        _thirdView.backgroundColor = [UIColor whiteColor];
    }
    [_bgScroll addSubview:_thirdView];
    
    NSString *thirdPart = @"第三方账号登录";
    CGSize size = [ZFPublic sizeWithString:thirdPart font:[UIFont systemFontOfSize:(ZF_IS_IPHONE4OR5?15.0:17.0)] maxSize:CGSizeMake(120, 20)];
    UIView *leftLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+10, (ZFScreenWidth-size.width)/2.0, 1.0)];
    leftLineView.backgroundColor = [UIColor lightGrayColor];
    [_thirdView addSubview:leftLineView];
    
    UILabel *thirdLabel = [UILabel new];
    thirdLabel.center   = CGPointMake(leftLineView.right+size.width/2.0, leftLineView.bottom-1);
    thirdLabel.bounds   = CGRectMake(0, 0, size.width, 20);
    thirdLabel.text = thirdPart;
    thirdLabel.textColor = [UIColor lightGrayColor];
    thirdLabel.font = [UIFont systemFontOfSize:(ZF_IS_IPHONE4OR5?15.0:17.0)];
    [_thirdView addSubview:thirdLabel];
    
    UIView *rightLineView = [UIView new];
    rightLineView.center  = CGPointMake(thirdLabel.right+leftLineView.width/2.0, thirdLabel.center.y);
    rightLineView.bounds  = CGRectMake(0, 0, leftLineView.width, 1.0);
    rightLineView.backgroundColor = [UIColor lightGrayColor];
    [_thirdView addSubview:rightLineView];
    
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxBtn.center = CGPointMake(thirdLabel.center.x, thirdLabel.center.y+45);
    wxBtn.bounds = CGRectMake(0, 0, 60, 60);
    [wxBtn setBackgroundImage:[UIImage imageNamed:@"login_wx_btn"] forState:UIControlStateNormal];
    [wxBtn addTarget:self action:@selector(wxLoginEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_thirdView addSubview:wxBtn];
    
}

- (void)wxLoginEvent:(UIButton *)sender {
    [ZFPublic showMessage:@"微信授权登录,没有账号"];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self makeKeybordDismiss];
}

- (void)makeKeybordDismiss {
    if ([_accountTextTf respondsToSelector:@selector(resignFirstResponder)]) {
        [_accountTextTf resignFirstResponder];
    }
    if ([_passwordTextTf respondsToSelector:@selector(resignFirstResponder)]) {
        [_passwordTextTf resignFirstResponder];
    }
}


- (void)checkLoginParameter {
    if ([_accountTextTf.text length]<1) {
        [ZFTipsView showText:@"请输入账号" inView:_bgScroll withOriginY:_passwordView.bottom +20];
        return;
    }
    if ([_passwordTextTf.text length]<1) {
        [ZFTipsView showText:@"请输入密码" inView:_bgScroll withOriginY:_passwordView.bottom +20];

        return;
    }
    [[NetwokeManager shareInstance]hudShowLoadingMessage:@"登录中..."];
    NSString *loginURL = @"http://vapi.yuike.com/1.0/user/login.php?mid=457465&phone=18205622972&pwd=0ef07b64f7e659d807502d2a1fcaea3b&sid=280193f396365781454824dcc49e7370&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220&sign=db3e2721fb84f3ab90d8ba4310530281";
    [NetwokeManager requestGetMethodURL:loginURL parameters:nil uploadPreogerss:nil success:^(id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            [self hanleWithLoginResult:data];
        }
    } failure:^(NSError *error) {
        [[NetwokeManager shareInstance]hudHiddenImmediately];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络不是太好呢" withTime:1.0f];

    }];
    
}
- (void)hanleWithLoginResult:(NSDictionary *)dic {
    if ([dic[@"msg"] isEqualToString:@"ok"]) {
        [[NetwokeManager shareInstance]hudHiddenImmediately];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"登录成功" withTime:1.0f];
        if (dic[@"data"][@"expired_time"]) {
             NSString *expireTime = [NSString stringWithFormat:@"%@",dic[@"data"][@"expired_time"]];
            [[ZFUserDefaults shareInstance]setObject:expireTime WithKey:ZFLoginSuccessToken];
            NSString *logoUrl   = dic[@"data"][@"user"][@"user_image_url"];
            NSString *userName  = dic[@"data"][@"user"][@"user_name"];
            NSString *seeeionID = dic[@"data"][@"session_id"];
            [[ZFUserDefaults shareInstance]setObject:userName WithKey:kUserName];
            [[ZFUserDefaults shareInstance]setObject:logoUrl WithKey:kUserHeadImageURL];
            [[ZFUserDefaults  shareInstance]setObject:seeeionID WithKey:ZFUserSID];
            [[NSNotificationCenter defaultCenter]postNotificationName:kUserIsLogin object:logoUrl];
             [self.navigationController popViewControllerAnimated:YES];
        }else{
           [[NetwokeManager shareInstance]updateWindowsWithTitle:@"登录失败" withTime:1.0f];
        }
    }else {
        [[NetwokeManager shareInstance]hudHiddenImmediately];
        NSString *errorMsg = dic[@"msg"];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:errorMsg withTime:1.0f];
     }
}

//忘记密码
- (void)forgetPasswordEvent {
    [ZFPublic showMessage:@"这应该前往忘记密码界面"];
}



- (void)loginEventClick:(UIButton *)sender {
    [self makeKeybordDismiss];
    [self checkLoginParameter];
    
}

- (void)registerEventClick:(UIButton *)sender {
    [self makeKeybordDismiss];
     [ZFPublic showMessage:@"这应该前往注册页面"];
}

@end
