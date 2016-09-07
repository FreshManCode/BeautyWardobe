//
//  ZFRefreshHeader.m
//  BeautyWardrobe
//
//  Created by 巴巴罗萨 on 16/9/1.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFRefreshHeader.h"

#pragma mark - Const
CGRect kZZZLogoViewBounds = {0,0,25,25};
@interface ZFRefreshHeader ()
@property (nonatomic,strong) UIImageView *logoView;
@property (nonatomic,strong) UILabel *refreshLab;
@property (nonatomic,assign) BOOL    hasRefresh;
@end



@implementation ZFRefreshHeader

- (void)prepare {
    [super prepare];
}

- (void)placeSubviews {
    [super placeSubviews];
    self.hasRefresh = NO;
    self.logoView.center   = CGPointMake(self.mj_w/2.0-70, self.mj_h/2.0);
    self.logoView.bounds   = kZZZLogoViewBounds;
    self.refreshLab.frame  = CGRectMake(self.center.x-40, (self.mj_h-15)/2.0, self.mj_w/3.0, 15);
    [self addSubview:self.logoView];
    [self addSubview:self.refreshLab];
}

- (UIImageView *)logoView {
    if (!_logoView) {
        _logoView = [[UIImageView alloc]init];
        _logoView.image = [UIImage imageNamed:@"image_ego_refresh"];
    }
    return _logoView;
}

- (UILabel *)refreshLab {
    if (!_refreshLab) {
        _refreshLab = [[UILabel alloc]init];
        _refreshLab.font = ZFFont(14.0f);
        _refreshLab.textAlignment = NSTextAlignmentCenter;
    }
    return _refreshLab;
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState ;
    switch (state) {
        case MJRefreshStateIdle :
//            if (self.hasRefresh) {
//                [self.logoView.layer addAnimation:[self getUnclockwiseTransAnimationIsPulling:NO] forKey:nil];
//            }
            [_refreshLab setText:@"下拉刷新"];
            self.hasRefresh = NO;
            break;
        case MJRefreshStatePulling:
//            [self getUnclockwiseTransAnimationIsPulling:YES];
            [_refreshLab setText:@"松开刷新数据"];
            break;
        case MJRefreshStateRefreshing:
            [_refreshLab setText:@"正在加载..."];
            [self.logoView.layer addAnimation:[self getTransformAnimation] forKey:nil];
//            self.hasRefresh = YES;
            break;
        case MJRefreshStateWillRefresh:
            break;
        default:
            break;
    }
}

- (CABasicAnimation *)getTransformAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration  = 2.0f;
    animation.speed     = 5.0f;
    animation.byValue   = @(M_PI * 2);
    animation.fillMode  = kCAFillModeForwards;
    animation.repeatCount = 1000;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CABasicAnimation *)getUnclockwiseTransAnimationIsPulling:(BOOL)isPulling {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration  = 2.0f;
    animation.speed     = isPulling ? 0 : 5.0f;
    animation.byValue   = @(M_PI * -2);
    animation.fillMode  = kCAFillModeForwards;
    animation.repeatCount = 1000;
    animation.removedOnCompletion = NO;
    return animation;
}


- (void)endRefreshing {
    [self.logoView.layer removeAllAnimations];
    [super endRefreshing ];
    
}
@end
