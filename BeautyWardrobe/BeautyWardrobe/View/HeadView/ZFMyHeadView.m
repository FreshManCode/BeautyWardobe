//
//  ZFMyHeadView.m
//  
//
//  Created by ZhangJunjun on 16/5/6.
//
//

#import "ZFMyHeadView.h"
#import <Masonry.h>
#import "ZFUserDefaults.h"
#import "ZFLoginViewController.h"
#import <UIImageView+WebCache.h>

@interface ZFMyHeadView ()
{
    UIImageView  *_bgImage;
    UIImageView  *_headImage;
    UILabel      *_userNameLab;
    UIButton     *_messageBtn;
    UIScrollView *_bgScrollView;
    UIButton     *_loginBtn;
    UILabel      *_desLab;
}

@end

@implementation ZFMyHeadView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userLoginSuccess:) name:kUserIsLogin object:nil];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, self.height)];
    _bgScrollView.contentSize = CGSizeMake(ZFScreenWidth, 281/2.0);
    _bgScrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bgScrollView];
    if ([ZFPublic userIsLogin]) {
        [self createLoginHeadView];
    }else {
        [self createUnloginHeadView];
    }
}

- (void)createLoginHeadView {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake((ZFScreenWidth-75)/2.0, 28, 75, 75)];
        _headImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userUploadImage:)];
        [_headImage addGestureRecognizer:tapGesture];
        [_headImage.layer masksToBounds];
        _headImage.layer.cornerRadius = 75/2.0;
        _headImage.layer.borderWidth = 5.0;
        _headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _headImage.clipsToBounds = YES;
        [_bgScrollView addSubview:_headImage];
    }
    _userNameLab = [UILabel new];
    _userNameLab.font = [UIFont systemFontOfSize:13.0];
    _userNameLab.textAlignment = NSTextAlignmentCenter;
    [_bgScrollView addSubview:_userNameLab];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bgScrollView).offset(_bgScrollView.height- 16);
        make.centerX.equalTo(_headImage);
        make.height.equalTo(@(14));
        make.width.equalTo(@(200));
    }];
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setBackgroundImage:[UIImage imageNamed:@"button_message"] forState:UIControlStateNormal];
    [_bgScrollView addSubview:_messageBtn];
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgScrollView).offset(ZFScreenWidth- 47/2.0);
        make.centerY.equalTo(_headImage);
        make.height.equalTo(@(111/2.0));
        make.width.equalTo(@(111/2.0));
    }];
    [_desLab setHidden:YES];
    [_loginBtn setHidden:YES];

}

- (void)createUnloginHeadView {
    _desLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, ZFScreenWidth, 15.0)];
    _desLab.text = @"登录美丽衣橱,有神秘惊喜哦";
    _desLab.textAlignment =NSTextAlignmentCenter;
    _desLab.font = [UIFont systemFontOfSize:15.0];
    [_bgScrollView addSubview:_desLab];
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_bgScrollView addSubview:_loginBtn];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_desLab);
        make.centerY.equalTo(_desLab).offset(45);
        make.height.equalTo(@(35));
        make.width.equalTo(@(75));
    }];
    [_headImage setHidden:YES];
    [_userNameLab setHidden:YES];
    [_messageBtn setHidden:YES];

}



- (UIImage *)oldImage:(UIImage *)image borderWith:(CGFloat)borderWith borderColor:(UIColor *)borderColor {
    UIImage *oldImage = image;
    CGFloat imageW = oldImage.size.width + 22*borderWith;
    CGFloat imageH = oldImage.size.height + 22*borderWith;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [borderColor set];
    CGFloat bigRadius = imageW*0.5;
    CGFloat centnerX  = bigRadius;
    CGFloat centerY   = bigRadius;
    CGContextAddArc(ctx, centerY, centerY, bigRadius, 0, M_PI*2, 0);
    CGContextFillPath(ctx);
    
    CGFloat smallRadius = bigRadius - borderWith;
    CGContextAddArc(ctx, centnerX, centerY, smallRadius, 0, M_PI*2, 0);
    CGContextClip(ctx);
    
    [oldImage drawInRect:CGRectMake(borderWith, borderWith, oldImage.size.width, oldImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
    
}



- (void)loginEvent:(UIButton *)sender {
    if (_headDelegate &&[_headDelegate respondsToSelector:@selector(loginEvent)]) {
        [_headDelegate loginEvent];
    }
}


- (void)userUploadImage:(UITapGestureRecognizer *)gesture {
    if (_headDelegate &&[_headDelegate respondsToSelector:@selector(didClickUserImage)]) {
        [_headDelegate didClickUserImage];
    }
}

- (void)userLoginSuccess:(NSNotification *)noti{
    [self createLoginHeadView];
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:kUserHeadImage];
    UIImage *headImage = [[UIImage alloc]initWithContentsOfFile:path];
    [_headImage setImage:headImage];
    NSString *url = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:kUserHeadImageURL];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    [_userNameLab setText:[[ZFUserDefaults shareInstance]getAccessTokenWithKey:kUserName]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
