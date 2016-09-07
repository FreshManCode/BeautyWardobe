//
//  ZFTipsView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFTipsView.h"

@implementation ZFTipsView
#define TTHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

+ (ZFTipsView *)shareView {
    static ZFTipsView *view;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        view = [[ZFTipsView alloc]init];
    });
    return view;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.during = 3.0;
        self.backView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.backView];
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = TTHexColor(0xff0000);
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.numberOfLines = 0;
        [self addSubview:self.textLabel];
        
    }
    
    return self;
    
    
}


- (void)showInView:(UIView *)superView
{
    if(superView)
    {
        [superView addSubview:self];
    }else
    {
        [[[[UIApplication sharedApplication]delegate] window] addSubview:self];
    }
    
    NSTimeInterval time = self.during;
    if(time>0.5)
    {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:time-0.5];
    }else
    {
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:time];
    }
    
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        self.textLabel.text = @"";
        [self removeFromSuperview];
        self.alpha = 1.0;
    }];
}

+ (void)showText:(NSString *)text
{
    ZFTipsView *baseView = [ZFTipsView shareView];
    if(baseView &&[baseView superview])
    {
        [baseView removeFromSuperview];
    }
    baseView.textLabel.text = text;
    
    CGRect rect = CGRectZero;
    
    CGFloat maxWidth = ScreenWidth -20*2;
    
    CGSize size = [text sizeWithFont:baseView.textLabel.font constrainedToSize:CGSizeMake(maxWidth, NSIntegerMax) lineBreakMode:NSLineBreakByWordWrapping];
    if(size.height>[baseView.textLabel.font lineHeight])
    {
        rect =CGRectMake(20, (ScreenHeight -size.width)/2, size.width, size.height);
    }else
    {
        rect = CGRectMake((ScreenWidth -size.width)/2, (ScreenHeight-size.height)/2, size.width, size.height);
    }
    baseView.frame =rect;
    baseView.backView.frame = baseView.bounds;
    baseView.textLabel.frame = baseView.bounds;
    [baseView showInView:nil];
    
    
}

+ (void)showText:(NSString *)text withOriginY:(CGFloat)y{
    ZFTipsView *baseView = [ZFTipsView shareView];
    if(baseView&&[baseView superview])
    {
        [baseView removeFromSuperview];
    }
    baseView.textLabel.text = text;
    CGRect rect = CGRectZero;
    CGFloat maxWidth = ScreenWidth-20*2;
    CGSize size = [text sizeWithFont:baseView.textLabel.font constrainedToSize:CGSizeMake(maxWidth, NSIntegerMax) lineBreakMode:NSLineBreakByCharWrapping];
    if(size.height>[baseView.textLabel.font lineHeight])
    {
        rect = CGRectMake(20, y, size.width, size.height);
    }else
    {
        rect = CGRectMake((ScreenWidth-size.width)/2, y, size.width, size.height);
    }
    baseView.frame = rect;
    baseView.backView.frame = baseView.bounds;
    baseView.textLabel.frame = baseView.bounds;
    [baseView showInView:nil];
    
    
}

+ (void)showText:(NSString *)text inView:(UIView *)superView withOriginY:(CGFloat)y
{
    ZFTipsView *baseView = [ZFTipsView shareView];
    if(baseView &&[baseView superview])
    {
        [baseView removeFromSuperview];
    }
    baseView.textLabel.text = text;
    
    CGRect rect = CGRectZero;
    CGFloat maxWidth = superView.bounds.size.width-20*2;
    CGSize size = [text sizeWithFont:baseView.textLabel.font constrainedToSize:CGSizeMake(maxWidth, NSIntegerMax) lineBreakMode:NSLineBreakByCharWrapping];
    if(size.height>[baseView.textLabel.font lineHeight])
    {
        rect = CGRectMake(20, y, size.width, size.height);
    }else
    {
        rect = CGRectMake((superView.bounds.size.width-size.width)/2, y, size.width, size.height);
    }
    baseView.frame = rect;
    baseView.backView.frame = baseView.bounds;
    baseView.textLabel.frame = baseView.bounds;
    [baseView showInView:superView];
    
}



@end
