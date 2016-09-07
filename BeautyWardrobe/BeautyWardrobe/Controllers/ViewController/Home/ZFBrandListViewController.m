//
//  ZFBrandListViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBrandListViewController.h"
#import "NetwokeManager.h"
#import "ZFBrandListModel.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "ZFRequestFailedView.h"
#import "ZFBrandInfoViewController.h"
@interface ZFBrandListViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_girlClothesrray;
    NSMutableArray *_girlShoesArray;
    NSMutableArray *_beautifulMakeArray;
    NSMutableArray *_dectorateArray;
    NSMutableArray *_girlBagArray;
    NSMutableArray *_contentArray;
    NSMutableArray *_titleArray;
}
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *girlClothView;
@property (nonatomic,strong) UIView *girlShoesView;
@property (nonatomic,strong) UIView *beautifulMakeView;
@property (nonatomic,strong) UIView *dectorateView;
@property (nonatomic,strong) UIView *girlBagView;
@property (nonatomic,strong) ZFRequestFailedView *requestFailedView;

@end

@implementation ZFBrandListViewController

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self setSubViews];
}

- (void)setSubViews {
    self.titleLabel.text = @"品牌排行榜";
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    [self setScrollView];
    [self sendRequest];
    
}
- (void)setScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight)];
        _bgScrollView.bounces = YES;
        _bgScrollView.backgroundColor = [UIColor whiteColor];
    }
    [self.view addSubview:_bgScrollView];
    _bgScrollView.mj_header = [ZFRefreshHeader headerWithRefreshingBlock:^{
        [self sendRequest];
    }];
}


- (void)sendRequest {
    NSString *url = @"http://vapi.yuike.com/1.0/brand/ranking_list.php?mid=457465&sid=e24daffbe1dbd8acad0ea14c7df04dbe&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220";
    [NetwokeManager requestGetMethodURL:url parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data &&[data isKindOfClass:[NSDictionary class]]){
            [self handleWithResult:data];
            if ([_bgScrollView.mj_header respondsToSelector:@selector(endRefreshing )]) {
                [_bgScrollView.mj_header endRefreshing];
            }
        }
    } failure:^(NSError *error) {
        [self showRequestFailedView];
    }];
}


- (void)handleWithResult:(NSDictionary *)dic {
    _titleArray = [[NSMutableArray alloc]initWithCapacity:0];
    _girlClothesrray = [[NSMutableArray alloc]initWithCapacity:0];
    _girlShoesArray  = [[NSMutableArray alloc]initWithCapacity:0];
    _beautifulMakeArray = [[NSMutableArray alloc]initWithCapacity:0];
    _dectorateArray = [[NSMutableArray alloc]initWithCapacity:0];
    _girlBagArray   = [[NSMutableArray alloc]initWithCapacity:0];
    if (dic[@"data"]) {
        NSMutableArray *tempArray = [[NSMutableArray alloc]initWithCapacity:0];
        for (NSArray *array in  dic[@"data"]){
            [tempArray addObject:array];
        }
        ZFBrandListModel *model = [[ZFBrandListModel alloc]initWithDictionary:tempArray[0]];
        for(NSArray *array in model.items){
            [_girlClothesrray addObject:array];
        }
        [_titleArray addObject:model];
        
        ZFBrandListModel *model1 = [[ZFBrandListModel alloc]initWithDictionary:tempArray[1]];
        for(NSArray *array in model1.items){
            [_girlShoesArray addObject:array];
        }
        [_titleArray addObject:model1];
        
        ZFBrandListModel *model2 = [[ZFBrandListModel alloc]initWithDictionary:tempArray[2]];
        for(NSArray *array in model2.items){
            [_beautifulMakeArray addObject:array];
        }
        [_titleArray addObject:model2];
        
        ZFBrandListModel *model3 = [[ZFBrandListModel alloc]initWithDictionary:tempArray[3]];
        for(NSArray *array in model3.items){
            [_dectorateArray addObject:array];
        }
        [_titleArray addObject:model3];
        
        ZFBrandListModel *model4 = [[ZFBrandListModel alloc]initWithDictionary:tempArray[4]];
        for(NSArray *array in model4.items){
            [_girlBagArray addObject:array];
        }
        [_titleArray addObject:model4];
        _contentArray = [[NSMutableArray alloc]initWithObjects:_girlClothesrray,_girlShoesArray,_beautifulMakeArray,_dectorateArray, _girlBagArray,nil];
    }
    
    CGFloat offX   = 1.0;
    CGFloat offY   = 1.0;
    CGFloat width  = (ZFScreenWidth -40-3.0)/4.0;
    CGFloat height = 55;
    //女装
    ZFBrandListModel *clotheModel = _titleArray[0];
    NSArray *clothArray = _contentArray[0];
    CGFloat clothHeight = 45 + (clothArray.count %4==0 ?clothArray.count/4:clothArray.count/4+1) *56;
    
    _girlClothView = [UIView new];
    _girlClothView.frame = CGRectMake(0, 0, ZFScreenWidth, clothHeight);
    [_bgScrollView addSubview:_girlClothView];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ZFScreenWidth, 45)];
    titleLab.text =clotheModel.groupName;
    titleLab.textAlignment = NSTextAlignmentLeft;
    [_girlClothView addSubview:titleLab];
    for(int i=0;i<clothArray.count;i++){
        ZFBrandListContentModel *model = [[ZFBrandListContentModel alloc]initWithDictionary:clothArray[i]];
        CGFloat x = (offX +width)  *(i%4) +offX+20;
        CGFloat y = (offY +height) *(i/4) +offY;
        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, titleLab.bottom+y, width, height)];
        bgView.backgroundColor = ZFRGBColor(242, 242, 242);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLookMoreDetailEvent:)];
        [bgView addGestureRecognizer:tapGesture];
        [_girlClothView addSubview:bgView];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width*0.20), (bgView.height-20)/2.0, bgView.width*0.6, 25)];
        [image sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        bgView.tag = 10+i;
        [bgView addSubview:image];
    }

    //女鞋
    ZFBrandListModel *shoesModel = _titleArray[1];
    NSArray *shoesArray = _contentArray[1];
    CGFloat shoesHeight = 45 + (shoesArray.count %4==0 ? shoesArray.count/4:shoesArray.count/4+1) *55;
     _girlShoesView = [[UIView alloc]initWithFrame:CGRectMake(0, _girlClothView.bottom, ZFScreenWidth, shoesHeight)];
    [_bgScrollView addSubview:_girlShoesView];
    UILabel *shoesTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ZFScreenWidth, 45.0)];
    shoesTitleLab.text =shoesModel.groupName;
    shoesTitleLab.textAlignment = NSTextAlignmentLeft;
    [_girlShoesView addSubview:shoesTitleLab];
    for(int i=0;i<shoesArray.count;i++){
        CGFloat x = (offX +width)  *(i%4) +offX+20;
        CGFloat y = (offY +height) *(i/4) +offY;
        ZFBrandListContentModel *model = [[ZFBrandListContentModel alloc]initWithDictionary:clothArray[i]];
        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, shoesTitleLab.bottom+y, width, height)];
        bgView.backgroundColor = ZFRGBColor(242, 242, 242);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLookMoreDetailEvent:)];
        [bgView addGestureRecognizer:tapGesture];
        [_girlShoesView addSubview:bgView];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width*0.20), (bgView.height-20)/2.0, bgView.width*0.6, 25)];
        [image sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        bgView.tag = 50+i;
        [bgView addSubview:image];
    }
    
    //美装
    ZFBrandListModel *makeUpModel = _titleArray[2];
    NSArray *makeUpArray = _contentArray[2];
    CGFloat makeUpHeight = 45 + (makeUpArray.count %4==0 ? makeUpArray.count/4:makeUpArray.count/4+1) *55;
    _beautifulMakeView = [[UIView alloc]initWithFrame:CGRectMake(0, _girlShoesView.bottom, ZFScreenWidth, makeUpHeight)];
    [_bgScrollView addSubview:_beautifulMakeView];
    UILabel *makeUpTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ZFScreenWidth, 45.0)];
    makeUpTitleLab.text =makeUpModel.groupName;
    makeUpTitleLab.textAlignment = NSTextAlignmentLeft;
    [_beautifulMakeView addSubview:makeUpTitleLab];
    for(int i=0;i<makeUpArray.count;i++){
        CGFloat x = (offX +width) *(i%4) +offX+20;
        CGFloat y = (offY +height) *(i/4) +offY;
        ZFBrandListContentModel *model = [[ZFBrandListContentModel alloc]initWithDictionary:clothArray[i]];
        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, makeUpTitleLab.bottom+y, width, height)];
        bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLookMoreDetailEvent:)];
        [bgView addGestureRecognizer:tapGesture];
        bgView.backgroundColor = ZFRGBColor(242, 242, 242);
        [_beautifulMakeView addSubview:bgView];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width*0.20), (bgView.height-20)/2.0, bgView.width*0.6, 25)];
        [image sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        bgView.tag = 60+i;
        [bgView addSubview:image];
    }

    //饰品
    ZFBrandListModel *dectorateModel = _titleArray[3];
    NSArray *dectorateUpArray = _contentArray[3];
    CGFloat dectoratUpHeight = 45 + (dectorateUpArray.count %4==0 ? dectorateUpArray.count/4:dectorateUpArray.count/4+1) *55;
    _dectorateView = [[UIView alloc]initWithFrame:CGRectMake(0, _beautifulMakeView.bottom, ZFScreenWidth, dectoratUpHeight)];
    [_bgScrollView addSubview:_dectorateView];
    UILabel *dectorateTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ZFScreenWidth, 45.0)];
    dectorateTitleLab.text =dectorateModel.groupName;
    dectorateTitleLab.textAlignment = NSTextAlignmentLeft;
    [_dectorateView addSubview:dectorateTitleLab];
    for(int i=0;i<dectorateUpArray.count;i++){
        CGFloat x = (offX +width) *(i%4)  +offX+20;
        CGFloat y = (offY +height) *(i/4) +offY;
        ZFBrandListContentModel *model = [[ZFBrandListContentModel alloc]initWithDictionary:clothArray[i]];
        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, dectorateTitleLab.bottom+y, width, height)];
        bgView.backgroundColor = ZFRGBColor(242, 242, 242);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLookMoreDetailEvent:)];
        [bgView addGestureRecognizer:tapGesture];
        [_dectorateView addSubview:bgView];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width*0.20), (bgView.height-20)/2.0, bgView.width*0.6, 25)];
        [image sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        bgView.tag = 70+i;
        [bgView addSubview:image];
    }

    //女包
    ZFBrandListModel *bagModel = _titleArray[4];
    NSArray *bagArray = _contentArray[4];
    CGFloat bagHeight = 45 + (bagArray.count %4==0 ? bagArray.count/4:bagArray.count/4+1) *55;
    _girlBagView = [[UIView alloc]initWithFrame:CGRectMake(0, _dectorateView.bottom, ZFScreenWidth, bagHeight)];
    [_bgScrollView addSubview:_girlBagView];
    UILabel *bagTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ZFScreenWidth, 45.0)];
    bagTitleLab.text =bagModel.groupName;
    bagTitleLab.textAlignment = NSTextAlignmentLeft;
    [_girlBagView addSubview:bagTitleLab];
    for(int i=0;i<bagArray.count;i++){
        CGFloat x = (offX +width)  *(i%4)  +offX+20;
        CGFloat y = (offY +height) *(i/4) +offY;
        ZFBrandListContentModel *model = [[ZFBrandListContentModel alloc]initWithDictionary:clothArray[i]];
        UIView  *bgView = [[UIView alloc]initWithFrame:CGRectMake(x, bagTitleLab.bottom+y, width, height)];
        bgView.backgroundColor = ZFRGBColor(242, 242, 242);
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLookMoreDetailEvent:)];
        [bgView addGestureRecognizer:tapGesture];
        [_girlBagView addSubview:bgView];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width*0.20), (bgView.height-20)/2.0, bgView.width*0.6, 25)];
        [image sd_setImageWithURL:[NSURL URLWithString:model.logo_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        bgView.tag = 80+i;
        [bgView addSubview:image];
    }
    _bgScrollView.contentSize = CGSizeMake(ZFScreenWidth, _girlBagView.bottom +bagHeight);

    
}

- (void)showRequestFailedView {
    if ([_bgScrollView.mj_header respondsToSelector:@selector(endRefreshing)]) {
        [_bgScrollView.mj_header endRefreshing];
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


//根据点击手势找父视图
- (void)tapLookMoreDetailEvent:(UITapGestureRecognizer *)gesture {
    UIEvent *event = [[UIEvent alloc]init];
    CGPoint location = [gesture locationInView:gesture.view];
    UIView *view = [gesture.view hitTest:location withEvent:event];
    NSInteger substractIndex;
    NSArray *accordingArray;
    if (view.tag>=10&&view.tag<50) {
        substractIndex = 10;
        accordingArray = _girlClothesrray;
    }else if (view.tag>=50&&view.tag<60){
        substractIndex = 50;
        accordingArray = _girlShoesArray;
    }else if (view.tag>=60&&view.tag<70){
        substractIndex = 60;
        accordingArray = _beautifulMakeArray;
    }else if (view.tag>=70&&view.tag<80){
        substractIndex = 70;
        accordingArray = _dectorateArray;
    }else if (view.tag>=80&&view.tag<90){
        substractIndex = 80;
        accordingArray = _girlBagArray;
    }
    ZFBrandListContentModel *model = [[ZFBrandListContentModel alloc]initWithDictionary:accordingArray[view.tag-substractIndex]];
    ZFBrandInfoViewController *infoVC = [[ZFBrandInfoViewController alloc]init];
    infoVC.model = model;
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
