//
//  NetwokeManager.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "NetwokeManager.h"
#import "ZFAddressView.h"
#import <RealReachability.h>

@interface NetwokeManager ()

@end

@implementation NetwokeManager


+ (instancetype)shareInstance {
    static NetwokeManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[NetwokeManager alloc]init];
    });
    return _manager;
}

+ (void)requestGetMethodURL:(NSString *)url parameters:(NSDictionary *)parameters uploadPreogerss:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager GET:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
                success(dic);
            }
        }else {
            [[NetwokeManager shareInstance]hudShowError:@"请检查网络设置,数据为空"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
            ZFDEBUGLOG(@"error:%@",error);
        }
    }];
}




+ (void)requestPostMethodURL:(NSString *)url parameters:(NSDictionary *)parameters uploadPreogerss:(void (^)(NSProgress *))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if (dic) {
                success(dic);
            }
        }else {
            [[NetwokeManager shareInstance]hudShowError:@"请检查网络设置,数据为空"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            success(error);
            [[NetwokeManager shareInstance]hudShowError:@"请求失败,请稍后重试"];
        }
    }];

}


#pragma mark------------------NetworkRequestStatus----------------begin-----------------------------

- (void)hudShowLoadingMessage:(NSString *)message {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    for(UIView *subViews in  window.subviews ) {
        if (![subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
            hud.delegate        = self;
            hud.labelText       = message;
            [window addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:30.0f];
            _hudView            = hud;
        }else {
            ZFDEBUGLOG(@"转动的菊花已经存在了");
        }
    }
}


- (void)hudShowMessage:(NSString *)message{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    for(UIView *subViews in  window.subviews ) {
        if (![subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
            hud.delegate        = self;
            hud.labelText       = message;
            [window addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:3.0f];
            _hudView            = hud;
        }else {
            ZFDEBUGLOG(@"转动的菊花已经存在了");
        }
    }

}



- (void)hudShowLoadingWithFrame:(CGRect)frame {
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    [window addSubview:view];
    for(UIView *subViews in window.subviews){
        if (![subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
            hud.delegate        = self;
            [view addSubview:hud];
            [hud show:YES];
            [hud hide:YES afterDelay:30.0f];
            _hudView            = hud;

        }
    }
}



- (void)hudShowSuccess:(NSString *)message {
    [_hudView hide:NO];
    UIWindow *window    = [[UIApplication sharedApplication]keyWindow];
    MBProgressHUD *hud  = [[MBProgressHUD alloc]initWithWindow:window];
    [window addSubview:_hudView];
    hud.customView      = [[UIImageView alloc]initWithImage:[ZFPublic bundleImageName:@"success"]];
    hud.mode            = MBProgressHUDModeCustomView;
    hud.delegate        = self;
    hud.labelText       = message;
    [hud show:YES];
    [hud hide:YES afterDelay:1.50f];
    _hudView = hud;
    
}

- (void)hudShowError:(NSString *)message {
    
    [_hudView hide:NO];
    UIWindow *window   = [[UIApplication sharedApplication]keyWindow];
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithWindow:window];
    [window addSubview:hud];
    hud.customView     = [[UIImageView alloc]initWithImage:[ZFPublic bundleImageName:@"error"]];
    hud.mode           = MBProgressHUDModeCustomView;
    hud.labelText      = message;
    hud.delegate       = self;
    [hud show:YES];
    [hud hide:YES afterDelay:1.0f];
    _hudView           = hud;
}




- (void)hudHidden {
    [_hudView hide:YES afterDelay:0.50f];
}

- (void)hudHiddenImmediately {
    
    [_hudView hide:YES afterDelay:0];
}

- (void)hudHidden:(NSTimeInterval)interal {
    
    [_hudView hide:YES afterDelay:interal];
}

- (void)hudRemoveProgressHud {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIView *subViews in window.subviews ) {
        if ([subViews isKindOfClass:[MBProgressHUD class]]) {
            MBProgressHUD *hud = (MBProgressHUD *)subViews;
            [hud removeFromSuperViewOnHide];
            hud                =nil;
        }
        
    }
}

- (void)updateWindowsWithTitle:(NSString *)title {
    UIWindow *windoe = [[UIApplication sharedApplication]keyWindow];
    CGSize size = [ZFPublic sizeWithString:title font:[UIFont systemFontOfSize:15.0f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat viewWidth  = size.width  +40;
    CGFloat viewHeight = size.height +50;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((ZFScreenWidth -viewWidth)/2.0, (ZFScreenHeight -viewHeight)/2.0, viewWidth, viewHeight)];
    view.backgroundColor = ZFRGBColor(219, 81, 128);
    view.layer.cornerRadius = 8.0f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, size.width, size.height)];
    label.text = title;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [windoe addSubview:view];
    [view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
}

- (void)updateWindowsWithTitle:(NSString *)title withTime:(CGFloat)time {
    UIWindow *windoe = [[UIApplication sharedApplication]keyWindow];
    CGSize size = [ZFPublic sizeWithString:title font:[UIFont systemFontOfSize:15.0f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat viewWidth  = size.width  +40;
    CGFloat viewHeight = size.height +50;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake((ZFScreenWidth -viewWidth)/2.0, (ZFScreenHeight -viewHeight)/2.0, viewWidth, viewHeight)];
    view.backgroundColor = ZFRGBColor(219, 81, 128);
    view.layer.cornerRadius = 8.0f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, size.width, size.height)];
    label.text = title;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [windoe addSubview:view];
    [view addSubview:label];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
    
}
- (void)updateWindowsWithTitle:(NSString *)title subTitle:(NSString *)subTitle expiredTime:(NSString *)time {
    UIWindow *winodw = [[UIApplication sharedApplication]keyWindow];
    CGSize size  = [ZFPublic sizeWithString:time font:ZFFont(15.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize size1 = [ZFPublic sizeWithString:title font:ZFFont(17.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize size2 = [ZFPublic sizeWithString:subTitle font:ZFFont(15.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize maxSize;
    if (size.width >size1.width) {
        if (size.width >size2.width) {
            maxSize = size;
        }
    }else if (size1.width >size2.width){
        maxSize = size1;
    }else {
        maxSize = size2;
    }
    
    CGFloat viewWidth  = maxSize.width +100;
    CGFloat viewHeight = 260;
    ZFAddressView *view = [[ZFAddressView alloc]initWithFrame:CGRectMake((ZFScreenWidth -viewWidth)/2.0, (ZFScreenHeight -viewHeight)/2.0, viewWidth, viewHeight)];
    view.tag = 100;
    view.backgroundColor = [UIColor whiteColor];
    [winodw addSubview:view];
    
    
    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 110)];
    topImage.image = [UIImage imageNamed:@"image_shake_success"];
    [view addSubview:topImage];
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(topImage.width-50, 10, 50, 50)];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"商品详情页关闭按钮"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteRewardsInfoView) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:deleteBtn];
    UIView *tapView = [[UIView alloc]initWithFrame:deleteBtn.frame];
    [view addSubview:tapView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteRewardsInfoView)];
    [tapView addGestureRecognizer:tapGesture];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, topImage.bottom+10, viewWidth, 17)];
    titleLab.text = title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = ZFRGBColor(219, 81, 128);
    [view addSubview:titleLab];
    
    UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLab.bottom+15, viewWidth, 15.0f)];
    infoLabel.text = subTitle;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = ZFRGBColor(100, 100, 100);
    infoLabel.font = ZFFont(15.0f);
    [view addSubview:infoLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, infoLabel.bottom+8, viewWidth, 15.0f)];
    timeLabel.text = time;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = ZFRGBColor(100, 100, 100);
    timeLabel.font = ZFFont(15.0f);
    [view addSubview:timeLabel];
    
    UIButton *lookBtn = [[UIButton alloc]initWithFrame:CGRectMake((viewWidth -maxSize.width)/2.0, viewHeight-40, maxSize.width, 30)];
    [lookBtn setBackgroundColor:ZFRGBColor(219, 81, 128)];
    [lookBtn setTitle:@"查看" forState:UIControlStateNormal];
    [lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lookBtn.titleLabel.font = ZFFont(15.0f);
    [lookBtn addTarget:self action:@selector(lookRewardsInfo:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lookBtn];
    
}

#pragma mark-----方法传到摇一摇界面进行处理
- (void)lookRewardsInfo:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserLookReward object:nil];
}










@end
