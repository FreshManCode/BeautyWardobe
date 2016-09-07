//
//  ZFAddressButton.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFAddressButton.h"

@implementation ZFAddressButton
{
    CGFloat _leftSpace;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.imageView.contentMode = UIViewContentModeCenter;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0;
    CGFloat imageY = (contentRect.size.height-30)/2.0;
    CGFloat imageW = 25;
    CGFloat imageH = 30;
    _leftSpace = imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    NSString *title = self.currentTitle;
    CGSize  size = [ZFPublic sizeWithString:title font:ZFFont(14.0f) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGFloat titleX = _leftSpace +5;
    return CGRectMake(titleX, (contentRect.size.height-size.height)/2.0, size.width, size.height);
}



@end
