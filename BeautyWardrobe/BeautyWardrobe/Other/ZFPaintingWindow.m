//
//  ZFPaintingWindow.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFPaintingWindow.h"

@implementation ZFPaintingWindow

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
   
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion ==UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shake" object:self];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
}




@end
