//
//  ZFAddAddressViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/25.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFAddAddressViewController.h"
#import "ZFAddressView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "NetwokeManager.h"
#import "ZFUserDefaults.h"
@interface ZFAddAddressViewController ()<UIScrollViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong) ZFAddressView *manView;
@property (nonatomic,strong) UITextField   *manTextTf;
@property (nonatomic,strong) ZFAddressView *phoneView;
@property (nonatomic,strong) UITextField   *phoneTextTf;
@property (nonatomic,strong) ZFAddressView *areaView;
@property (nonatomic,strong) UITextField   *areaTestTf;
@property (nonatomic,strong) UILabel       *areaLab;
@property (nonatomic,strong) UIButton      *areaBtn;
@property (nonatomic,strong) ZFAddressView *detailView;
@property (nonatomic,strong) UITextField   *detailTextTf;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) UIButton      *successBtn;


@property (nonatomic,strong) UIScrollView  *bgScroll;


@end

@implementation ZFAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    
}

- (void)setUpSubviews {
    self.titleLabel.text = @"我的收获地址";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    
    
    if (!_bgScroll) {
        _bgScroll = [[UIScrollView alloc]initWithFrame:
        CGRectMake(0, [self getStartOriginY]+10, ZFScreenWidth, ZFScreenHeight-[self getStartOriginY]-10)];
        _bgScroll.contentSize = CGSizeMake(ZFScreenWidth, ZFScreenHeight+50);
        _bgScroll.delegate = self;
        _bgScroll.bounces = YES;
    }
    [self.view addSubview:_bgScroll];
    
    if (!_manView) {
        _manView = [[ZFAddressView alloc]initWithFrame:CGRectMake(10, 0, ZFScreenWidth-20, 50) leftIcon:@"image_ic_user" title:@"收 件 人:" rightImageIcon:nil];
        _manView.layer.borderColor = ZFRGBColor(213, 213, 213).CGColor;
        _manView.layer.borderWidth = 1.0f;
        
        [_manView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            if ([obj isKindOfClass:[UITextField class]]) {
                _manTextTf = obj;
                _manTextTf.text = _manName;
                _manTextTf.clearButtonMode = UITextFieldViewModeWhileEditing;
            }
        }];
    }
    [_bgScroll addSubview:_manView];
    
    if (!_phoneView) {
        _phoneView = [[ZFAddressView alloc]initWithFrame:CGRectMake(10, _manView.bottom-1, ZFScreenWidth-20, 50) leftIcon:@"image_ic_phone" title:@"手 机 号:" rightImageIcon:nil];
        _phoneView.layer.borderColor = ZFRGBColor(213, 213, 213).CGColor;
        _phoneView.layer.borderWidth = 1.0f;
        [_phoneView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            if ([obj isKindOfClass:[UITextField class]]) {
                _phoneTextTf = obj;
                _phoneTextTf.text = _phoneNum;
                _phoneTextTf.clearButtonMode = UITextFieldViewModeWhileEditing;
                _phoneTextTf.keyboardType = UIKeyboardTypeNumberPad;
                _phoneTextTf.autocorrectionType = UITextAutocorrectionTypeNo;
            }
        }];
    }
    [_bgScroll addSubview:_phoneView];
    
    if (!_areaView) {
        _areaView = [[ZFAddressView alloc]initWithFrame:CGRectMake(10, _phoneView.bottom-1, ZFScreenWidth-20, 50) leftIcon:@"image_ic_map" title:@"所在区域:" rightImageIcon:@"address_icon_locate_un"];
        _areaView.layer.borderColor = ZFRGBColor(213, 213, 213).CGColor;
        _areaView.layer.borderWidth = 1.0f;
        _areaLab = [UILabel new];
        _areaLab.text = _address;
        _areaLab.font = ZFFont(13.0f);
        [_areaView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
        {
            if ([obj isKindOfClass:[UITextField class]]) {
                _areaTestTf = obj;
                _areaTestTf.userInteractionEnabled = NO;
                _areaLab.frame = _areaTestTf.frame;
            }else if ([obj isKindOfClass:[UIButton class]]){
                _areaBtn = obj;
                [_areaBtn addTarget:self action:@selector(locatedPositionEvent:) forControlEvents:UIControlEventTouchUpInside];
            }
        }];
        [_areaView addSubview:_areaLab];
        _areaLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(appearPickerView:)];
        [_areaLab addGestureRecognizer:tapGesture];
        
    }
    [_bgScroll addSubview:_areaView];
    
    if (!_detailView) {
        _detailView = [[ZFAddressView alloc]initWithFrame:CGRectMake(10, _areaView.bottom-1, ZFScreenWidth-20, 50) leftIcon:@"image_ic_file" title:@"详细地址:" rightImageIcon:nil];
        _detailView.layer.borderColor = ZFRGBColor(213, 213, 213).CGColor;
        _detailView.layer.borderWidth = 1.0f;
        [_detailView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
            if ([obj isKindOfClass:[UITextField class]]) {
                _detailTextTf = obj;
                _detailTextTf.text = _detail;
                _detailTextTf.clearButtonMode = UITextFieldViewModeWhileEditing;
            }
        }];
        
        
    }
    [_bgScroll addSubview:_detailView];
    
    if (!_successBtn) {
        _successBtn = [[UIButton alloc]initWithFrame:CGRectMake((ZFScreenWidth-100)/2.0, _detailView.bottom+40, 100, 40)];
        [_successBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_successBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
        _successBtn.titleLabel.font = ZFFont(15.0f);
        [_successBtn addTarget:self action:@selector(finishAddAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_bgScroll addSubview:_successBtn];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self respondsToSelector:@selector(makeKeyboardDismiss)]) {
        [self makeKeyboardDismiss];
    }
}



- (void)makeKeyboardDismiss {
    if ([_manTextTf respondsToSelector:@selector(resignFirstResponder)]) {
        [_manTextTf resignFirstResponder];
    }if ([_phoneTextTf respondsToSelector:@selector(resignFirstResponder)]) {
        [_phoneTextTf resignFirstResponder];
    }if ([_detailTextTf respondsToSelector:@selector(resignFirstResponder)]) {
        [_detailTextTf resignFirstResponder];
    }
}

#pragma mark------完成的点击按钮
//说明中间有个sign签名算法,不知道逻辑
- (void)finishAddAddressEvent:(UIButton *)sender {
    [self checkParameters];
    [self makeKeyboardDismiss];
    
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/address/save.php?";
    NSString *rightPart = [NSString stringWithFormat:@"&mid=457465&sid=%@&sign=7c9a18fa1b013329250428414b06f72e&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
    NSDictionary *params = nil;
    NSArray *addressArray = [_areaLab.text componentsSeparatedByString:@" "];
    @try {
        params = @{@"address" :addressArray[0],
                   @"phone"   :_phoneTextTf.text,
                   @"city"    :addressArray[0],
                   @"id"      :@"0",
                   @"area"    :addressArray[0],
                   @"mid"     :@"457465",
                   @"name"    :_manTextTf.text,
                   @"province":addressArray[0]
                   };
    }
    @catch (NSException *exception) {
        ZFDEBUGLOG(@"params:%@",params);
        ZFDEBUGLOG(@"environment is error:%@",exception);
    }
    [NetwokeManager requestPostMethodURL:urlString parameters:params uploadPreogerss:nil success:^(id data) {
        if ([data isKindOfClass:[NSDictionary class]]&& [data[@"ret"] integerValue]==0) {
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"添加地址成功" withTime:1.0f];
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"添加地址失败" withTime:1.0f];
        }
        
    } failure:^(NSError *error) {
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络不好呢" withTime:1.0f];
    }];
    
}




- (void)checkParameters {
    if ([_manTextTf.text length]<1) {
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"请填写正确的姓名" withTime:1.5f];
        return;
    }else if ([_phoneTextTf.text length]<1){
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"请填写正确的手机号" withTime:1.5f];
        return;
    }else if ([_areaLab.text length]<1){
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"请填写正确的所在区" withTime:1.5f];
        return;
    }else if ([_detailTextTf.text length]<1){
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"请填写正确的详细地址" withTime:1.5f];
        return;
    }
}



- (void)appearPickerView:(UITapGestureRecognizer *)gesture {
    ZFDEBUGLOG(@"这是出现pickerView的界面");
    [self makeKeyboardDismiss];
}

- (void)locatedPositionEvent:(UIButton *)sender {
    [self makeKeyboardDismiss];
    CLLocationManager *locationManager = [[CLLocationManager alloc]init];
    self.locationManager = locationManager;
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //该api是Ios8以后才出现的,同时需要在plist问价修改
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];

    }
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = [locations firstObject];
//    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
//    ZFDEBUGLOG(@"旧的经度:%f,旧的纬度:%f",oldCoordinate.longitude,oldCoordinate.latitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil||placemarks.count==0) {
            ZFDEBUGLOG(@"%@",error);
            return ;
        }
        for(CLPlacemark *place in placemarks){
            NSString *location = [NSString stringWithFormat:@"%@ %@",place.locality,place.subLocality];
            [_areaLab setText:location];
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
