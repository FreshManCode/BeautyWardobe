//
//  ZCategorySearchVC.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/11.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZCategorySearchVC.h"

@interface ZCategorySearchVC ()
<
UISearchBarDelegate
>

@property (nonatomic, strong)UISearchBar *searchBar;

@end

@implementation ZCategorySearchVC

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        CGRect frame = CGRectMake(10, 10, ZFScreenWidth - 10*2, 35);
        _searchBar = [[UISearchBar alloc] initWithFrame:frame];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索你喜欢的宝贝";
        [_searchBar setImage:[UIImage imageNamed:@"搜索按钮"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [_searchBar becomeFirstResponder];
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.searchBar;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
            [btn setTitleColor:ZFRGBColor(255, 69, 125) forState:UIControlStateNormal];
        }
    }
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)IndexSearchBar
{
    NSLog(@"search button");
}


@end
