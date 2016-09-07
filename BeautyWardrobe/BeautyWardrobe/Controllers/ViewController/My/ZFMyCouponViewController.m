//
//  ZFMyCouponViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyCouponViewController.h"
#import "ZFMyCouponModel.h"
#import "NetwokeManager.h"
#import <MJRefresh.h>
#import "ZFUserDefaults.h"
#import "ZFMyCouponCell.h"
#import "ZFExplanationViewController.h"
@interface ZFMyCouponViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_contentArray;
}
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZFMyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];

}

- (void)setUpSubViews {
    self.titleLabel.text = @"我的优惠券";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundColor:[UIColor clearColor]];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"如何使用" forState:UIControlStateNormal];
    self.rightButton.frame = CGRectMake(ZFScreenWidth-74, 25, 64, 24);
    [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.rightButton addTarget:self action:@selector(howToUseCoupon:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    [self.view addSubview:_tableView];
    
    __weak typeof (self) weakSelf = self;
    _tableView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadContentRequest];
    }];
    [_tableView.mj_header beginRefreshing];
    

}

- (void)howToUseCoupon:(UIButton *)sender {
    ZFExplanationViewController *explainVC = [[ZFExplanationViewController alloc]init];
    explainVC.hidesBottomBarWhenPushed = YES;
    explainVC.titleName = @"使用说明";
    [self.navigationController pushViewController:explainVC animated:YES];
}

- (void)loadContentRequest {
    _contentArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/coupon/list.php?";
    NSString *rightPart = [NSString stringWithFormat:@"count=40&cursor=0&mid=457465&object_type=9&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        [_tableView.mj_header endRefreshing];
        if ([data[@"ret"] integerValue]==0) {
            [self hanleWithResultJson:data[@"data"]];
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"获取优惠券出错,请稍后重试" withTime:1.0f];
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络的不好呢" withTime:2.0f];
    }];

}

- (void)hanleWithResultJson:(NSDictionary *)dic {
    for(NSDictionary *tempDic in dic[@"coupons"]){
        ZFMyCouponModel *model = [[ZFMyCouponModel alloc]initWithDicionary:tempDic];
        [_contentArray addObject:model];
    }
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _contentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFMyCouponCell *couponCell = [ZFMyCouponCell cellWithTableView:tableView];
    ZFMyCouponModel *couponModel = _contentArray[indexPath.section];
    couponCell.couponModel = couponModel;
    return couponCell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
