
//
//  ZFLeftImageButton.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/12.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFLeftImageButton.h"

@implementation ZFLeftImageButton
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
    if ( self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    //设置按钮的图片显示的内容默认为居中
    self.imageView.contentMode = UIViewContentModeCenter;
    
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageY = 10;
    CGFloat imageH = contentRect.size.height-20;
    CGFloat imageX = 15;
    CGFloat imageW = 16;
    _leftSpace = imageX +imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}
//用户返回按钮上标题的位置,传入按钮的rect
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX;
    //获取当前按钮上的文字
    NSString *title = self.currentTitle;
    CGFloat titleH = contentRect.size.height;
    //计算文字的范围
    CGFloat titleW;
    CGSize size = [ZFPublic sizeWithString:title font:[UIFont systemFontOfSize:15.0] maxSize:CGSizeMake(MAXFLOAT, titleH)];
    titleW = size.width+10;
    if (!_leftZero) {
        titleX = _leftSpace;
    }else{
        titleX = (contentRect.size.width -titleW)/2.0;
    }
    CGFloat titleY = 0;
    return CGRectMake(titleX, titleY, titleW, titleH);
}




@end
