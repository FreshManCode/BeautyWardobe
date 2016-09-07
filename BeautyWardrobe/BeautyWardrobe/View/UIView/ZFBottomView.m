//
//  ZFBottomView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/20.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBottomView.h"
#import "ZFGoodsDetailTextCell.h"
@interface ZFBottomView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *infoArray;

@end

@implementation ZFBottomView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _infoArray = [[NSMutableArray alloc] initWithObjects:@"如何联系",@"美丽衣橱",@"在美丽衣橱",@"我如何付款",@"付款后多久发货",@"运费需要多少钱",@"商品的尺码标准",@"商品有色差",@"我想要的商品缺货",@"商品收到后",@"我收到货了",@"什么情况下",@"退款成功后", nil];
        if (!_bottomTable) {
            _bottomTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, ZFScreenHeight) style:UITableViewStylePlain];
            _bottomTable.delegate    = self;
            _bottomTable.dataSource  = self;
        }
        [self addSubview:_bottomTable];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFGoodsDetailTextCell *cell = [ZFGoodsDetailTextCell cellWithTableView:tableView];
    cell.titleLab.text = _infoArray[indexPath.row];
    return cell;
}


@end
