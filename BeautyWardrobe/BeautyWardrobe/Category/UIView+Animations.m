//
//  UIView+Animations.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "UIView+Animations.h"

@implementation UIView (Animations)

//向上添加下载车效果
- (void)opacityFrameAnimation:(UIView *)fromView toTopPoint:(CGPoint)toPoint
{
    CALayer *appLayer = [CALayer layer];
    appLayer.contents = self.layer.contents;
    appLayer.masksToBounds = self.layer.masksToBounds;
    appLayer.cornerRadius = self.layer.cornerRadius;
    appLayer.borderColor = self.layer.borderColor;
    appLayer.borderWidth = self.layer.borderWidth;
    appLayer.bounds = self.bounds;
    appLayer.opacity = 1.0;
    appLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:self.frame fromView:fromView];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:appLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:appLayer.position];
    
    CGFloat yoff = appLayer.position.y + 100.0;
    [path addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x , yoff)];
    
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = path.CGPath;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.9;
    group.animations = [NSArray arrayWithObjects:positionAnimation,scaleAnim,opacityAnim,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.autoreverses= NO;
    [group setValue:appLayer forKey:@"ani"];
    group.delegate = self;
    [appLayer addAnimation:group forKey:@"opacity"];
    
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    appLayer.position = toPoint;
    appLayer.transform = [scaleAnim.toValue CATransform3DValue];
    [appLayer setValue:[NSNumber numberWithFloat:0.1] forKeyPath:@"opacity"];
    [CATransaction commit];
    
}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        id idlayer = [anim valueForKey:@"ani"];
        if ([idlayer isKindOfClass:[CALayer class]]) {
            CALayer *layer = (CALayer *) idlayer;
            layer.opacity = 0.0;
            [layer removeFromSuperlayer];
        }
    }
}

//下载效果
- (void)opacityFrameAnimation:(UIView *)fromView toPoint:(CGPoint)point{
    
    UIImageView *tempViews =[[UIImageView alloc] initWithFrame:fromView.frame];
    tempViews.layer.contents =tempViews.layer.contents;
    tempViews.bounds = fromView.bounds;
    tempViews.image=[self imageWithUIView:fromView];
    tempViews.layer.masksToBounds =YES;
    tempViews.layer.borderColor =[UIColor lightGrayColor].CGColor;
    tempViews.layer.borderWidth =1;
    tempViews.layer.cornerRadius =6;
    
    //加入购物车动画效果
    CALayer *transitionLayer = [[CALayer alloc] init];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    transitionLayer.opacity = 1.0;
    transitionLayer.contents = (id)tempViews.layer.contents;
    transitionLayer.frame = [[UIApplication sharedApplication].keyWindow convertRect:tempViews.bounds fromView:fromView];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:transitionLayer];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:transitionLayer.position];
    CGPoint toPoint = CGPointMake(point.x, point.y+80);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(point.x,transitionLayer.position.y-120)];
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    scaleAnim.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.9;
    group.animations = [NSArray arrayWithObjects:positionAnimation,scaleAnim,opacityAnim,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    
    [transitionLayer addAnimation:group forKey:@"opacity"];
    
    
}



- (UIImage*)imageWithUIView:(UIView*) view{
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *) createRoundedRectImage:(UIImage*)image size:(CGSize)size
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, 5, 5);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}


static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


@end
