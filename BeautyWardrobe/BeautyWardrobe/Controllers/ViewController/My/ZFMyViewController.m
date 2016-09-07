//
//  ZFMyViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyViewController.h"
#import "ZFMyHeadView.h"
#import "ZFMyViewCell.h"
#import "ZFLoginViewController.h"
#import "ZFMyAllOrderCell.h"
#import "ZFMyViewController.h"
#import "ZFSettingViewController.h"
#import "ZFOrderViewController.h"
#import "ZFLoginViewController.h"
#import "ZFMyAddressViewController.h"
#import "ZFMyCouponViewController.h"
#import "ZFMyWalletViewController.h"
#import "NetwokeManager.h"
#import "ZFSignInViewController.h"
#import "ZFMyItemViewController.h"
#import "ZFMyInfoViewController.h"
@interface ZFMyViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZFMyHeadViewDelegate,ZFMyAllOrderCellDelegate>
{
    NSMutableArray *_leftIconArray;
    NSMutableArray *_titleArray;
    NSString *_walletMonry;
}

@property (nonatomic,strong) ZFMyHeadView *headView;
@property (nonatomic,strong) UITableView  *myTableView;
@property (nonatomic,strong) UIScrollView *headImage;



@end

@implementation ZFMyViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeWalletMoeny:) name:kUserWalletMoney object:nil];
    [super viewDidLoad];
    [self initHeadView];
}

- (void)initHeadView {
    _leftIconArray = [[NSMutableArray alloc]initWithObjects:@"user_order",@"user_address",@"user_coupons",@"user_image_wallet",@"user_image_ykcoin",@"user_image_sign",@"user_product",@"user_brand",@"user_image_proxyhome",@"user_image_wx",@"user_score2",@"user_setting", nil];
    _titleArray = [[NSMutableArray alloc]initWithObjects:@"全部订单",@"我的收货地址",@"我的优惠券",@"我的钱包",@"我的美丽币",@"签到中心",@"我的宝贝",@"我的品牌",@"我要加盟",@"关注官方公众号",@"给美丽衣橱打5分",@"设置", nil];
    UIImage *image =  [UIImage imageNamed:@"userspace_top_bg.jpg"];
    if (!_headView) {
        _headView = [[ZFMyHeadView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 281/2.0)];
        _headView.headDelegate = self;
    }
    [self.view addSubview:_headView];
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, ZFScreenHeight-49) style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _myTableView.tableHeaderView = _headView;
        _myTableView.backgroundColor = ZFRGBColor(242, 242, 242);
        _myTableView.backgroundColor = [UIColor colorWithPatternImage:image];
    }
    [self.view addSubview:_myTableView];
}

- (void)loginEvent {
    ZFLoginViewController *loginVC = [[ZFLoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section==1){
        return 7;
    }else if (section==2){
        return 3;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ZFMyViewCell *cell = [ZFMyViewCell cellWithTableView:tableView];
            cell.titleLab.text = _titleArray[0];
            NSString *name = _leftIconArray[0];
            cell.leftIcon.image = [UIImage imageNamed:name];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            ZFMyAllOrderCell *cell = [ZFMyAllOrderCell cellWithTableView:tableView];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section==1){
        ZFMyViewCell *cell = [ZFMyViewCell cellWithTableView:tableView];
        if (indexPath.row==2) {
            if ([_walletMonry integerValue]==0) {
                cell.contetntLab.text = [NSString stringWithFormat:@"可用余额¥0"];
            }else{
                cell.contetntLab.text = [NSString stringWithFormat:@"可用余额¥%@",_walletMonry];
            }
        }
        cell.titleLab.text = _titleArray[indexPath.row+1];
        NSString *name = _leftIconArray[indexPath.row+1];
        cell.leftIcon.image = [UIImage imageNamed:name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section==2){
        ZFMyViewCell *cell = [ZFMyViewCell cellWithTableView:tableView];
        cell.titleLab.text = _titleArray[indexPath.row+8];
        NSString *name = _leftIconArray[indexPath.row+1];
        cell.leftIcon.image = [UIImage imageNamed:name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            cell.contetntLab.text = @"开始赚钱";
        }
        return cell;
    }else{
        ZFMyViewCell *cell = [ZFMyViewCell cellWithTableView:tableView];
        cell.titleLab.text = _titleArray[11];
        NSString *name = _leftIconArray[11];
        cell.leftIcon.image = [UIImage imageNamed:name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if ([ZFPublic userIsLogin]) {
                ZFOrderViewController *orderVC = [[ZFOrderViewController alloc]init];
                orderVC.titleName = @"我的订单";
                orderVC.m_status  = @"0";
                orderVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:orderVC animated:YES];
            }else{
                [self enterLoginViewController];
            }
        }
    }else if (indexPath.section==1){
        if (![ZFPublic userIsLogin]) {
            [self enterLoginViewController];
            return;
        }
        [self toFollowingViewControllerAccordingIndex:indexPath.row];
    }
    else if (indexPath.section==3) {
        ZFSettingViewController *setVC = [[ZFSettingViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }
}

- (void)toFollowingViewControllerAccordingIndex:(NSInteger)indexRow {
    switch (indexRow) {
        case 0:{
            //我的收货地址
            ZFMyAddressViewController *address = [[ZFMyAddressViewController alloc]init];
            address.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:address animated:YES];
        }
            break;
        case 1:{
            //我的优惠券
            ZFMyCouponViewController *couponVC = [[ZFMyCouponViewController alloc]init];
            couponVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:couponVC animated:YES];
        }
            break;
        case 2:{
            //我的钱包
            ZFMyWalletViewController *walletVC = [[ZFMyWalletViewController alloc]init];
            walletVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:walletVC animated:YES];
        }
             break;
        case 3:{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲,美丽币可在购物时抵扣现金,快去试试吧" withTime:2.0f];
            //我的美丽币
        }
            break;
        case 4:{
            //签到中心
            ZFSignInViewController *signVC = [[ZFSignInViewController alloc]init];
            signVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:signVC animated:YES];
        }
            break;
        case 5:{
            //我的宝贝
            ZFMyItemViewController *itemVC = [[ZFMyItemViewController alloc]init];
            itemVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:itemVC animated:YES];

        }
            break;
        case 6:
            //我的品牌
            break;
            
        default:
            break;
    }

}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 50;
        }else {
            return  ZFScreenWidth/5.0 -15+10;
        }
    }else {
        return 50;
    }
}


#pragma mark--------前往登录界面
- (void)enterLoginViewController {
    ZFLoginViewController *loginVC = [[ZFLoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}



#pragma mark-----------待付款,待发货,待收货,已收货,退款中...五个的点击事件
- (void)getCurrentTag:(NSInteger)clickTag {
    if ([ZFPublic userIsLogin]) {
        NSArray *array = [NSArray arrayWithObjects:@"待付款",@"待发货",@"待收货",@"已收货",@"退款中" ,nil];
        ZFOrderViewController *orderVC = [[ZFOrderViewController alloc]init];
        orderVC.titleName = array[clickTag-100];
        orderVC.m_status  = [NSString stringWithFormat:@"%lu",(clickTag-100)];
        orderVC.keyAccess = [NSString stringWithFormat:@"%d",(int)clickTag];
        orderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderVC animated:YES];
    }else{
        [self enterLoginViewController];
    }
}


- (void)changeWalletMoeny:(NSNotification *)noti {
    NSString *amount = (NSString *)noti.object;
    _walletMonry = amount;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didClickUserImage {
    ZFMyInfoViewController *myVC = [[ZFMyInfoViewController alloc]init];
    myVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
