//
//  ZFMyWalletViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyWalletViewController.h"
#import "ZFMyWalletCell.h"
#import "NetwokeManager.h"
#import "ZFUserDefaults.h"
#import <MJRefresh.h>
#import "ZFMyCouponModel.h"
#import "ZFExplanationViewController.h"
@interface ZFMyWalletViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_titleArray;
    NSMutableArray *_iconArray;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ZFMyWalletModel *walletModel;

@end

@implementation ZFMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    self.titleLabel.text = @"我的钱包";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [self.rightButton setTitle:@"说明" forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = ZFFont(15.0f);
    [self.rightButton addTarget:self action:@selector(introduceEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    __weak typeof (self) weakSelf = self;
    _tableView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadRequest];
    }];
    [self.view addSubview:_tableView];
    [_tableView.mj_header beginRefreshing];
    _titleArray = [[NSMutableArray alloc] initWithObjects:@"钱包总额",@"可用余额",@"钱包明细",@"提现" ,@"绑定手机",@"设置钱包密码",nil];
    _iconArray = [[NSMutableArray alloc]initWithObjects:@"wallet_detail",@"wallet_withdraw",@"wallet_bind_phone",@"wallet_changepwd", nil];
}

- (void)loadRequest {
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/wallet/detail.php?";
    NSString *rightPart = [NSString stringWithFormat:@"mid=457465&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        [_tableView.mj_header endRefreshing];
        if ([data[@"ret"] integerValue]==0) {
            [self hanleWithResult:data[@"data"]];
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"获取优惠券出错,请稍后重试" withTime:1.0f];
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络的不好呢" withTime:2.0f];
    }];
}
- (void)hanleWithResult:(NSDictionary *)dic {
    _tableView.backgroundColor = ZFRGBColor(232, 232, 232);
    _walletModel = [ZFMyWalletModel modelWithDictionary:dic];
    [[NSNotificationCenter defaultCenter]postNotificationName:kUserWalletMoney object:_walletModel.available_balance];
    [_tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 40;
    }else{
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFMyWalletCell *cell = [ZFMyWalletCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        cell.titleLab.text = _titleArray[indexPath.row];
        if (indexPath.row==0) {
            cell.cellType = ZFMyWalletCellTypeText;
            if ([_walletModel.balance length]>0) {
                cell.rightPriceLab.text = [NSString stringWithFormat:@"%@%@",
                _walletModel.money_symbol,_walletModel.balance];
            }
        }else {
            cell.cellType = ZFMyWalletCellTypeTwoText;
            if ([_walletModel.available_balance length]>0) {
                cell.rightTitleLab.text = @"提现中的余额";
                cell.leftPriceLab.text  = [_walletModel.money_symbol
                stringByAppendingString:_walletModel.available_balance];
                cell.rightPriceLab.text = [_walletModel.money_symbol
                stringByAppendingString:_walletModel.withdrawing_balance];
            }
        }
    }else {
        cell.cellType = ZFMyWalletCellTypeHybrideTextImage;
         if ([_walletModel.balance length]>0) {
             cell.titleLab.text = _titleArray[indexPath.row+2];
             cell.leftIcon.image = [UIImage imageNamed:_iconArray[indexPath.row]];
            if (indexPath.row<2) {
                [cell.pointLayer setHidden:YES];
            } if (indexPath.row==3) {
                [cell.sepratorLayer setHidden:YES];
            }
        }
    }
    return cell;
}




- (void)introduceEvent:(UIButton *)sender {
    ZFExplanationViewController *explacationVC = [[ZFExplanationViewController alloc]init];
    explacationVC.titleName = @"钱包说明";
    explacationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:explacationVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
