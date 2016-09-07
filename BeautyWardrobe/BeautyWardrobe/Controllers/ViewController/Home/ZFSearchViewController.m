//
//  ZFSearchViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFSearchViewController.h"


@interface ZFSearchViewController ()<UITextFieldDelegate,UISearchBarDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UILabel     *backLab;

@end

@implementation ZFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, ZFScreenWidth-50, 44)];
        _searchBar.delegate = self;
        //输入框背景
        UIImage *img = [UIImage imageNamed:@"搜索框背景"];
        [self cutImage:img];
        [_searchBar setScopeBarBackgroundImage:img];
        _searchBar.searchResultsButtonSelected = YES;
//        [_searchBar setBackgroundImage:img];
        //左边的搜索按钮
        [_searchBar setImage:[UIImage imageNamed:@"搜索按钮"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        _searchBar.placeholder = @"搜索你喜欢的宝贝";
        _searchBar.layer.borderColor = ZFRGBColor(233, 231, 228).CGColor;
        _searchBar.layer.borderWidth = 5.0f;
     }
    [self.view addSubview:_searchBar];
    
    if (!_backLab) {
        _backLab = [[UILabel alloc]initWithFrame:CGRectMake(_searchBar.right+5, 20, 45, 44)];
        _backLab.textColor = [UIColor redColor];
        _backLab.textAlignment = NSTextAlignmentCenter;
        _backLab.text = @"取消";
        _backLab.userInteractionEnabled = YES;
    }
    [self.view addSubview:_backLab];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backToFront:)];
    [_backLab addGestureRecognizer:tapGesture];

    
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    CGSize newSize;
    CGImageRef imageRef = nil;
     if ((image.size.width / image.size.height) < (_searchBar.size.width / _searchBar.size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * _searchBar.size.height / _searchBar.size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * _searchBar.size.width / _searchBar.size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    return [UIImage imageWithCGImage:imageRef];
}

- (void)backToFront:(UITapGestureRecognizer *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}



////压缩图片
//- (UIImage *)image:(UIImage*)image scaledToSize:(CGSize)newSize
//{
//    // Create a graphics image context
//    UIGraphicsBeginImageContext(newSize);
//    // Tell the old image to draw in this new context, with the desired
//    // new size
//    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//    // Get the new image from the context
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    // End the context
//    UIGraphicsEndImageContext();
//    // Return the new image.
//    return newImage;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
