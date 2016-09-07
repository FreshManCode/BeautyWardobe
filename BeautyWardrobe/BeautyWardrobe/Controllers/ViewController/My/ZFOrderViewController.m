//
//  ZFOrderViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/24.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFOrderViewController.h"
#import "ZFOrderViewController.h"
#import "NetwokeManager.h"
#import <MJRefresh.h>
#import "ZFNoOederView.h"
#import "ZFUserDefaults.h"

@interface ZFOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIButton       *_lastSelectedBtn;
    NSMutableArray *_contetntArray;
    NSString       *_currentStatus;
}
@property (nonatomic,strong) UIView *stateView;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ZFNoOederView *noOrderView;



@end

@implementation ZFOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    
}

- (void)setUpSubViews {
    _contetntArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.titleLabel.text = _titleName;
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    
    if (!_stateView) {
        _stateView = [[UIView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, 40)];
    }
    [self.view addSubview:_stateView];
    
    NSArray *stateArray = [NSArray arrayWithObjects:@"待付款",@"待发货",@"待收货",@"已收货",@"退款中", nil];
    CGFloat btnWidth  = 55;
    CGFloat btnHeight = 38;
    CGFloat offSetY   = (ZFScreenWidth -5*btnWidth)/6.0;
    for(int i=0;i<stateArray.count;i++){
        UIButton *stateBtn = [[UIButton alloc]initWithFrame:CGRectMake((btnWidth +offSetY)*i+offSetY, 0, btnWidth, btnHeight)];
        [stateBtn setTitle:stateArray[i] forState:UIControlStateNormal];
        [stateBtn setTitleColor:ZFRGBColor(100, 100, 100) forState:UIControlStateNormal];
        [stateBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        stateBtn.titleLabel.font = ZFFont(15.0f);
        stateBtn.tag = 100+i;
        [stateBtn addTarget:self action:@selector(stateChangeEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_stateView addSubview:stateBtn];
        if (stateBtn.tag==100) {
            [stateBtn setSelected:YES];
            _lastSelectedBtn = stateBtn;
        }
    }
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, _stateView.height-2.5, (btnWidth+offSetY), 2.5)];
        _lineView.backgroundColor = ZFRGBColor(219, 81, 128);
    }
    [_stateView addSubview:_lineView];
    
    if ([_keyAccess length]>0) {
        [_stateView removeFromSuperview];
        _stateView = nil;
    }
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [self.view addSubview:_tableView];
    __weak typeof (&*self) weakSelf = self;
    _currentStatus       = _m_status;
    _tableView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadRefreshRequest];
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
    [_tableView.mj_header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contetntArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"orderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"测试数据别当真";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[ZFNoOederView class]]) {
        _currentStatus = [NSString stringWithFormat:@"%d",(int)_lastSelectedBtn.tag-100];
        [self loadRefreshRequest];
        return;
    }
}


- (void)loadRefreshRequest {
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/order/list.php?";
    NSString *leftPart  = [NSString stringWithFormat:@"%@%@",@"count=40&cursor=0&m_status=",_currentStatus];
    NSString *rightPart = [NSString stringWithFormat:@"&mid=457465&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@%@",baseURL,leftPart,rightPart];
    __weak typeof (&*self) weakSelf = self;
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if ([weakSelf.tableView.mj_header respondsToSelector:@selector(endRefreshing)]) {
            [weakSelf.tableView.mj_header endRefreshing];
        }
        if ([data[@"ret"] integerValue]==0) {
            if (![data[@"data"][@"list"]  isKindOfClass:[NSNull class]]) {
                 [self handleWithResult:data[@"data"]];
            }else{
                //加载没有订单
                [self loadNoOrderContent];
            }
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"访问出错了" withTime:1.0f];
        }
    } failure:^(NSError *error) {
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"请检查网络" withTime:1.0f];
    }];
}

- (void)loadNoOrderContent {
    if (!_noOrderView) {
        _noOrderView = [[ZFNoOederView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, _tableView.height)];
        _noOrderView.delegate = self;
        _noOrderView.contentSize = CGSizeMake(ZFScreenWidth, ZFScreenHeight);
    }
    [_tableView addSubview:_noOrderView];
    [_tableView bringSubviewToFront:_noOrderView];
}


- (void)handleWithResult:(NSDictionary *)dic {
    [_tableView reloadData];
}

- (void)stateChangeEvent:(UIButton *)sender {
    if (_lastSelectedBtn !=sender) {
        _lastSelectedBtn.selected = NO;
        _lastSelectedBtn = sender;
        [_lastSelectedBtn setSelected:YES];
        [_tableView.mj_header beginRefreshing];
        _currentStatus = [NSString stringWithFormat:@"%d",(int)sender.tag-100];
        [self loadRefreshRequest];
        CGFloat offSetY   = (ZFScreenWidth -5*55)/6.0;
        __block CGRect  frame;
        [UIView animateWithDuration:0.5 animations:^{
            frame             = _lineView.frame;
            CGFloat x         = (sender.tag-100)*(55+offSetY) +offSetY;
            frame.origin.x    = x;
        } completion:^(BOOL finished) {
            _lineView.frame   = frame;
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
