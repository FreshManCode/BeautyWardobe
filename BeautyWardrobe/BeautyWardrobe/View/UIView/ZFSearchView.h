//
//  ZFSearchView.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZFSearchViewDelegate <NSObject>

@optional
- (void)didCancelSearchEvent;

@end

@interface ZFSearchView : UIView
@property (nonatomic,strong) UITextField *inputTf;
@property (nonatomic,strong) UIButton    *cancelBtn;
@property (nonatomic,assign) id <ZFSearchViewDelegate> delegate;

@end
