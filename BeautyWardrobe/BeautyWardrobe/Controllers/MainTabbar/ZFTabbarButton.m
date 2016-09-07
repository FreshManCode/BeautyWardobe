//
//  ZFTabbarButton.m
//  CustomTabbar
//
//  Created by ZhangJunjun on 16/4/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFTabbarButton.h"

@interface ZFTabbarButton ()


@end


@implementation ZFTabbarButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //图片居中
        self.imageView.contentMode   = UIViewContentModeCenter;
//        //文字居中
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        //文字大小
//        self.titleLabel.font = [UIFont systemFontOfSize:12];
//        //文字默认颜色
//        [self setTitleColor:JZTabbarButtonTitleColor forState:UIControlStateNormal];
//        //文字选中颜色
//        [self setTitleColor:JZTabbarButtonTitleSelectedColor forState:UIControlStateSelected];
        if (!iOS7) {
            //非ios7下,设置按钮选中时的背景
            [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted{}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * JZTabbarButtonRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    CGFloat titleY = contentRect.size.height * JZTabbarButtonRatio;
//    CGFloat titleW = contentRect.size.width;
//    CGFloat titleH = contentRect.size.height -titleY;
//    return CGRectMake(0, titleY, titleW, titleH);
//}

- (void)setItem:(UITabBarItem *)item {
    _item = item;
    //KVO 监听属性的改变
//    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
//    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
//    //设置文字
//    [self setTitle:self.item.title forState:UIControlStateSelected];
//    [self setTitle:self.item.title forState:UIControlStateNormal];
    
    //设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
//    //设置提醒数字
//    self.badgeButton.badgeValue = self.item.badgeValue;
    
//    //设置提醒数字的位置
//    CGFloat badgeY    = 5;
//    CGFloat badgeX    = self.frame.size.width - self.badgeButton.frame.size.width -10;
//    CGRect badgeF     = self.badgeButton.frame;
//    badgeF.origin.x   = badgeX;
//    badgeF.origin.y   = badgeY;
//    self.badgeButton.frame =badgeF;
    
}


- (void)dealloc {
//    [self.item removeObserver:self forKeyPath:@"badgeValue"];
//    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectdImage"];
}


@end
