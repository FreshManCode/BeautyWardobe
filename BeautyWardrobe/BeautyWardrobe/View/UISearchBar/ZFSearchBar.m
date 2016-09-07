//
//  ZFSearchBar.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFSearchBar.h"

@implementation ZFSearchBar

- (void)layoutSubviews {
    [super layoutSubviews];
    NSUInteger numViews = [self.subviews count];
    for(int i= 0;i<numViews;i++){
        if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]){
            _searchField = [self.subviews objectAtIndex:i];
        }
    }
    if (_searchField) {
        _searchField.background = [UIImage imageNamed:@"搜索框背景"];
        [_searchField setBorderStyle:UITextBorderStyleRoundedRect];
        UIImageView *iView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索按钮"]];
        _searchField.leftView = iView;
    }
    
 
}



@end
