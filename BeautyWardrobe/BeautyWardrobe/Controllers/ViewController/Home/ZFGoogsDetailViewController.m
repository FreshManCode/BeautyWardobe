//
//  ZFGoogsDetailViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoogsDetailViewController.h"
#import "NetwokeManager.h"

#import "ZFGoodsDetailHeadCell.h"
#import "ZFMyViewCell.h"
#import "ZFGoosDetailFourLogoCell.h"
#import "ZFGoodsDetailTextCell.h"
#import "ZFGoodsDetailModel.h"
#import "ZFGoodsDetailImageCell.h"
#import "ZFImagePaperViewController.h"
#import "ZFTaoBaoImageViewController.h"
#import "ZFGoogsImageTextCell.h"
#import "ZFBottomView.h"
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDK/ShareSDK.h>
#import <MobClick.h>
@interface ZFGoogsDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ZFGoodsDetailHeadCellDelegate,ZFGoodsDetailImageCellDelegate>
{
    NSMutableArray *_baseContentArray;
    NSMutableArray *_serviceArray;
    NSMutableArray *_propsNameArray;
    NSMutableArray *_mobileDescArray;
    NSMutableArray *_infoArray;
    NSUInteger     *_sectionNum;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView  *bottomView;
@property (nonatomic,strong) CALayer *cartNumLayer;
@property (nonatomic,strong) UILabel *cartNumLab;
@property (nonatomic,strong) UIButton *lastSeletedBtn;
@property (nonatomic,strong) UIButton *goodsBtn;
@property (nonatomic,strong) UIButton *guideBtn;
@property (nonatomic,strong) ZFGoodsDetailModel *baseDetailModel;
@property (nonatomic,strong) ZFGoodsDetailHeadImageModel *headImageModel;
@property (nonatomic,strong) ZFGoodsBrandModel  *brandModel;



@end

@implementation ZFGoogsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _baseContentArray = [[NSMutableArray alloc]initWithCapacity:0];
    _serviceArray = [[NSMutableArray alloc]initWithCapacity:0];
    _propsNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    _mobileDescArray = [[NSMutableArray alloc]initWithCapacity:0];
    _infoArray = [[NSMutableArray alloc] initWithObjects:@"如何联系",@"美丽衣橱",@"在美丽衣橱",@"我如何付款",@"付款后多久发货",@"运费需要多少钱",@"商品的尺码标准",@"商品有色差",@"我想要的商品缺货",@"商品收到后",@"我收到货了",@"什么情况下",@"退款成功后", nil];
    [self networkRequest];
    [self setUpSubViews];
}

- (void)networkRequest {
    NSString *action = @"1.0/product/detail.php?";
    NSString *taobao_num_iid;
    if ([_contentModel.taobao_num_iid length]>0) {
        taobao_num_iid = _contentModel.taobao_num_iid;
    }else if ([_hotGoodsModel.taobao_num_iid length]>0){
        taobao_num_iid = _hotGoodsModel.taobao_num_iid;
    }else if ([_productModel.taobao_num_iid length]>0){
        taobao_num_iid = _productModel.taobao_num_iid;
    }else if ([_brandInfoModel.taobao_num_iid length]>0){
        taobao_num_iid = _brandInfoModel.taobao_num_iid;
    }else if ([_itemModel.taobao_num_iid length]>0){
        taobao_num_iid = _itemModel.taobao_num_iid;
    }
    NSString *idNum = [NSString stringWithFormat:@"taobao_num_iid=%@",taobao_num_iid];
    NSString *leftOthers  = @"mid=457465&sid=21d90a0d143ba4572b103ce5b36b0d99&";
    NSString *rightOthers = @"&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032";
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@&%@%@",ZFBaseURL,action,idNum,leftOthers,rightOthers];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data &&[data[@"msg"] isEqualToString:@"ok"]) {
            [self hanleWithRequestResult:data];
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"没有内容了亲" withTime:1.0f];
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"error:%@",error);
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"网络不好呢,亲" withTime:1.0f];
    }];

}

- (void)setUpSubViews {
    self.titleLabel.text = @"品牌排行榜";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-142/2.0, 14.0+17, 25.0, 25.0)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"button_titleBar_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(topEventClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.tag = 10;
    [self.navBarView addSubview:shareBtn];
    
    UIButton *cartBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-18*2.0, 14.0+17, 25.0, 25.0)];
    cartBtn.tag = 20;
    [cartBtn setBackgroundImage:[UIImage imageNamed:@"user_shop_cart"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(topEventClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:cartBtn];
    
    if (!_cartNumLayer) {
        _cartNumLayer = [CALayer layer];
        _cartNumLayer.frame = CGRectMake(cartBtn.right-10, cartBtn.top-8, 18.0, 18.0);
        _cartNumLayer.backgroundColor = ZFRGBColor(219, 81, 128).CGColor;
        _cartNumLayer.cornerRadius = 9.0;
    }
    [self.navBarView.layer addSublayer:_cartNumLayer];
    
    if (!_cartNumLab) {
        _cartNumLab = [[UILabel alloc]initWithFrame:CGRectMake(cartBtn.right-10, cartBtn.top-8, 18.0, 18.0)];
        _cartNumLab.text = @"2";
        _cartNumLab.font = [UIFont systemFontOfSize:10.0f];
        _cartNumLab.textColor = [UIColor whiteColor];
        _cartNumLab.textAlignment = NSTextAlignmentCenter;
    }
    [self.navBarView addSubview:_cartNumLab];
    
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-49-[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZFRGBColor(231, 231, 231);
    }
    [self.view addSubview:_tableView];
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ZFScreenHeight-49.0, ZFScreenWidth, 49.0)];
        _bottomView.backgroundColor = ZFRGBColor(242, 242, 242);
    }
    [self.view addSubview:_bottomView];
    [self.view bringSubviewToFront:_bottomView];
    
    CGFloat width = (ZFScreenWidth -10*4)/4.0;
    NSString *text = @"我要加盟";

    CGSize size = [ZFPublic sizeWithString:text font:ZFFont(12) maxSize:CGSizeMake(75, 49.0)];

    UILabel *joinLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0,size.width, _bottomView.height)];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wantToJoin)];
    [joinLab addGestureRecognizer:tapGesture];
    joinLab.text = text;
    joinLab.font = ZFFont(12.0f);
    [_bottomView addSubview:joinLab];
    
    UIView *lineView = [UIView new];
    lineView.center = CGPointMake(joinLab.center.x, joinLab.center.y+6.5f);
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.bounds = CGRectMake(0, 0, size.width, 0.5);
    [_bottomView addSubview:lineView];
    
    UIButton *contanctBtn = [[UIButton alloc]initWithFrame:CGRectMake(width+10, 2, width, 44)];
    [contanctBtn setBackgroundImage:[UIImage imageNamed:@"button_pdetail_chat"] forState:UIControlStateNormal];
    contanctBtn.tag = 5;
    [contanctBtn addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:contanctBtn];
    
    UIButton *shoppingBtn = [[UIButton alloc]initWithFrame:CGRectMake(contanctBtn.right+ 10, 2, width, 44)];
    [shoppingBtn setBackgroundImage:[UIImage imageNamed:@"button_pdetail_addshop"] forState:UIControlStateNormal];
    shoppingBtn.tag = 6;
    [shoppingBtn addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:shoppingBtn];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth - (ZFScreenWidth -10*4)/4.0 -10, 10, width, 29)];
    [buyBtn setBackgroundImage:[UIImage imageNamed:@"bg_btn"] forState:UIControlStateNormal];
    [buyBtn setTitle:@"立刻购买" forState:UIControlStateNormal];
    [buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyBtn.titleLabel.font = ZFFont(15.0f);
    [buyBtn addTarget:self action:@selector(buyImmediatelyEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:buyBtn];
    
}

- (void)hanleWithRequestResult:(NSDictionary *)dic{
    _baseDetailModel = [[ZFGoodsDetailModel alloc]initWithDictionary:dic[@"data"]];
    for(NSDictionary *tempDic in _baseDetailModel.taobao_item_imgs){
        _headImageModel = [[ZFGoodsDetailHeadImageModel alloc]initWithDictionary:tempDic];
    }
    for(NSDictionary *serviceDic in _baseDetailModel.service){
        ZFGoodsServiceModel *serviceModel = [[ZFGoodsServiceModel alloc]initWithDictionary:serviceDic];
        [_serviceArray addObject:serviceModel];
    }
    
    for(NSDictionary * propsNameDic in _baseDetailModel.props_name){
        ZFGoodsPropsNameModel *nameModel = [[ZFGoodsPropsNameModel alloc]initWithDictionary:propsNameDic];
        [_propsNameArray addObject:nameModel];
    }
    
    for(NSDictionary *mobileDesDic in _baseDetailModel.mobile_desc){
        ZFGoodsMobileDescModel  *mobileModel = [[ZFGoodsMobileDescModel alloc] initWithDictionary:mobileDesDic];
        [_mobileDescArray addObject:mobileModel];
    }
    _brandModel = [[ZFGoodsBrandModel alloc]initWithDictionary:_baseDetailModel.brand];
    [_tableView reloadData];
}

#pragma mark------ZFGoodsDetailHeadCellDelegate
- (void)didClickImage:(ZFGoodsDetailModel *)detailMoel {
    ZFImagePaperViewController *paper = [[ZFImagePaperViewController alloc]init];
    paper.detailModel = detailMoel;
    paper.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:paper animated:YES];
}

#pragma mark-------ZFGoodsDetailImageCellDelegate
- (void)didClickTaobaoInfoImageWithModel:(ZFGoodsMobileDescModel *)mobileModel {
    ZFTaoBaoImageViewController *taobao = [[ZFTaoBaoImageViewController alloc]init];
    taobao.mobileModel = mobileModel;
    taobao.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:taobao animated:YES];
}




#pragma mark-------UITableViewDelegate --UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==3) {
        return 40;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 10;
    }else {
        return 0;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==3) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 40)];
        headView.backgroundColor = ZFRGBColor(242, 242, 242);
        if (!_goodsBtn) {
            _goodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 10, 60, 20)];
            [_goodsBtn setTitle:@"商品细节" forState:UIControlStateNormal];
            [_goodsBtn setTitleColor:ZFRGBColor(100, 100, 100) forState:UIControlStateNormal];
            [_goodsBtn setTitleColor:ZFRGBColor(219, 81, 128) forState:UIControlStateSelected];
            [_goodsBtn addTarget:self action:@selector(transferFollowContent:) forControlEvents:UIControlEventTouchUpInside];
            _goodsBtn.titleLabel.font = ZFFont(13.0f);
            [_goodsBtn setSelected:YES];
        }
        [headView addSubview:_goodsBtn];
        if (!_guideBtn) {
            _guideBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth- 110, 10, 60, 20)];
            [_guideBtn setTitle:@"购物须知" forState:UIControlStateNormal];
            [_guideBtn setTitleColor:ZFRGBColor(100, 100, 100) forState:UIControlStateNormal];
            [_guideBtn setTitleColor:ZFRGBColor(219, 81, 128) forState:UIControlStateSelected];
            [_guideBtn addTarget:self action:@selector(transferFollowContent:) forControlEvents:UIControlEventTouchUpInside];
            _guideBtn.titleLabel.font = ZFFont(13.0f);
        }
        [headView addSubview:_guideBtn];
        return headView;
    }else{
        return nil;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) {
        return 2;
    }else if (section==3){
        return _propsNameArray.count +1 +_mobileDescArray.count;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ZFGoodsDetailHeadCell *cell = (ZFGoodsDetailHeadCell*) [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return [cell contentHeight];
    }else if(indexPath.section==2) {
        if (indexPath.row==0) {
            return 35+12*3+8;
        }else{
            return 50;
        }
    }else if (indexPath.section==3){
            ZFGoodsDetailTextCell *cell = (ZFGoodsDetailTextCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            if (indexPath.row<_propsNameArray.count) {
                return 40;
            }else if(indexPath.row==_propsNameArray.count){
                cell.cellType = ZFGoodsDetailTextCellTypeDesCell;
                return [cell cellContentHeight];
                
            }else{
                return 565/2.0;
            }
    }
    else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        ZFGoodsDetailHeadCell *cell = [ZFGoodsDetailHeadCell cellWithTableView:tableView];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailModel = _baseDetailModel;
        return cell;
    }else if(indexPath.section==1){
        ZFGoogsImageTextCell *cell = [ZFGoogsImageTextCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftIcon.image = [UIImage imageNamed:@"wx_code"];
        cell.titleLab.text  = @"生成二维码图片";
        cell.contetntLab.text = @"好友扫码可购买";
        return cell;
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            ZFGoosDetailFourLogoCell *cell = [ZFGoosDetailFourLogoCell cellWithTableView:tableView];
            cell.detailModel = _baseDetailModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            ZFGoogsImageTextCell *cell = [ZFGoogsImageTextCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.brandModel = _brandModel;
            return cell;
        }
    }else {
            if (indexPath.row<_propsNameArray.count) {
                ZFGoodsDetailTextCell *cell = [ZFGoodsDetailTextCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.cellType = ZFGoodsDetailTextCellTypeLineCell;
                ZFGoodsPropsNameModel *nameModel = _propsNameArray[indexPath.row];
                cell.nameModel = nameModel;
                return cell;
            }else if(indexPath.row ==_propsNameArray.count) {
                ZFGoodsDetailTextCell *cell = [ZFGoodsDetailTextCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.cellType = ZFGoodsDetailTextCellTypeDesCell;
                cell.detailModel = _baseDetailModel;
                return cell;
            }else {
                ZFGoodsMobileDescModel *mobileModel = _mobileDescArray[indexPath.row - _propsNameArray.count-1];
                ZFGoodsDetailImageCell *cell = [ZFGoodsDetailImageCell cellWithTablView:tableView];
                cell.delegate = self;
                cell.mobileModel = mobileModel;
                return cell;
            }
    }
}

- (void)transferFollowContent:(UIButton *)sender {
    
}


#pragma mark-----我要加盟
- (void)wantToJoin {
    
}

#pragma mark------联系卖家,加入购物车
- (void)btnClickEvent:(UIButton *)sender {
    
}

#pragma mark-------立刻购买
- (void)buyImmediatelyEvent:(UIButton *)sender {
    
}

#pragma mark------分享,购物车按钮
- (void)topEventClick:(UIButton *)sender {
    if (sender.tag==10) {
        [self createShareConentParams];
    }else{
        [self createCartContent];
    }
}

#pragma mark------分享
- (void)createShareConentParams {
    NSString *title = @"我觉着这个不错,给你瞅瞅";
    NSString *picURL , *content, *url;;
    if ([_contentModel.taobao_pic_url length]>0) {
        picURL  = _contentModel.taobao_pic_url;
        content = _contentModel.taobao_title;
        url     = _contentModel.taobao_url;
    }else if ([_hotGoodsModel.taobao_pic_url length]>0){
        content = _hotGoodsModel.taobao_title;
        picURL = _hotGoodsModel.taobao_pic_url;
        url     = _hotGoodsModel.taobao_url;
    }else if ([_productModel.taobao_pic_url length]>0){
        picURL  = _productModel.taobao_pic_url;
        content = _productModel.taobao_title;
        url     = _productModel.taobao_url;
    }else if ([_brandInfoModel.taobao_pic_url length]>0){
        picURL = _brandInfoModel.taobao_pic_url;
        content = _brandInfoModel.taobao_title;
        url     = _brandInfoModel.taobao_url;
    }else if ([_itemModel.taobao_pic_url length]>0){
        picURL = _itemModel.taobao_pic_url;
        content = _itemModel.taobao_title;
        url     = _itemModel.taobao_url;
    }
    if ([picURL length]>0) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:content images:@[picURL] url:[NSURL URLWithString:url] title:title type:SSDKContentTypeAuto];
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
#pragma mark-----购物车功能
- (void)createCartContent {
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
