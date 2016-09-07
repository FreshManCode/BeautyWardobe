//
//  ZFShakeInfoViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFShakeInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import "NetwokeManager.h"
#import "ZFShakeListModel.h"


@interface ZFShakeInfoViewController ()<UIScrollViewDelegate>
{
    UIImageView    *_bgImage;
    UIScrollView   *_bottomScroll;
    UIButton       *_threeTimeBtn;
    NSMutableArray *_bottomContentArray;
    NSTimer        *_timer;
}
@property (nonatomic,strong) UIImageView *shakeImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,assign) BOOL    isStop;

@end

@implementation ZFShakeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication]setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
    _isStop = NO;
    _bottomContentArray = [[NSMutableArray alloc]initWithCapacity:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAnimations) name:@"shake" object:nil];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    self.titleLabel.text = @"摇一摇抽奖了";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY]-120)];
        _bgImage.image = [UIImage imageNamed:@"image_shake_bg"];
    }
    [self.view addSubview:_bgImage];
    
    if (!_shakeImage) {
        _shakeImage = [[UIImageView alloc]initWithFrame:CGRectMake((ZFScreenWidth -424/2.0)/2.0, 137/2.0, 424/2.0, 424/2.0)];
        _shakeImage.image = [UIImage imageNamed:@"image_shake_phone"];
    }
    [_bgImage addSubview:_shakeImage];
    
    if (!_threeTimeBtn) {
        _threeTimeBtn = [[UIButton alloc]initWithFrame:CGRectMake((ZFScreenWidth -348/2.0)/2.0, _bgImage.height-(83+93)/2.0, 348/2.0, 93/2.0)];
        [_threeTimeBtn setImage:[UIImage imageNamed:@"image_shake_daybg" ] forState:UIControlStateNormal];
      }
    UILabel *threeLab = [[UILabel alloc]initWithFrame:CGRectMake(104/2.0, 12, 110, 15.0)];
    threeLab.textAlignment = NSTextAlignmentLeft;
    threeLab.text = @"每人每天可摇3次";
    threeLab.font = [UIFont systemFontOfSize:14.0f];
    threeLab.textColor = [UIColor whiteColor];
    [_threeTimeBtn addSubview:threeLab];
    
    [_bgImage addSubview:_threeTimeBtn];
    if (!_bottomScroll) {
        _bottomScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ZFScreenHeight-120, ZFScreenWidth, 120)];
        _bottomScroll.delegate = self;
        _bottomScroll.showsHorizontalScrollIndicator = NO;
        _bottomScroll.showsVerticalScrollIndicator = NO;
        _bottomScroll.userInteractionEnabled = NO;
    }
    [self.view addSubview:_bottomScroll];
    [self sendBottomContentRequest];
    
}

- (void)addAnimations {
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.fromValue = [NSValue valueWithCGPoint:_shakeImage.center];
    CGFloat x = _shakeImage.center.x;
    CGFloat y = _shakeImage.center.y;
    translation.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y-50)];
    translation.duration = 0.5;
    translation.repeatCount = 3;
    translation.autoreverses = YES;
    [_shakeImage.layer addAnimation:translation forKey:@"translation"];
}



- (void)sendBottomContentRequest {
    NSString *urlString = @"http://vapi.yuike.com/1.0/shake/list.php?mid=457465&sid=e61220782bc1026de0b491541938e8b8&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032";
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data &&[data[@"msg"] isEqualToString:@"ok"]) {
            [self hanleWithBottomJsonResult:data[@"data"]];
        }else{
            [ZFPublic showMessage:@"当前没有内容"];
        }
    } failure:^(NSError *error) {
        [ZFPublic showMessage:@"网络问题,请检查网络"];
    }];
}

- (void)hanleWithBottomJsonResult:(NSDictionary *)dic{
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSArray  *array  in dic[@"shake_list"]){
        [tempArray addObject:array];
    }
    for(int i= 0;i<tempArray.count;i++){
        ZFShakeListModel *model = [[ZFShakeListModel alloc]initWithDictionary:tempArray[i]];
        [_bottomContentArray addObject:model];
    }
    
    for(int i=0;i<_bottomContentArray.count;i++){
        ZFShakeListModel *model = _bottomContentArray[i];
        CGSize size = [ZFPublic sizeWithString:model.user_name font:[UIFont systemFontOfSize:14.0f] maxSize:CGSizeMake(MAXFLOAT, 25)];
        CGFloat labWidth  = size.width;
        CGFloat labHeight = 25;
        CGFloat labX      = 15.0;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(labX, i*labHeight, labWidth, 25.0)];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        _nameLabel.text = model.user_name;
        _nameLabel.textColor = ZFRGBColor(219, 81, 128);
        [_bottomScroll addSubview:_nameLabel];
        
        CGSize contentSize = [ZFPublic sizeWithString:model.message font:[UIFont systemFontOfSize:14.0f] maxSize:CGSizeMake(MAXFLOAT, 25)];
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(_nameLabel.right+2, i*labHeight, contentSize.width, 25)];
        _contentLabel.textColor = ZFRGBColor(100, 100, 100);
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        _contentLabel.text = model.message;
        [_bottomScroll addSubview:_contentLabel];
    }
    if (_bottomContentArray.count >0) {
        _bottomScroll.contentSize = CGSizeMake(ZFScreenWidth, _bottomContentArray.count*25);
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(makeScrollToTop:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];

}


#pragma mark------开始移动的方法,在这里进行网络请求
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self broadCastMusic];
    //yk_user_id=5155032 这个id是用户的登录成功之后返回的,由于未能破解登录时签名算法和加密算法,因此这个id是固定的
    NSString *requestURL = @"http://vapi.yuike.com/1.0/shake/post.php?mid=457465&sid=21d90a0d143ba4572b103ce5b36b0d99&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032";
    [NetwokeManager requestGetMethodURL:requestURL parameters:nil uploadPreogerss:nil success:^(id data) {
         if (data &&[data isKindOfClass:[NSDictionary class]]) {
             if ([data[@"ret"] integerValue]==0) {
                 [self hanldeWithShakeResult:data];
             }else{
                 [[NetwokeManager shareInstance]updateWindowsWithTitle:data[@"msg"] withTime:1.0f];
             }
        }else{
            [ZFPublic showMessage:@"请检查网络或者参数"];
        }
    } failure:^(NSError *error) {
        [ZFPublic showMessage:@"请检查网络问题"];
    }];
}


- (void)broadCastMusic {
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"motionShake.mp3" withExtension:nil];
//    NSString *url = [[NSBundle mainBundle]pathForResource: ofType:nil];;
    SystemSoundID soundID  ;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    //播放声音
    AudioServicesPlaySystemSound(soundID);
}


#pragma mark------对于摇一摇结果的处理,没完善
- (void)hanldeWithShakeResult:(NSDictionary *)dic{
    if ([dic[@"msg"] isEqualToString:@"ok"]) {
        [self performSelector:@selector(appearResult:) withObject:dic[@"data"] afterDelay:2.80f];
    }else{
        NSString *title = dic[@"data"][@"title"];
        [self performSelector:@selector(apperTips:) withObject:title afterDelay:2.80f];
    }
}

- (void)apperTips:(NSString *)title{
     [ZFPublic updateWindowsWithTitle:title];
}

- (void)appearResult:(NSDictionary *)dic {
    NSString *title    = dic[@"data"][@"prize_title"];
    NSArray *array = dic[@"data"][@"messages"];
    NSString *subTitle = array[0];
    NSString *time = array[1];
    [ZFPublic updateWindowsWithTitle:title subTitle:subTitle expiredTime:time];

}


- (void)makeScrollToTop:(NSTimer *)timer{
    static NSInteger index =1;
    CGPoint newOffset = _bottomScroll.contentOffset;
    newOffset.y = index*25;
    if(newOffset.y>25*(_bottomContentArray.count-1)){
        newOffset.y =0;
    }

    [UIView animateKeyframesWithDuration:0.4 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
    } completion:^(BOOL finished) {
            [_bottomScroll setContentOffset:newOffset];
    }];
    index++;
    if (index>_bottomContentArray.count-5) {
        [_bottomScroll setContentOffset:CGPointZero];
        index =0;
    }
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//说明,要想实现先停止然后在某种情况下再次开启运行time,可以使用下面的方法,注意这时关闭定时器一定不能使用:下面的方法
//取消定时器
//[timer invalidate];

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
