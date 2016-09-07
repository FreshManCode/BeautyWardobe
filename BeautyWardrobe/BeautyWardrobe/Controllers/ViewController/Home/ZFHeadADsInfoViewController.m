//
//  ZFHeadADsInfoViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/29.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFHeadADsInfoViewController.h"
#import "NetwokeManager.h"
#import <UIImageView+WebCache.h>
#import "ZFBaseHeadADsCollectionViewCell.h"
#import "ZFHeadADsProductModel.h"
#import <MJRefresh.h>
#import "ZFGoogsDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <MobClick.h>
@interface ZFHeadADsInfoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSMutableArray *_contentArray;
    NSString       *_infoURL;
}

@property (nonatomic,strong) UIScrollView *headView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIButton *toTopBtn;
@property (nonatomic,strong) ZFHeadADsProductModel *model;

@end

@implementation ZFHeadADsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    [self sendHeadADsContentRequest];

    
}

- (void)setUpSubviews {
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray  *array    = [_headModel.url componentsSeparatedByString:@"activity_id="];
    NSArray  *array1   = [array[1] componentsSeparatedByString:@"&"];
    NSString *objectID = [NSString stringWithFormat:@"%@%@",@"object_id=",array1[0]];
    NSString *activiID = [NSString stringWithFormat:@"%@%@",@"activity_id=",array1[0]];
    NSString *activiURL  = [NSString stringWithFormat:@"%@/%@%@&%@",ZFBaseURL,@"1.0/activity/detail.php?",activiID,@"mid=457465&sid=8b40be44a760af346fce410805bd1da6&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220"];
    _infoURL = [NSString stringWithFormat:@"%@/%@%@&%@",ZFBaseURL,@"1.0/product/object_products.php?count=40&cursor=0&mid=457465&",objectID,@"sid=8b40be44a760af346fce410805bd1da6&type=activity&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220"];
    [NetwokeManager requestGetMethodURL:activiURL parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data) {
            [self hanleWithHeadResultContent:data];
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"%@----",error);
    }];
    
}

- (void)hanleWithHeadResultContent:(NSDictionary *)dic {
    if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_collectionView.mj_header endRefreshing];
    }
    NSString *titleLabel  = dic[@"data"][@"short_title"];
    NSString *description = dic[@"data"][@"description"];
    NSString *headPicture = dic[@"data"][@"pic_url"];
    if (headPicture) {
        if (!_headView) {
            self.titleLabel.text = titleLabel;
            _headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 364/2.0+35)];
            _headView.bounces = NO;
            _headView.backgroundColor = ZFRGBColor(242, 242, 242);
        }
        [self.view addSubview:_headView];

        UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, _headView.height-35)];
        [bgImage sd_setImageWithURL:[NSURL URLWithString:headPicture] placeholderImage:nil];
        [_headView addSubview:bgImage];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, bgImage.bottom, _headView.width, 35)];
        bottomView.backgroundColor = ZFRGBColor(255, 243, 233);
        [_headView addSubview:bottomView];
        
        UILabel*contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ZFScreenWidth-20, bottomView.height)];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont systemFontOfSize:15.0f];
        contentLabel.text = description;
        [bottomView addSubview:contentLabel];
        
        [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
        [self.rightButton setBackgroundColor:[UIColor clearColor]];
        [self.rightButton setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
        [self.rightButton setTitle:@"分享" forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.rightButton addTarget:self action:@selector(shareEventClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)sendHeadADsContentRequest {
    [NetwokeManager requestGetMethodURL:_infoURL parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data) {
            [self handleWithADsContentResult:data];
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"error:%@",error);
    }];
}


- (void)handleWithADsContentResult:(NSDictionary *)dic {
    if ([_collectionView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_collectionView.mj_header endRefreshing];
    }
    _contentArray = [[NSMutableArray alloc]init];
    NSDictionary *tempDic = dic[@"data"][@"products"];
    for (NSDictionary *dic in tempDic) {
        ZFHeadADsProductModel *model = [[ZFHeadADsProductModel alloc]initWithDictionary:dic];
        [_contentArray addObject:model];
    }
    if(_contentArray.count >0) {
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
        [flowLayOut setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置headview的大小
        flowLayOut.headerReferenceSize = CGSizeMake(ZFScreenWidth, 364/2.0+35);
        if (!_collectionView) {
            _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight) collectionViewLayout:flowLayOut];
            _collectionView.backgroundColor = ZFRGBColor(245, 245, 245);
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            [_collectionView registerClass:[ZFBaseHeadADsCollectionViewCell class] forCellWithReuseIdentifier:ZFADsContentIdentifier];
            [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ZFADsNMoreContentIdentifier];
            
            [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZFADsHeadIdentifier];
        }
        [self.view addSubview:_collectionView];
        __weak __typeof(self) weakSelf = self;
        _collectionView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf performSelector:@selector(sendHeadADsContentRequest) withObject:nil afterDelay:0.1];
        }];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _contentArray.count +1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<=_contentArray.count-1) {
        ZFBaseHeadADsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZFADsContentIdentifier forIndexPath:indexPath];
        _model = _contentArray[indexPath.row];
        cell.model = _model;
        return cell;
    }else{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZFADsNMoreContentIdentifier forIndexPath:indexPath];
        UIView *allView = [[UIView alloc]initWithFrame:CGRectMake(0, -7, ZFScreenWidth, 45.0)];
        allView.backgroundColor = ZFRGBColor(242, 242, 242);
        [cell.contentView addSubview:allView];
        UILabel *noContentLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, ZFScreenWidth, 25)];
        noContentLab.text = @"亲:已经没有更多内容了就到这里了";
        noContentLab.textAlignment = NSTextAlignmentCenter;
        [allView addSubview:noContentLab];
        
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ZFScreenWidth-7.5*3)/2.0, 587/2.0);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7.50;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZFADsHeadIdentifier forIndexPath:indexPath];
    [headView addSubview:_headView];
    return headView;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFHeadADsProductModel *productModel = _contentArray[indexPath.row];
    ZFGoogsDetailViewController *detailVC = [[ZFGoogsDetailViewController alloc]init];
    detailVC.productModel = productModel;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    if (!_toTopBtn) {
        _toTopBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-50, ZFScreenHeight-60, 50, 50)];
        [_toTopBtn setBackgroundImage:[UIImage imageNamed:@"go_top_btn"] forState:UIControlStateNormal];
        [_toTopBtn addTarget:self action:@selector(goToTopEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [keyWindow addSubview:_toTopBtn];
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
            [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
            [sender setHidden:YES];
        }];
     }
}


#pragma mark--------分享功能
- (void)shareEventClick:(UIButton *)sender {
    NSString *  picURL  = _model.taobao_pic_url;
    NSString *  content = _model.taobao_title;
    NSString *  url     = _model.taobao_url;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:content images:@[picURL] url:[NSURL URLWithString:url] title:_model.taobao_title type:SSDKContentTypeAudio];
    [ShareSDK showShareActionSheet:nil items:nil shareParams:params onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
                [MobClick endEvent:@"share"];
                [[NetwokeManager shareInstance]updateWindowsWithTitle:@"分享成功" withTime:1.0];
                break;
            case SSDKResponseStateFail:
                [[NetwokeManager shareInstance]updateWindowsWithTitle:@"分享失败" withTime:1.0f];

                break;
                
            default:
                break;
        }
    }];
    
}



@end
