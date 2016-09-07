//
//  ZFRequestNothingView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/6.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFRequestNothingView.h"

@interface ZFRequestNothingView ()
{
    UIImageView * _imageView;
    UILabel * _label;

}

@end

@implementation ZFRequestNothingView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 52, 52)];
        UIImage * sadImage = [UIImage imageNamed:@"sad"];
        _imageView.image = sadImage;
        _imageView.center = CGPointMake(self.center.x, self.center.y - 100);
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 60)];
        _label.text = @"亲 ~ 没有加载出内容啊,请稍后重试 ~";
        _label.center = CGPointMake(self.center.x, self.center.y + 10);
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame{
    super.frame = frame;
    _imageView.center = CGPointMake(self.center.x , self.center.y - 100);
    _label.frame = CGRectMake(0, _imageView.frame.origin.y + _imageView.frame.size.height + 20, self.bounds.size.width, 60);
}

- (void)setContent:(NSString *)content{
    _label.text = content;
}

@end
