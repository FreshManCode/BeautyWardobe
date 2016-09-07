//
//  ZFNoAddressView.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/25.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFNoAddressViewDelegate <NSObject>

@optional
- (void)didClickAddAddressButton;

@end


@interface ZFNoAddressView : UIScrollView
@property (nonatomic,assign) id <ZFNoAddressViewDelegate> btnDelegate;

@end
