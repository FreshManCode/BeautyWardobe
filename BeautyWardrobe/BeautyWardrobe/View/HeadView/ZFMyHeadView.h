//
//  ZFMyHeadView.h
//  
//
//  Created by ZhangJunjun on 16/5/6.
//
//

#import <UIKit/UIKit.h>

@protocol ZFMyHeadViewDelegate <NSObject>

@optional
- (void)loginEvent;
- (void)didClickUserImage;

@end


@interface ZFMyHeadView : UIScrollView
@property (nonatomic,assign) id<ZFMyHeadViewDelegate>headDelegate;

@end
