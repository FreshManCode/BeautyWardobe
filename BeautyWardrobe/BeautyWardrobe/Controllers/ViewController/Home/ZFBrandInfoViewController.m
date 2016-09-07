//
//  ZFBrandInfoViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/10.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBrandInfoViewController.h"
#import <UIImageView+WebCache.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "NetwokeManager.h"
#import "ZHHomeListModel.h"
#import "ZFLeftImageButton.h"
#import "ZFLeftTitleButton.h"
#import "ZFBaseHeadADsCollectionViewCell.h"
#import <MJRefresh.h>
#import "ZFGoogsDetailViewController.h"
#import <MobClick.h>


@interface ZFBrandInfoViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSMutableArray *_contentArray;
    NSMutableArray *_shareContentArray;
    ZFBrandShareModel *_shareModel;
    ZFLeftTitleButton *_lastSelctedBtn;
    NSString  *_searchAction;
}

@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIScrollView *headView;
@property (nonatomic,strong) UIView       *headImageView;
@property (nonatomic,strong) UILabel      *titleLab;
@property (nonatomic,strong) UIView       *leftView;
@property (nonatomic,strong) UIView       *rightView;
@property (nonatomic,strong) UIView       *categoryView;
@property (nonatomic,strong) UIImageView  *headImage;

@end

@implementation ZFBrandInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self sendShareContentRequest];
    [self sendRequst];
    _searchAction         = @"sort=0";
    [self initPrivateSubViews];
    [self initPublicSubview];
}


- (void)initPublicSubview {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(17, 36, 48, 48)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"brand_button_xbacknew"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backToFrontViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_backBtn];
    [self.view bringSubviewToFront:_backBtn];
    
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-(32+76)/2.0-10, 36, 48, 48)];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"brand_button_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareToFriendsLoop) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_shareBtn];
    [self.view bringSubviewToFront:_shareBtn];
    
}

- (void)initPrivateSubViews {
    if (!_headView) {
        _headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 408/2.0)];
        UIImage *image =  [UIImage imageNamed:@"userspace_top_bg.jpg"];
        _headView.backgroundColor = [UIColor colorWithPatternImage:image];
        _headView.bounces = YES;
    }
    [self.view addSubview:_headView];
    
    if(!_headImageView){
        _headImageView = [[UIView alloc]initWithFrame:CGRectMake(259/2.0, 20, 124/2.0, 124/2.0)];
        _headImageView.layer.cornerRadius = 124/4.0;
        _headImageView.backgroundColor = [UIColor whiteColor];
        [_headImageView clipsToBounds];
    }
    [_headView addSubview:_headImageView];
    
    if (!_headImage) {
       _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(2, 40/2.0, _headImageView.width-4, 20.0)];
       [_headImage sd_setImageWithURL:[NSURL URLWithString:_model.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    }
    [_headImageView addSubview:_headImage];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _headImageView.bottom+13, ZFScreenWidth, 13.0)];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = _model.title;
        _titleLab.font = [UIFont systemFontOfSize:16.0f];
    }
    [_headView addSubview:_titleLab];
    
    if (!_leftView) {
        _leftView = [[UIView alloc]initWithFrame:CGRectMake(40, _titleLab.bottom+13.0, 202/2.0, 58/2.0)];
        _leftView.backgroundColor = [UIColor clearColor];
        _leftView.layer.borderColor = [UIColor whiteColor].CGColor;
        _leftView.layer.borderWidth = 1.0f;
        _leftView.layer.cornerRadius = 5.0f;
        [_leftView clipsToBounds];
    }
    [_headView addSubview:_leftView];
    
    UIImageView *leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(12.0, 8, 18, 13.0)];
    leftImage.image = [UIImage imageNamed:@"msgc_ic_comment"];
    [_leftView addSubview:leftImage];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(leftImage.right+2, 0, _leftView.width-leftImage.right-2-5, _leftView.height)];
    [leftBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
    leftBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [leftBtn setTitleColor:ZFRGBColor(102, 101, 101) forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [leftBtn addTarget:self action:@selector(contactSellerEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_leftView addSubview:leftBtn];
    
    if (!_rightView) {
        _rightView = [[UIView alloc]initWithFrame:CGRectMake(ZFScreenWidth - 40 -202/2.0, _titleLab.bottom+13.0, 202/2.0, 58/2.0)];
        _rightView.backgroundColor = [UIColor clearColor];
        _rightView.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightView.layer.borderWidth = 1.0f;
        _rightView.layer.cornerRadius = 5.0f;
        [_rightView clipsToBounds];
    }
    [_headView addSubview:_rightView];
    
    
    ZFLeftImageButton *rightBtn = [[ZFLeftImageButton alloc]initWithFrame:CGRectMake(5, 0, _leftView.width-5, _leftView.height)];
    UIImage *image = [UIImage imageNamed:@"image_brand_detail_like"];
    [rightBtn setImage:image forState:UIControlStateNormal];
    [rightBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"plcaholer"] forState:UIControlStateSelected];
    [rightBtn setTitleColor:ZFRGBColor(102, 101, 101) forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;

    //button图片的偏移量 距上左下右分别为(8,10,8,_rightView.width-65)
//    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 15, 10,_rightView.width-85);
    //button标题的偏移量,偏移量相对于图片的
//    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    [rightBtn addTarget:self action:@selector(collectEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_rightView addSubview:rightBtn];
    
    if (!_categoryView) {
        _categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, _rightView.bottom+20, ZFScreenWidth, 35.0)];
        _categoryView.backgroundColor = [UIColor whiteColor];
    }
    [_headView addSubview:_categoryView];
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, 34.0, ZFScreenWidth, 1.0)];
    bottomLine.backgroundColor = ZFRGBColor(211, 211, 211);
    [_categoryView addSubview:bottomLine];
    CGFloat offSet = 35.0;
    CGFloat width  = (ZFScreenWidth -3*offSet-30)/3.0;
    NSArray *titleArray = [NSArray arrayWithObjects:@"新品",@"销量",@"价格" ,nil];
    NSArray *normaNameArray   = [NSArray arrayWithObjects:@"yuike_itemgroup_arrow_gray",@"yuike_itemgroup_arrow_gray",@"yuike_itemgroup_arrow2_gray", nil];
    NSArray *selecedNameArray = [NSArray arrayWithObjects:@"yuike_itemgroup_arrow_black",@"yuike_itemgroup_arrow_black",@"yuike_itemgroup_arrow2_blackup" ,nil];

    for(int i=0;i<3;i++){
        CGFloat x = (offSet +width) *i+offSet;
        CGFloat y =0;
        ZFLeftTitleButton *btn = [self categoryButtonWithFrame:CGRectMake(x, y, width, 34.0) andTitle:titleArray[i]
                                               normalImageName:normaNameArray[i] selecteedName:selecedNameArray[i]];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i+100;
        [_categoryView addSubview:btn];
        if (btn.tag==100) {
            _lastSelctedBtn = btn;
            _lastSelctedBtn.selected = YES;
        }
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(ZFScreenWidth, 408/2.0);
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, ZFScreenHeight) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = ZFRGBColor(242, 242, 242);
        [_collectionView registerClass:[ZFBaseHeadADsCollectionViewCell class] forCellWithReuseIdentifier:ZFBrandInfoIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZFBeandInfoHaedIdentifier];
     }
    [self.view addSubview:_collectionView];
    
}


- (ZFLeftTitleButton *)categoryButtonWithFrame:(CGRect)frame andTitle:(NSString *)title normalImageName:(NSString *)normalName selecteedName:(NSString *)selectedName
{
    ZFLeftTitleButton *btn = [[ZFLeftTitleButton alloc]initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:ZFRGBColor(219, 81, 128) forState:UIControlStateSelected];
    [btn setTitleColor:ZFRGBColor(102, 101, 101) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [btn addTarget:self action:@selector(chooseDifferentType:) forControlEvents:UIControlEventTouchUpInside];
    return btn;

}

- (void)chooseDifferentType:(ZFLeftTitleButton *)sender {
    [[NetwokeManager shareInstance]hudShowMessage:@"加载中..."];
    static NSInteger clickIndex;
    if (sender.tag==102){
        [_lastSelctedBtn setSelected:NO];
        _lastSelctedBtn = sender;
        if (clickIndex %2==0) {
            //价格升序
            sender.selected = YES;
            [sender setImage:[UIImage imageNamed:@"yuike_itemgroup_arrow2_blackup"] forState:UIControlStateSelected];
            [self sendRequst];
            _searchAction = nil;
            _searchAction = @"sort=3";
            
        }else{
            //价格降序
            sender.selected = YES;
            [sender setImage:[UIImage imageNamed:@"yuike_itemgroup_arrow2_blackdown"] forState:UIControlStateSelected];
            [self sendRequst];
            _searchAction = nil;
            _searchAction = @"sort=2";
            
        }
        clickIndex ++;
    }else{
        clickIndex =0;
        [_lastSelctedBtn setSelected:NO];
        _lastSelctedBtn = sender;
        [_lastSelctedBtn setSelected:YES];
        if (sender.tag==101) {
            [self sendRequst];
            _searchAction = nil;
            _searchAction = @"sort=1";
        }else{
            [self sendRequst];
            _searchAction = nil;
            _searchAction = @"sort=0";
        }
    }
}

#pragma mark------分享内容的解析
- (void)hanldeWithShareConentResult:(NSDictionary *)dic {
    _shareModel = [[ZFBrandShareModel alloc] initWithDictionary:dic];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_shareModel.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    [_titleLab setText:_shareModel.title];
    
}



#pragma mark-------展示内容的网络请求
- (void)sendRequst {
    [_contentArray removeAllObjects];
    NSString *action      = @"1.0/search/search.php?";
    NSString *brandId ;
    if ([_listModel.action length]>0) {
        NSArray *array = [_listModel.action componentsSeparatedByString:@"brand?"];
        brandId = [array lastObject];
    }else{
        brandId  = [NSString stringWithFormat:@"brand_id=%@",_model.idNum];
    }
    NSString *leftOthers  = @"count=40&cursor=0&mid=457465&sid=e61220782bc1026de0b491541938e8b8&";
    NSString *rightOthers = @"&type=product&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032";
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@&%@%@%@",ZFBaseURL,action,brandId,leftOthers,_searchAction,rightOthers];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data &&[data [@"msg"] isEqualToString:@"ok"]) {
            [self handleWithResultNSDictionary:data[@"data"]];
        }else{
            ZFDEBUGLOG(@"%@",data);
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"请求错误为%@",error);
    }];
    
}

- (void)sendShareContentRequest {
    NSString *action    = @"1.0/brand/detail.php?";
    NSString *brandId ;
    if ([_listModel.action length]>0) {
        NSArray *array = [_listModel.action componentsSeparatedByString:@"brand?"];
        brandId = [array lastObject];
    }else{
        brandId  = [NSString stringWithFormat:@"brand_id=%@",_model.idNum];
    }
    NSString *others    = @"&mid=457465&sid=e61220782bc1026";
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@&%@",ZFBaseURL,action,brandId,others];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data &&[data [@"msg"] isEqualToString:@"ok"]) {
            _contentArray = [[NSMutableArray alloc]initWithCapacity:0];
            [self hanldeWithShareConentResult:data[@"data"]];
        }else{
            ZFDEBUGLOG(@"%@",data);
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"请求错误为%@",error);
    }];

}


#pragma mark 商品内容的解析
- (void)handleWithResultNSDictionary:(NSDictionary *)dic {
    if ([[NetwokeManager shareInstance]respondsToSelector:@selector(hudHiddenImmediately)]) {
        [[NetwokeManager shareInstance]hudHiddenImmediately];
    }
    for(NSDictionary *tempDic  in dic[@"products"]){
        ZFBrandInfoModel *model = [[ZFBrandInfoModel alloc]initWithDictionary:tempDic];
        [_contentArray addObject:model];
    }
    [_collectionView reloadData];
}

#pragma mark------联系卖家的点击事件
- (void)contactSellerEvent:(UIButton *)sender {
}

- (void)collectEvent:(ZFLeftImageButton *)sender {
    static NSInteger clickTimes;
    if (clickTimes%2==0) {
        sender.selected = YES;
        sender.leftZero = YES;
        [sender setTitle:@"取消收藏" forState:UIControlStateSelected];
        sender.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }else{
        sender.leftZero = NO;
        sender.selected = NO;
    }
    clickTimes ++;
}

- (void)backToFrontViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark------分享功能
- (void)shareToFriendsLoop{
    NSString *picURL = _shareModel.pic_url;
    NSString *urlString = [NSString stringWithFormat:@"http://www.yuike.com/vmall/3g/vc3g/page/goodsall.php?id=%@&&brand_id=%@",_shareModel.merchant_id,_shareModel.idNum];
    if ([picURL length]>0) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:_shareModel.share_message images:@[picURL] url:[NSURL URLWithString:urlString] title:_shareModel.share_title type:SSDKContentTypeAuto];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            switch (state) {
                case SSDKResponseStateSuccess:
                    [MobClick endEvent:@"share"];
                    [ZFPublic updateWindowsWithTitle:@"分享成功" withTime:1.0];
                    break;
                case SSDKResponseStateFail:
                    [ZFPublic updateWindowsWithTitle:@"分享失败" withTime:1.0];
                    break;
                default:
                    break;
            }
        }];
    }
}

#pragma mark--------UICollectionViewDelegate---

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _contentArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFBaseHeadADsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZFBrandInfoIdentifier forIndexPath:indexPath];
    ZFBrandInfoModel *infoModel = _contentArray[indexPath.row];
    cell.brandInfoModel = infoModel;
    return cell;
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ZFScreenWidth-7*3)/2.0, 587/2.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 7.0;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZFBeandInfoHaedIdentifier forIndexPath:indexPath];
    [headView addSubview:_headView];
    return headView;
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFBrandInfoModel *infoModel = _contentArray[indexPath.row];
    ZFGoogsDetailViewController *detailVC = [[ZFGoogsDetailViewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.brandInfoModel = infoModel;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
