//
//  ZFHomeViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFHomeViewController.h"
#import "NetwokeManager.h"
#import "ZFLoginViewController.h"
#import "ZFBaseAdsView.h"
#import "ZFHeadADsModel.h"
#import "ZFHeadADsInfoViewController.h"
#import <MJRefresh.h>

#import "NetwokeManager.h"

#import "ZHHomeListModel.h"
#import "ZFBaseHeadADsCollectionViewCell.h"
#import "ZFRequestFailedView.h"
#import "ZFRequestNothingView.h"

#import "ZFLoginViewController.h"
#import "ZFUserDefaults.h"
#import "ZFBrandListViewController.h"
#import "ZFShakeInfoViewController.h"
#import "ZFSearchViewController.h"
#import "ZFGoogsDetailViewController.h"
#import "ZFBrandInfoViewController.h"
#import "ZFGoogsDetailViewController.h"
#import "ZFUserDefaults.h"
#import "ZFBindCoinViewController.h"

@interface ZFHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,ZFBaseAdsViewDelegate>
{
    //collectionView内容的model数组
    NSMutableArray *_productListArray;
    NSDictionary   *_tempDic;
    //当前页数
    NSInteger      _page;
    //没有内容
    ZFRequestNothingView *_nothingView;
    //网络连接失败
    ZFRequestFailedView  *_requestFailedView;
    
    
}


@property (nonatomic,strong) UITableView     *tableView;
@property (nonatomic,strong) NSMutableArray  *adsArray;
@property (nonatomic,strong) ZFBaseAdsView   *headView;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIButton         *toTopBtn;


@end

@implementation ZFHomeViewController

- (void)viewDidLoad {
    _page = 0;
    _productListArray = [[NSMutableArray alloc]initWithCapacity:0];
    [super viewDidLoad];
    [self initViews];
    [self performSelector:@selector(sendHomeProductListRequest) withObject:nil afterDelay:0.2];

}

- (void)initViews {
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (!_adsArray) {
        _adsArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    self.titleLabel.text = @"美丽衣橱";
    self.leftButton.frame = CGRectMake(5, 25, 65, 30);
    [self.leftButton setBackgroundColor:[UIColor whiteColor]];
    [self.leftButton setTitle:@"我要加盟" forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(wantToJoinUs:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.leftButton.layer.cornerRadius = 5.0f;
    
    self.rightButton .frame = CGRectMake(ZFScreenWidth-34, 25+5, 20, 20);
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundColor:[UIColor clearColor]];
    [self.rightButton addTarget:self action:@selector(searchEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat headViewHeight = 364/2.0 + ZFScreenWidth/4.0+32-25+ 215/2.0+ 180+35 +100+35 +387/2.0+35+45;
    if (!_headView) {
         _headView = [[ZFBaseAdsView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, headViewHeight) modelArray:_adsArray];
        _headView.backgroundColor = ZFRGBColor(242, 242, 242);
        _headView.delegate   = (id)self;
    }
    [self.view addSubview:_headView];
    
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    [flowLayOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayOut.headerReferenceSize = CGSizeMake(ZFScreenWidth, headViewHeight);
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-49) collectionViewLayout:flowLayOut];
        _collectionView.backgroundColor = ZFRGBColor(242, 242, 242);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZFBaseHeadADsCollectionViewCell class] forCellWithReuseIdentifier: ZFHomeContentIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZFHomeHeadIdentifier];
    }
    [self.view addSubview:_collectionView];
    _collectionView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [_headView requestHomeListModel];
        [self performSelector:@selector(refreshContent) withObject:nil afterDelay:0];
    }];
    _collectionView.mj_header.automaticallyChangeAlpha = YES;
    [_collectionView.mj_header beginRefreshing];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreContent)  ];
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载更多" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    _collectionView.mj_footer = footer;
    
 }

- (void)loadMoreContent {
    _page  =  [[[ZFUserDefaults shareInstance]getAccessTokenWithKey:kNextCursor] integerValue];
    [self sendHomeProductListRequest];
}

- (void)refreshContent {
    _page = 0;
    [self sendHomeProductListRequest];
}


- (void)sendHomeProductListRequest {
    NSString *addURL =[NSString stringWithFormat:@"count=40&cursor=%ld&%@",(long)_page,@"mid=457465&sid=be65752c7e4ee53dba4e5f3658fe8d80&type=choice&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220"];
    NSString *action  =@"product/quality.php?";
    NSString *baseURL = [NSString stringWithFormat:@"%@/1.0/%@%@",ZFBaseURL,action,addURL];

        [NetwokeManager requestGetMethodURL:baseURL parameters:nil uploadPreogerss:nil success:^(id data) {
            if (data) {
                //有数据
                if ([data isKindOfClass:[NSDictionary class]]&& [data[@"msg"] isEqualToString:@"ok"]) {
                    [self handleWithProductListJsonResult:data];
                    NSString *str = data[@"data"][@"next_cursor"];
                    if ([str length]>0) {
                        [[ZFUserDefaults shareInstance]setObject:str WithKey:kNextCursor];
                    }
                }else{//显示没有数据
                    if (_page==0) {
                        [self showNothing];
                    }else{
                        [_collectionView.mj_footer endRefreshingWithNoMoreData];
                        _page =[[[ZFUserDefaults shareInstance]getAccessTokenWithKey:kNextCursor] integerValue];
                    }
                }
            }else{
                //显示网络加载失败
                [self showRequestFailedView];
            }
        } failure:^(NSError *error) {
            [self.view bringSubviewToFront:_collectionView];
            _page >0 ?([[[ZFUserDefaults shareInstance]getAccessTokenWithKey:kNextCursor] integerValue]):(_page);
            [_collectionView.mj_header endRefreshing];
            [self showRequestFailedView];
            ZFDEBUGLOG(@"错误信息为:%@",error);
        }];
}

- (void)handleWithProductListJsonResult:(NSDictionary *)dic {
    _tempDic = dic[@"data"][@"products"];
    if (_tempDic) {
        if (_page==0) {
            //刷新数据
            [_productListArray removeAllObjects];
        }
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSDictionary *dic in _tempDic){
            ZFHomeHotGoodsModel *model = [[ZFHomeHotGoodsModel alloc]initWithDictionary:dic];
            [tempArray addObject:model];
        }
        [_productListArray addObjectsFromArray:tempArray];
    }
    //说明,此判断千万不可少,否则在用户突然断网一会又来网的情况下,用户无论怎样刷新app都不会出现app的内容,切记
    if ([_productListArray count]>0) {
        if (_requestFailedView ) {
            [_requestFailedView removeFromSuperview];
            _requestFailedView = nil;
        }
        if (_nothingView) {
            [_nothingView removeFromSuperview];
            _nothingView = nil;
        }
    }
    [_collectionView reloadData];
    if (_page==0) {
        if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
            [_collectionView.mj_header endRefreshing];
            _collectionView.mj_footer.state = MJRefreshStateIdle;
        }
     }else{
        [_collectionView.mj_footer endRefreshing];
    }
}

- (void)showNothing {
    if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_collectionView.mj_header endRefreshing];
    }
    if ([_collectionView.mj_footer respondsToSelector:@selector(endRefreshing)]) {
        [_collectionView.mj_footer endRefreshing];
    }
    if (_nothingView) {
        [self.view bringSubviewToFront:_nothingView];
        return;
    }
    _nothingView = [[ZFRequestNothingView alloc]init];
    _nothingView.frame = self.view.bounds;
    [self.view addSubview:_nothingView];
    [self.view bringSubviewToFront:_nothingView];
}

- (void)showRequestFailedView {
    if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_collectionView.mj_header endRefreshing];
    }
    if ([_collectionView.mj_footer respondsToSelector:@selector(endRefreshing)]) {
        [_collectionView.mj_footer endRefreshing];
    }
    if (_requestFailedView) {
        [self.view bringSubviewToFront:_requestFailedView];
        return;
    }
    _requestFailedView = [[ZFRequestFailedView alloc]init];
    _requestFailedView.frame = CGRectMake(0, [self getStartOriginY], self.view.frame.size.width, self.view.frame.size.height-64);
    _requestFailedView.delegate = self;
    [self.view addSubview:_requestFailedView];
    [self.view bringSubviewToFront:_requestFailedView];
    
    
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == _requestFailedView) {
        [self refreshContent];
        return;
    }
}

- (void)endRefreshWithResult:(NSDictionary *)dic {
    if (_tempDic && dic) {
        if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
            [_collectionView.mj_header endRefreshing];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _productListArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFBaseHeadADsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZFHomeContentIdentifier forIndexPath:indexPath];
    ZFHomeHotGoodsModel *model = _productListArray[indexPath.row];
    cell.goodsModel  = model;
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ZFScreenWidth-7*3)/2.0, 587/2.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7.0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZFHomeHeadIdentifier forIndexPath:indexPath];
    [headView addSubview:_headView];
    return headView;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFHomeHotGoodsModel *goodsModel = _productListArray[indexPath.row];
    ZFGoogsDetailViewController *detailVC = [[ZFGoogsDetailViewController alloc]init];
    detailVC.hotGoodsModel = goodsModel;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_toTopBtn) {
        _toTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-50, ZFScreenHeight-120, 50, 50)];
        [_toTopBtn setBackgroundImage:[UIImage imageNamed:@"go_top_btn"] forState:UIControlStateNormal];
        [_toTopBtn addTarget:self action:@selector(goToTopEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_toTopBtn];
    [self.view bringSubviewToFront:_toTopBtn];
    if (_requestFailedView||_nothingView) {
        [_toTopBtn setHidden:YES];
        [_collectionView setContentOffset:CGPointZero];
    }
    if (_collectionView.contentOffset.y>ZFScreenHeight) {
        [_toTopBtn setHidden:NO];
    }else {
        [_toTopBtn setHidden:YES];
    }
    
}

- (void)goToTopEvent:(UIButton *)sender {
    if (_collectionView.contentOffset.y>ZFScreenHeight) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            CGPoint contentOffset = _collectionView.contentOffset;
            contentOffset.y = 0;
            _collectionView.contentOffset = contentOffset;
        } completion:^(BOOL finished) {
            [_collectionView setContentOffset:CGPointZero animated:NO];
            [sender setHidden:YES];
        }];
    }
}




- (void)wantToJoinUs:(UIButton *)sender {
    ZFLoginViewController *loginVC = [[ZFLoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)searchEvent:(UIButton *)sender {
    ZFSearchViewController *search = [[ZFSearchViewController alloc]init];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}


#pragma mark------------------ZFBaseAdsViewDelegate--------------begin-------------------------------
- (void)clickCurrentIndex:(NSInteger)index {
    if (index !=500) {
        ZFHeadADsInfoViewController *infoVC = [[ZFHeadADsInfoViewController alloc]init];
        ZFHeadADsModel *headmodel = _headView.imageArray[index];
        infoVC.headModel = headmodel;
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }else{
        ZFBindCoinViewController *bindVC = [[ZFBindCoinViewController alloc]init];
        ZFHeadADsModel *headModel = _headView.imageArray[0];
        bindVC.conisnModel = headModel;
        bindVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bindVC animated:YES];
    }
}

- (void)getCurrentClickButtonTag:(NSInteger)tag {
    if (tag==100) {
        //品牌排行
        ZFBrandListViewController *brandVC = [[ZFBrandListViewController alloc]init];
        brandVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:brandVC animated:YES];
    }else if(tag==101) {
        ZFShakeInfoViewController *shakeVC = [[ZFShakeInfoViewController alloc]init];
        shakeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shakeVC animated:YES];
    
    }else{
        [ZFPublic showMessage:@"暂未开通"];
    }
}

- (void)didClickPicturesIndex:(NSInteger)tag withModel:(ZFHomeContentModel *)contentModel {
    if (tag==1005||tag==1006||tag==1007) {
        //值得买的跳转
        ZFGoogsDetailViewController *vc = [[ZFGoogsDetailViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.contentModel = contentModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didClickIndex:(NSInteger)tag toBrandListViewControlerWithModel:(ZHHomeListModel *)listModel {
    ZFBrandInfoViewController *brandVC = [[ZFBrandInfoViewController alloc]init];
    brandVC.listModel = listModel;
    [self.navigationController pushViewController:brandVC animated:YES];
}


#pragma mark------------------ZFBaseAdsViewDelegate--------------end-------------------------------



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navBarView.backgroundColor = ZFRGBColor(255, 69, 125);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //       开启定时器
        [_headView openTimerFire];
    });
}



- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_headView.imageArray.count>1) {
        [_headView invaliteTimer];
        self.view.backgroundColor = [UIColor whiteColor];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
