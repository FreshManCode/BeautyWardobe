//
//  ZFLeftTitleButton.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/12.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFLeftTitleButton.h"

@implementation ZFLeftTitleButton
{
    CGFloat _right;
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
    self.myFont = [UIFont systemFontOfSize:15.0];
    self.titleLabel.font = self.myFont;
    self.imageView.contentMode = UIViewContentModeCenter;
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX =0 ;
    NSString *title = self.currentTitle;
    CGSize  size = [ZFPublic sizeWithString:title font:self.myFont maxSize:CGSizeMake(MAXFLOAT, contentRect.size.height)];
    CGFloat titleW = size.width+5;
    _right = titleW ;
    return CGRectMake(titleX,(contentRect.size.height- size.height)/2.0, titleW,size.height);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = 15;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageY = 0;
    CGFloat imageX = _right;
    return CGRectMake(imageX, imageY, imageW, imageH);
}



@end
