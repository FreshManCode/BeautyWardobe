//
//  ZFTabbar.m
//  CustomTabbar
//
//  Created by ZhangJunjun on 16/4/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFTabbar.h"
#import "ZFTabbarButton.h"

@interface ZFTabbar ()
@property (nonatomic,strong) ZFTabbarButton *selectedTabbar;
@property (nonatomic,strong) NSMutableArray *buttonArr;
@end

@implementation ZFTabbar

- (NSMutableArray *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _buttonArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置view的背景色为图片颜色
        self.backgroundColor = ZFRGBColor(245, 245, 245);
    }
    return self;
}

- (void)addTabBarWithItem:(UITabBarItem *)item {
    //创建按钮
    ZFTabbarButton *button = [[ZFTabbarButton alloc]init];
    [self addSubview:button];
    //添加到数组
    [self.buttonArr addObject:button];
    //设置数据
    button.item = item;
    
    //监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    //默认选中低0个按钮
    if (self.subviews.count==1) {
        [self buttonClick:button];
    }
}

//设置子控件布局
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/self.subviews.count;
    CGFloat buttonH = self.frame.size.height;
    for (int i =0;i<self.subviews.count;i++) {
        //取出按钮
        ZFTabbarButton *butotn = self.subviews[i];
        //设置按钮的frame
        CGFloat buttonX = i *buttonW;
        butotn.frame    = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //绑定tag值
        butotn.tag =    i;
    }
}


//按钮的点击事件
- (void)buttonClick:(ZFTabbarButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(tabBar:didSelectedButtonFromOne:toCurrentOne:)]) {
        [_delegate tabBar:self didSelectedButtonFromOne:self.selectedTabbar.tag toCurrentOne:sender.tag];
    }
    self.selectedTabbar.selected = NO;
    //选中
    sender.selected = YES;
    //赋值
    self.selectedTabbar = sender;
}



@end
