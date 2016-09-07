//
//  ZFMainTabbarController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMainTabbarController.h"
#import "ZFHomeViewController.h"
#import "ZFCategoryViewController.h"
#import "ZFShoppingViewController.h"
#import "ZFMyViewController.h"

#import "ZFTabbar.h"

@interface ZFMainTabbarController ()<UITabBarControllerDelegate,ZFTabbarDelegate>
@property (nonatomic,strong) ZFTabbar *customTabBar;

@end

@implementation ZFMainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}


- (void)initViewControllers {
    ZFHomeViewController *homeVC = [[ZFHomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    homeNav.tabBarItem.image = [[UIImage imageNamed:@"TabbarHomeNormal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabbarHomeSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    ZFCategoryViewController *categoryVC = [[ZFCategoryViewController alloc]init];
    UINavigationController *cateNav = [[UINavigationController alloc]initWithRootViewController:categoryVC];
    categoryVC.tabBarItem.image = [[UIImage imageNamed:@"TabbarCategoryNormal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    categoryVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabbarCategorySelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cateNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);

    
    ZFShoppingViewController *shopVC = [[ZFShoppingViewController alloc]init];
    UINavigationController *shopNav = [[UINavigationController alloc]initWithRootViewController:shopVC];
    shopNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    shopNav.tabBarItem.image = [[UIImage imageNamed:@"TabbarShopingNormal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shopNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabbarShopingSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ZFMyViewController *myVC = [[ZFMyViewController alloc]init];
    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myVC];
    myNav.tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    myNav.tabBarItem.image = [[UIImage imageNamed:@"TabbarMyNormal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabbarMySelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSArray *viewControllers = @[homeNav,cateNav,shopNav,myNav];
    _tabbarController.delegate = self;
    [self setViewControllers:viewControllers animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
