//
//  ZFMyItemViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyItemViewController.h"
#import "ZFMyItemCell.h"
#import "NetwokeManager.h"
#import "ZFHeadADsProductModel.h"
#import <MJRefresh.h>
#import "ZFUserDefaults.h"
#import "ZFGoogsDetailViewController.h"

@interface ZFMyItemViewController ()<UITableViewDelegate,UITableViewDataSource,ZFMyItemCellDelegate>
{
    NSMutableArray *_contetntArray;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZFMyItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];

}

- (void)setUpSubViews {
    self.titleLabel.text = @"我的宝贝";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 190;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];
    __weak typeof (self) weakSelf = self;
    _tableView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refreshContent];
    }];
    [_tableView.mj_header beginRefreshing];
    [_tableView reloadData];
    
}

- (void)refreshContent {
    [_contetntArray removeAllObjects];
    [self netWorkRequest];

}

- (void)netWorkRequest {
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/user/user_have.php?";
    NSString *rightPart = [NSString stringWithFormat:@"count=40&cursor=0&mid=457465&sid=%@&type=product&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        [_tableView.mj_header endRefreshing];
        if ([data[@"ret"] integerValue]==0 &&data[@"data"]) {
            [self hanleWithResult:data[@"data"][@"products"]];
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"参数有问题" withTime:1.5f];
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲您的网络有问题哈" withTime:1.5f];
    }];

}


- (void)hanleWithResult:(NSArray *)array {
    _contetntArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSDictionary *dic in array){
         ZFMyItemModel *model = [[ZFMyItemModel alloc]initWithDictionary:dic];
        [_contetntArray addObject:model];
    }
    [_tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contetntArray.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <_contetntArray.count) {
        ZFMyItemCell *cell = [ZFMyItemCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.topLab.text = [NSString stringWithFormat:@"亲,你已经收藏了%lu件宝贝",_contetntArray.count];
        }else{
            [cell.topLab setHidden:YES];
        }
        ZFMyItemModel *model = _contetntArray[indexPath.row];
        cell.itemModel = model;
        return cell;
    }else {
        static NSString *identifier = @"NoMoreContentCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = @"已加载全部";
        cell.textLabel.font = ZFFont(12.0f);
        cell.textLabel.textColor = ZFRGBColor(100, 100, 100);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <_contetntArray.count) {
        return 190;
    }else{
        return 20;
    }
}

//删除按钮
- (void)didClickDeleteBtnWithModel:(ZFMyItemModel *)itemModel {
    
}

//点击图片查看详情
- (void)didClickLeftPicImageWithModel:(ZFMyItemModel *)itemModel {
    ZFGoogsDetailViewController *detailVC = [[ZFGoogsDetailViewController alloc]init];
    detailVC.itemModel = itemModel;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
