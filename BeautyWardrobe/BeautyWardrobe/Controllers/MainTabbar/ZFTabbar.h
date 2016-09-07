//
//  ZFTabbar.h
//  CustomTabbar
//
//  Created by ZhangJunjun on 16/4/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFTabbar;

@protocol ZFTabbarDelegate <NSObject>
@optional

- (void)tabBar:(ZFTabbar *)tabBar didSelectedButtonFromOne:(NSInteger )lastOne toCurrentOne:(NSInteger)currentOne;
@end


@interface ZFTabbar : UIView
- (void)addTabBarWithItem:(UITabBarItem *)item;
@property (nonatomic,weak) id<ZFTabbarDelegate>delegate;

@end
