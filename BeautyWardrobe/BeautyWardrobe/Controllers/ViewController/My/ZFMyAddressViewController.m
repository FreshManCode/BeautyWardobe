//
//  ZFMyAddressViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/25.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyAddressViewController.h"
#import "NetwokeManager.h"
#import <MJRefresh.h>
#import "ZFUserDefaults.h"
#import "ZFNoAddressView.h"
#import "ZFAddAddressViewController.h"
#import "ZFAddressCell.h"
#import "ZFMyAddressModel.h"
@interface ZFMyAddressViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZFNoAddressViewDelegate,ZFAddressCellDelegate>
{
    NSMutableArray *_contentArray;
}
@property (nonatomic,strong) ZFNoAddressView *noAddressView;
@property (nonatomic,strong) UITableView  *tableView;


@end

@implementation ZFMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}


- (void)setUpSubViews {
    self.titleLabel.text = @"我的收获地址";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"button_tittleBarAdd"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(addAddressEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, [self getStartOriginY]+15, ZFScreenWidth-20, ZFScreenHeight-[self getStartOriginY]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView reloadData];
    __weak typeof (self) weakSelf = self;
    _tableView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadRefreshData];
        [_contentArray removeAllObjects];
    }];
}

- (void)loadRefreshData {
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/address/list.php?";
    NSString *rightPart = [NSString stringWithFormat:@"&mid=457465&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if ([data[@"ret"] integerValue]==0) {
            [self endRefreshActivator];
            if ([data[@"data"] count]>0) {
                [self handleWithResult:data[@"data"]];
            }else{
                //显示没有收获地址
                [self setUpNoAddressView];
            }
        }
    } failure:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲您的网络不好呢" withTime:1.5f];
    }];

}

- (void)handleWithResult:(NSArray *)array {
    _contentArray = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSDictionary *dic in array){
        ZFMyAddressModel *model = [[ZFMyAddressModel alloc] initWithDictionary:dic];
        [_contentArray addObject:model];
    }
    [_tableView reloadData];
}

- (void)endRefreshActivator {
    if ([_tableView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_tableView.mj_header endRefreshing];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[ZFNoAddressView class]]) {
        [self loadRefreshData];
        return;
    }
}

- (void)setUpNoAddressView {
    if (!_noAddressView) {
        _noAddressView = [[ZFNoAddressView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, ZFScreenHeight-[self getStartOriginY])];
        _noAddressView.delegate    = self;
        _noAddressView.btnDelegate = self;
        _noAddressView.bounces = YES;
        _noAddressView.contentSize = CGSizeMake(ZFScreenWidth, ZFScreenHeight);
    }
    [_tableView addSubview:_noAddressView];
    [_tableView bringSubviewToFront:_noAddressView];
}

- (void)didClickAddAddressButton {
    [self addAddressEvent:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}


- (void)addAddressEvent:(UIButton *)sender {
    ZFAddAddressViewController *addressVC = [[ZFAddAddressViewController alloc]init];
    addressVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addressVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _contentArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFAddressCell *cell = [ZFAddressCell cellWithTableView:tableView];
    if (_contentArray.count >0) {
        cell.addreddModel   =(ZFMyAddressModel *) _contentArray[indexPath.section];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didClickButtonTag:(NSInteger)tagIndex addressModel:(ZFMyAddressModel *)model selectedBtn:(ZFAddressButton *)staticBtn {
    switch (tagIndex) {
        case 10:{
            //设置为默认环境
            NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
            NSString *addressID = model.idNum;
            NSString *baseURL   = @"http://vapi.yuike.com/1.0/address/set_default.php?";
            NSString *rightPart = [NSString stringWithFormat:@"address_id=%@&mid=457465&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",addressID, sessionID];
            NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
            [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
                if ([data[@"ret"] integerValue]==0) {
                    [[NetwokeManager shareInstance]updateWindowsWithTitle:@"默认地址设置成功" withTime:1.0f];
                    [self loadRefreshData];
                }else {
                    [[NetwokeManager shareInstance]updateWindowsWithTitle:@"默认地址设置失败,请稍后重试" withTime:1.0f];
                }
            } failure:^(NSError *error) {
                [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络不好啊" withTime:1.5f];
            }];
             break;
        }
        case 11:{
            //编辑
            ZFAddAddressViewController *address = [[ZFAddAddressViewController alloc]init];
            address.hidesBottomBarWhenPushed = YES;
            address.manName = model.name;
            address.phoneNum = model.phone;
            address.address = [[model.province stringByAppendingString:model.city]stringByAppendingString:model.area];
            address.detail = model.address;
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        case 12:{
            //删除
            NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
            NSString *addressID = model.idNum;
            NSString *baseURL   = @"http://vapi.yuike.com/1.0/address/remove.php?";
            NSString *rightPart = [NSString stringWithFormat:@"address_id=%@&mid=457465&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",addressID, sessionID];
            NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
            [[NetwokeManager shareInstance]hudShowLoadingMessage:@"删除中,请稍后"];
            [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
                [[NetwokeManager shareInstance]hudHiddenImmediately];
                if ([data[@"ret"] integerValue]==0) {
                    [_contentArray removeObject:model];
                    [_tableView reloadData];
                }else{
                   [[NetwokeManager shareInstance]updateWindowsWithTitle:@"删除地址失败,请稍后重试" withTime:1.5f];
                }
            } failure:^(NSError *error) {
                [[NetwokeManager shareInstance]hudHiddenImmediately];
                [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络不好啊" withTime:1.5f];
            }];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadRefreshData];
    self.view.backgroundColor = ZFRGBColor(242, 242, 242);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
