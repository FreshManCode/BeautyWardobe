//
//  AppDelegate.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "AppDelegate.h"
#import <RealReachability.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台,qq和空间
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK
#import "WeiboSDK.h"

#import "ZFUserDefaults.h"

#import <KSCrash/KSCrashInstallationStandard.h>
#import <MobClick.h>
//5669444ae0f55a4f050027b0 友盟appkey

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[ZFPaintingWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self initCrashLog];
    [self initUMTrack];
    [[ZFUserDefaults shareInstance]removeObjectWithKey:ZFUserSID];
    
    self.tabbarController = [[ZFMainTabbarController alloc]init];
    self.window.rootViewController = self.tabbarController;
    
    [self.window makeKeyAndVisible];
    [self initShreSDKPlatfrom];
    return YES;
}

- (void)initCrashLog {
    KSCrashInstallationStandard *installation = [KSCrashInstallationStandard sharedInstance];
    installation.url = [NSURL URLWithString:@"https://collector.bughd.com/kscrash?key=42e56f8397a73299ea2ec188a1dc4d3b"];
    [installation install];
    [installation sendAllReportsWithCompletion:nil];
    
}

- (void)initUMTrack {
    [MobClick startWithAppkey:@"5669444ae0f55a4f050027b0"];
}


- (void)initShreSDKPlatfrom{
    [ShareSDK registerApp:@"cf72250337ac" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                                            @(SSDKPlatformTypeWechat),
                                                            @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
                                                                switch (platformType) {
                                                                    case SSDKPlatformTypeWechat:
                                                                        [ShareSDKConnector connectWeChat:[WXApi class]];
                                                                        break;
                                                                    case SSDKPlatformTypeQQ:
                                                                        [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                                        break;
                                                                    case SSDKPlatformTypeSinaWeibo:
                                                                        [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                                        break;
                                                                    default:
                                                                        break;
                                                                }
                                                            } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                                                switch (platformType) {
                                                                    case SSDKPlatformTypeSinaWeibo:
                                                                        [appInfo SSDKSetupSinaWeiboByAppKey:@"605418834" appSecret:@"9e19190b2ff11544c32b466249b65b17" redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
                                                                        break;
                                                                    case SSDKPlatformTypeWechat:
                                                                        [appInfo SSDKSetupWeChatByAppId:@"wxb819c9172c921e00" appSecret:@"8e1ea5789e19286f8b70dc8570db1851"];
                                                                        break;
                                                                    case SSDKPlatformTypeQQ:
                                                                        [appInfo SSDKSetupQQByAppId:@"1105392938" appKey:@"fhUBNGeeMO3BoMRd" authType:SSDKAuthTypeBoth];
                                                                        break;
                                                                        
                                                                    default:
                                                                        break;
                                                                }
                                                            }];
}




- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
