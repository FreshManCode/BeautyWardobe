//
//  ZFHeaders.h
//  PaySDKDemo
//
//  Created by ZhangJunjun on 16/4/22.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFHeaders : NSObject

#define ZF_LOG(fmt, ...) (XY_DEBUG_LOG ? NSLog((@"\n" fmt), ##__VA_ARGS__) : nil)


#ifdef DEBUG
#define ZFDEBUGLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ZFDEBUGLOG(...)
#endif

#define ZF_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ZF_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define ZF_IS_IOS8_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)

#define ZF_IS_IOS7_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)

#define ZF_IS_IOS6_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)

#define ZFScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ZFScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ZFMainScale [UIScreen mainScreen].scale
#define ZF_IS_RETINA ([[UIScreen mainScreen] scale] == 2.0f)


#define ZF_IS_IPHONE5 (ZF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define ZF_IS_IPHONE6 (ZF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define ZF_IS_IPHONE6PLUS (ZF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736)
#define ZF_IS_IPHONE4OR5 (ZF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.width == 320)
#define ZF_IS_IPHONE4 (ZF_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)



#define ZFRGBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define ZFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define ZFHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
// 2.获得RGB颜色
#define JZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define JZTabbarButtonRatio 0.6
#define ZFFont(a) [UIFont systemFontOfSize:a]


// 按钮的默认文字颜色
#define  JZTabbarButtonTitleColor (iOS7 ? [UIColor blackColor] : [UIColor blackColor])
// 按钮的选中文字颜色
#define  JZTabbarButtonTitleSelectedColor (iOS7 ? JZColor(234, 103, 7) : JZColor(255, 69, 125))

#define  kUserIsLogin @"UserIsHaveTheAccessTokenByLogin"
#define  kUserName @"UserLoginSuccesGetName"
#define  kUserHeadImageURL @"UserLoginSuccessGetHeagImageURL"

#define  kUserLookReward @"UserLookRewarsDetailInfomation"
#define  kNextCursor  @"LoadMoreContentIdentifier"
#define  kChangeDefaultAddress @"UserChangeDefaultAddress"
#define  kUserWalletMoney @"NotificationUserWalletTotalMoney"
#define  kUserHeadImage @"UserCurrentHeadImage"





@end
