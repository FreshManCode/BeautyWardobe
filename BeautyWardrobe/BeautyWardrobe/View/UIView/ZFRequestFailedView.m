//
//  ZFRequestFailed.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/3.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFRequestFailedView.h"

@interface ZFRequestFailedView ()<UIScrollViewDelegate>
{
    UIImageView *_sadView;
    UILabel     *_label;
    UIImageView *_refreshView;
}

@end


@implementation ZFRequestFailedView

- (instancetype)init {
    if (self = [super init ]) {
        self.backgroundColor = [UIColor whiteColor];
        _sadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 52, 52)];
        UIImage *sadIamge = [UIImage imageNamed:@"sad"];
        _sadView.image = sadIamge;
        _sadView.center  = CGPointMake(self.center.x-100, self.center.y);
        [self addSubview:_sadView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        _label.text = @"亲~网络不太好哦";
        _label.center = CGPointMake(self.center.x+10, self.center.y);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
        
        _refreshView = [[UIImageView alloc]init];
        _refreshView.image = [UIImage imageNamed:@"down"];
        _refreshView.frame = CGRectMake(0, 0, 16, 16);
        [self addSubview:_refreshView];
        self.scrollEnabled = YES;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    super.frame = frame;
    self.contentSize = CGSizeMake(frame.size.width, frame.size.height+50);
     _sadView.center = CGPointMake(self.center.x, self.center.y-150);
    _label.frame    = CGRectMake(0, _sadView.frame.origin.y + _sadView.frame.size.height + 20, self.bounds.size.width, 60);
    _refreshView.center = CGPointMake(self.center.x, self.center.y+50);
    
}








@end
