//
//  ZFBindCoinViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBindCoinViewController.h"
#import "NetwokeManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "ZFBrandListModel.h"
#import <MobClick.h>


@interface ZFBindCoinViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) ZFBrandShareModel *shareModel;
@end

@implementation ZFBindCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self sendRequest];
    [self sendShareConentRequest];
}

- (void)sendRequest {
     if (!_webView ){
        _webView= [[UIWebView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY])];
        _webView.delegate = self;
        _webView.backgroundColor = ZFRGBColor(232, 232, 232);
    }
    [self.view addSubview:_webView];
    NSString *urlString = @"http://www.yuike.com/vmall/3g/vc3g/pageg/loading.php?loadbeautymall=beautymall%3A%2F%2Factivity%3Factivity_id%3D1453189918%26activity_type%3D6&id=457465&aid=0&useragent=beautymall&iframelogin=true&yuikeclientctrl=addclientinfo&vmallid=457465&yk_pid=1&yk_appid=1&yk_user_id=5155032&yk_user_type=6&yk_session=21d90a0d143ba4572b103ce5b36b0d99&yk_device_id=0";
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
}

- (void)sendShareConentRequest {
    NSArray  *array    = [_conisnModel.url componentsSeparatedByString:@"activity_id="];
    NSArray  *array1   = [array[1] componentsSeparatedByString:@"&"];
    NSString *activiID = [NSString stringWithFormat:@"%@%@",@"activity_id=",array1[0]];
    NSString *activiURL  = [NSString stringWithFormat:@"%@/%@%@&%@",ZFBaseURL,@"1.0/activity/detail.php?",activiID,@"mid=457465&sid=8b40be44a760af346fce410805bd1da6&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220"];
    [NetwokeManager requestGetMethodURL:activiURL parameters:nil uploadPreogerss:nil success:^(id data) {
        if ([data[@"msg"] isEqualToString:@"ok"]) {
            [self hanldWithRequestResult:data];
        }
    } failure:^(NSError *error) {
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络情况不好呢"];
    }];
}
- (void)hanldWithRequestResult:(NSDictionary *)dic{
    _shareModel = [[ZFBrandShareModel alloc]initWithDictionary:dic[@"data"]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.rightButton setBackgroundColor:[UIColor clearColor]];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"分享" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.rightButton addTarget:self action:@selector(indinanaShareEventClick:) forControlEvents:UIControlEventTouchUpInside];
    [[NetwokeManager shareInstance]updateWindowsWithTitle:@"加载完成" withTime:1.0f];
}

- (void)indinanaShareEventClick:(UIButton *)sender {
    NSString *picURL = _shareModel.pic_url;
    NSString *urlString = [NSString stringWithFormat:@"http://www.yuike.com/vmall/3g/vc3g/page/goodsall.php?id=%@&&brand_id=%@",_shareModel.merchant_id,_shareModel.idNum];
    if ([picURL length]>0) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:_shareModel.share_message images:@[picURL] url:[NSURL URLWithString:urlString] title:_shareModel.share_title type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                    [MobClick endEvent:@"share"];
                    [[NetwokeManager shareInstance]updateWindowsWithTitle:@"分享成功" withTime:1.0];
                    break;
                case SSDKResponseStateFail:
                    [[NetwokeManager shareInstance]updateWindowsWithTitle:@"分享失败" withTime:1.0f];
                    break;
                default:
                    break;
            }
        }];
    }
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rightButton setBackgroundColor:[UIColor clearColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}


@end
