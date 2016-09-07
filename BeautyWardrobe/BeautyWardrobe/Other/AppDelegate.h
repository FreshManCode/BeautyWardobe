//
//  AppDelegate.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFMainTabbarController.h"
#import "ZFPaintingWindow.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) ZFPaintingWindow *window;
@property (nonatomic,strong)  ZFMainTabbarController *tabbarController;



@end

