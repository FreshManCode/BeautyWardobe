//
//  ZFBaseAdsView.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBaseAdsView.h"
#import "ZFHeadADsModel.h"
#import <UIImageView+WebCache.h>
#import "NetwokeManager.h"
#import "ZFHeadADsInfoViewController.h"
#import <Masonry.h>
#import "ZHHomeListModel.h"
#import <MJRefresh.h>
@interface ZFBaseAdsView ()<UIScrollViewDelegate>

{
    NSInteger       _pageNum;
    NSInteger       _currentPage;
    
    
    NSMutableArray *_homeBaseModelArray;
    NSMutableArray *_onePictureModelArray;
    NSMutableArray *_worthBuyArray;
    
    NSMutableArray *_titleArray;
    NSMutableArray *_hotMarketLeftArray;
    NSMutableArray *_hotMarketRightArray;
    NSMutableArray *_hotMarketArray;
    NSMutableArray *_necessaryGoodsArray;
    NSMutableArray *_productListArray;
    NSMutableArray *_newHotMarketArray;

}

@property (nonatomic,strong) ZHHomeListModel *onePicturemodel;
@property (nonatomic,strong) ZFHomeListModelTypeOne *typeModel;
@property (nonatomic,strong) ZFHomeContentModel *leftContentModel;
@property (nonatomic,strong) ZHHomeListModel *necessaryGoodsLeftModel;


@end

@implementation ZFBaseAdsView

- (id)initWithFrame:(CGRect)frame modelArray:(NSArray *)array {
    if (self = [super initWithFrame:frame]) {
        _imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        [self setUpHeadScrollView];
        [self performSelector:@selector(requestLoopPictures) withObject:nil afterDelay:0];
        [self performSelector:@selector(requestHomeListModel) withObject:nil afterDelay:0.1];

    }
    return self;
}

- (void)requestLoopPictures {
    NSString *url = @"http://vapi.yuike.com/1.0/client/banner_list.php?mid=457465&sid=bbb095063d1f35021909311e33623246&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220";
    [NetwokeManager requestGetMethodURL:url parameters:nil uploadPreogerss:nil success:^(id data) {
        if ([data isKindOfClass:[NSDictionary class]]){
            [self hanleWithJsonResult:data];
        }else {
            //请求失败
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"错误的原因为:%@",error);
    }];

}

- (void)setUpHeadScrollView {
    if (!_adScrollView) {
        _adScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width, 364/2.0)];
        _adScrollView.backgroundColor = [UIColor clearColor];
        _adScrollView.delegate = self;
        _adScrollView.showsHorizontalScrollIndicator = NO;
        _adScrollView.showsVerticalScrollIndicator = NO;
        _adScrollView.pagingEnabled = YES;
        //设置弹簧效果
        _adScrollView.bounces = YES;
        _adScrollView.contentSize = CGSizeMake(self.width*6, 364/2.0);
    }
    [self addSubview:_adScrollView];
}


- (void)hanleWithJsonResult:(NSDictionary *)dic {
    for (NSDictionary *dic1 in dic[@"data"] ) {
        ZFHeadADsModel *model = [[ZFHeadADsModel alloc]initWithDictionary:dic1];
        [_imageArray addObject:model];
    }
   
    for (int i=0;i<_imageArray.count;i++ ) {
        ZFHeadADsModel *model = _imageArray[i];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(self.width*i, 0, self.width, 364/2.0)];
        image.userInteractionEnabled = YES;
        image.tag = 100+i;
        [image sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholder"]];
        [_adScrollView addSubview:image];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookAdInfo:)];
        [image addGestureRecognizer:tapGesture];
        
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_adScrollView.frame)-20, self.width, 0.5)];
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.currentPage = 0;
        //       没选中的颜色
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        //        选中的颜色
        _pageControl.currentPageIndicatorTintColor = ZFRGBColor(255, 69, 125);
    }
    [self addSubview:_pageControl];

}

- (void)initHomeListModelView {
    //四个按钮
    if (!_fourLogoView) {

        _fourLogoView = [[UIView alloc]initWithFrame:CGRectMake(0, 364/2.0, ZFScreenWidth, ZFScreenWidth/4.0+32-25)];
        _fourLogoView.backgroundColor = [UIColor whiteColor];
    }
    [self addSubview:_fourLogoView];
    NSArray *titleArray = [NSArray arrayWithObjects:@"品牌排行",@"摇一摇",@"签到",@"公众号" ,nil];
    NSArray *imageArray = [NSArray arrayWithObjects:@"home_page_brand",@"home_page_shake",@"home_page_sign1",@"home_page_wx" ,nil];
    CGFloat width  = ZFScreenWidth/4.0;
    CGFloat offSet = 35;
    for (int i=0;i<4;i++) {
        _logoBtn = [[UIButton alloc]initWithFrame:CGRectMake(offSet +i*width-10, 5, width-offSet, width-offSet)];
        _logoBtn.backgroundColor = [UIColor whiteColor];
        [_logoBtn addTarget:self action:@selector(clickLookInfoEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_logoBtn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        _logoBtn.tag = 100+i;
        _logoBtn.layer.cornerRadius = (width-offSet)/2.0;
        [_logoBtn clipsToBounds];
        [_fourLogoView addSubview:_logoBtn];
        _logoLab = [UILabel new];
        _logoLab.text = titleArray[i];
        _logoLab.font = [UIFont systemFontOfSize:(ZF_IS_IPHONE4OR5?14:16)];
        [_fourLogoView addSubview:_logoLab];
        [_logoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_logoBtn);
            make.top.equalTo(_logoBtn).offset(_logoBtn.height +5);
            make.height.mas_equalTo(17);
        }];
    }
    
    //就显示一张图片的(和热门市场,必买清单,跳转的详情界面是一样的)
    //仅仅只有一张图片的(值得买,每日推荐)
    ZFHomeListBaseModel *model = _homeBaseModelArray[0];
    _onePicturemodel = [[ZHHomeListModel alloc]initWithDictionary:model.content_data];
    if (!_onlyOnePicrureView) {
        _onlyOnePicrureView = [[UIView alloc]initWithFrame:CGRectMake(0, _fourLogoView.bottom+10, ZFScreenWidth, 215/2.0)];
        _onlyOnePicrureView.backgroundColor = [UIColor clearColor];
    }
    [self addSubview:_onlyOnePicrureView];
    
    if (!_picture) {
        _picture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _onlyOnePicrureView.width, _onlyOnePicrureView.height)];
        _picture.userInteractionEnabled = YES;
        if ([_onePicturemodel.pic_url length]>0) {
            [_picture sd_setImageWithURL:[NSURL URLWithString:_onePicturemodel.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholder"]];
            _picture.tag = 200;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToBrandListViewController:)];
            [_picture addGestureRecognizer:tapGesture];
        }
        
    }
    [_onlyOnePicrureView addSubview:_picture];

    //值得买
    if (!_worhBuyView) {
        _worhBuyView = [[UIView alloc]initWithFrame:CGRectMake(0, _onlyOnePicrureView.bottom, ZFScreenWidth, 180+35)];
        _worhBuyView.backgroundColor = [UIColor whiteColor];
    }
    [self addSubview:_worhBuyView];
    
    if (!_worthHeadView) {
        _worthHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 35.0)];
        _worthHeadView.backgroundColor = ZFRGBColor(242, 242, 242);
    }
    [_worhBuyView addSubview:_worthHeadView];
    
    if (_titleArray.count >0) {
        ZFHomeListModelTypeOne *worthTitleModel = _titleArray[0];
        if (!_worthHeadTitle) {
            _worthHeadTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
            _worthHeadTitle.textAlignment = NSTextAlignmentLeft;
            _worthHeadTitle.text = worthTitleModel.title;
        }
        [_worthHeadView addSubview:_worthHeadTitle];
        
        if (!_worthHeadSubtitle) {
            _worthHeadSubtitle = [[UILabel alloc]initWithFrame:CGRectMake(_worthHeadTitle.right, 0, 100, 30)];
            _worthHeadSubtitle.textAlignment = NSTextAlignmentLeft;
            _worthHeadSubtitle.font = [UIFont systemFontOfSize:14.0f];
            _worthHeadSubtitle.textColor = [UIColor lightGrayColor];
            _worthHeadSubtitle.text = worthTitleModel.sub_title;
            
        }
        [_worthHeadView addSubview:_worthHeadSubtitle];
        
        if (!_worthLeftImage) {
            _worthLeftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, _worthHeadView.bottom, ZFScreenWidth/2.0-3, 90)];
            _worthLeftImage.backgroundColor = [UIColor clearColor];
            _worthLeftImage.userInteractionEnabled = YES;
            [_worthLeftImage sd_setImageWithURL:[NSURL URLWithString:_leftContentModel.taobao_pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
            _worthLeftImage.tag = 1005;
        }
        [_worhBuyView addSubview:_worthLeftImage];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pictureClickIndex:)];
        [_worthLeftImage addGestureRecognizer:tapGesture];

    }
    
    
    if (_leftContentModel.taobao_pic_url) {
        UIView *horView = [[UIView alloc]initWithFrame:CGRectMake(_worthLeftImage.right, _worthHeadView.bottom, 1.0, 180)];
        horView.backgroundColor = ZFRGBColor(242, 242, 242);
        [_worhBuyView addSubview:horView];
    }
    
    
    if (!_worthLeftDesLab) {
        _worthLeftDesLab = [[UILabel alloc]initWithFrame:CGRectMake(10, _worthLeftImage.bottom+15, ZFScreenWidth/2.0-10-5, 30)];
        _worthLeftDesLab.font = [UIFont systemFontOfSize:12.0f];
        _worthLeftDesLab.text =_leftContentModel.taobao_title;
        _worthLeftDesLab.numberOfLines = 0;
        
    }
    [_worhBuyView addSubview:_worthLeftDesLab];
    
    if (!_wordthLeftPriceLab) {
        _wordthLeftPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(35, _worthLeftDesLab.bottom+12, 55, 14.0)];
        _wordthLeftPriceLab.textColor = ZFRGBColor(255, 69, 125);
        _wordthLeftPriceLab.font = [UIFont systemFontOfSize:13.0f];
        if ([_leftContentModel.taobao_selling_price length]>0) {
            _wordthLeftPriceLab.text = [NSString stringWithFormat:@"%@%@",_leftContentModel.taobao_selling_price,_leftContentModel.money_symbol];
        }
    }
    [_worhBuyView addSubview:_wordthLeftPriceLab];
    
    for (int i=0;i<2;i++){
         ZFHomeContentModel *worthRightModel = _worthBuyArray[i];
         _rightView = [[UIView alloc]initWithFrame:CGRectMake(_worthLeftImage.right+1, _worthHeadView.bottom+(i*90), (ZFScreenWidth-3)/2.0, 89)];
        _rightView.backgroundColor = [UIColor clearColor];
        _rightView.tag = 1006+i;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pictureClickIndex:)];
        [_rightView addGestureRecognizer:tapGesture];
        //分割线(右边两个产品之间的横向分割线)
        if (worthRightModel.taobao_pic_url) {
            UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(_worthLeftImage.right+1, _worthHeadView.bottom+(i*90), _rightView.width, 1.0)];
            verticalLine.backgroundColor = ZFRGBColor(242, 242, 242);
            [_worhBuyView addSubview:verticalLine];
        }
        [_worhBuyView addSubview:_rightView];
        
        _rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(18, 11, 95/2.0, 70)];
         _rightImage.tag = 1006 +i;
        [_rightImage sd_setImageWithURL:[NSURL URLWithString:worthRightModel.taobao_pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
         [_rightView addSubview:_rightImage];
        

        _rightDesLab = [[UILabel alloc]initWithFrame:CGRectMake(_rightImage.right+15, _rightImage.top+10, _rightView.width-_rightImage.right-15-5, 30)];
        _rightDesLab.numberOfLines = 0;
        _rightDesLab.textAlignment = NSTextAlignmentLeft;
        _rightDesLab.font = [UIFont systemFontOfSize:12.0];
        _rightDesLab.text = worthRightModel.taobao_title;
        [_rightView addSubview:_rightDesLab];
        
        _rightOriginalPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(_rightDesLab.left, _rightDesLab.bottom+5, 65, 13.0)];
        _rightOriginalPriceLab.font = [UIFont systemFontOfSize:13.0f];
        _rightOriginalPriceLab.textColor = [UIColor lightGrayColor];
        _rightOriginalPriceLab.textAlignment = NSTextAlignmentLeft;
        _rightOriginalPriceLab.text = worthRightModel.taobao_price;
        CGSize size = [ZFPublic sizeWithString:_rightOriginalPriceLab.text font:[UIFont systemFontOfSize:12.0] maxSize:CGSizeMake(65, 13.0)];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_rightOriginalPriceLab.left, _rightOriginalPriceLab.bottom-_rightOriginalPriceLab.height/2.0, size.width, 1.50)];
        lineView.backgroundColor = _rightOriginalPriceLab.textColor;
        [_rightView addSubview:lineView];

        [_rightView addSubview:_rightOriginalPriceLab];
        
        _rightCurrentPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(_rightOriginalPriceLab.left, _rightOriginalPriceLab.bottom+5, 65, 13.0)];
        _rightCurrentPriceLab.textColor = ZFRGBColor(255, 69, 125);
        _rightCurrentPriceLab.font = [UIFont systemFontOfSize:13.0f];
        _rightCurrentPriceLab.textAlignment = NSTextAlignmentLeft;
        _rightCurrentPriceLab.text = worthRightModel.taobao_selling_price;
        [_rightView addSubview:_rightCurrentPriceLab];
    }
    
    //热门市场
    if (_titleArray.count >0) {
        ZFHomeListModelTypeOne *hotTitleModel = _titleArray[1];
        for(NSDictionary *dic  in hotTitleModel.left_part){
            ZHHomeListModel *leftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
            [_hotMarketLeftArray addObject:leftModel];
        }
        for(NSDictionary *dic  in hotTitleModel.right_part){
            ZHHomeListModel *rightModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
            [_hotMarketRightArray addObject:rightModel];
        }
        
        //对里面的model重新排序
        _newHotMarketArray = [[NSMutableArray alloc]initWithCapacity:0];
        if(_hotMarketLeftArray.count>0&&_hotMarketRightArray.count>0){
            [_newHotMarketArray addObject:_hotMarketLeftArray[0]];
            [_newHotMarketArray addObject:_hotMarketRightArray[0]];
            [_newHotMarketArray addObject:_hotMarketLeftArray[1]];
            [_newHotMarketArray addObject:_hotMarketRightArray[1]];
        }
        
        if (!_hotMarketView) {
            _hotMarketView = [[UIView alloc]initWithFrame:CGRectMake(0, _worhBuyView.bottom, ZFScreenWidth, 135)];
            _hotMarketView.backgroundColor = [UIColor clearColor];
        }
        [self addSubview:_hotMarketView];
        _hotHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 35.0)];
        _hotHeadView.backgroundColor = ZFRGBColor(242, 242, 242);
        [_hotMarketView addSubview:_hotHeadView];
        _hotViewTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 35.0)];
        _hotViewTitle.text = hotTitleModel.title;
        _rightOriginalPriceLab.textAlignment = NSTextAlignmentLeft;
        [_hotHeadView addSubview:_hotViewTitle];
        _hotSubTitle = [[UILabel alloc]initWithFrame:CGRectMake(_hotViewTitle.right, 0, 100, 35.0)];
        _hotSubTitle.textAlignment = NSTextAlignmentLeft;
        _hotSubTitle.text = hotTitleModel.sub_title;
        _hotSubTitle.font = [UIFont systemFontOfSize:14.0f];
        _hotSubTitle.textColor = [UIColor lightGrayColor];
        [_hotHeadView addSubview:_hotSubTitle];
        
        CGFloat width1  = (ZFScreenWidth-3)/2.0;
        CGFloat height = 50;
        CGFloat offX   = 1;
        CGFloat offY   = 1;
        for (int i=0;i<4;i++){
            CGFloat x = (width1 +offX) *(i%2) +offX ;
            CGFloat y = (height +offY) *(i/2) +offY +_hotHeadView.bottom;
            _hotImage = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width1, height)];
            _hotImage.tag = 50+i;
            _hotImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToBrandListViewController:)];
            [_hotImage addGestureRecognizer:tapGesture];
            
            if ([_newHotMarketArray count]>0) {
                ZHHomeListModel *model = _newHotMarketArray[i];
                if ([model.pic_url length]>0 ) {
                    [_hotImage sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
                }
                [_hotMarketView addSubview:_hotImage];
            }
        }

    }
    //必买清单
    if (_titleArray.count >0) {
        ZFHomeListModelTypeOne *necessaryModel = _titleArray[2];
        for (NSDictionary *dic in necessaryModel.left_part){
            _necessaryGoodsLeftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
        }
        
        for (NSDictionary *dic in necessaryModel.right_part){
            ZHHomeListModel *leftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
            [_necessaryGoodsArray addObject:leftModel];
        }
        
        if (!_necessaryBuyView) {
            _necessaryBuyView = [[UIView alloc]initWithFrame:CGRectMake(0, _hotMarketView.bottom, ZFScreenWidth, 387/2.0+35+45)];
            _necessaryBuyView.backgroundColor = [UIColor clearColor];
        }
        [self addSubview:_necessaryBuyView];
        if (!_neceHeadView) {
            _neceHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ZFScreenWidth, 35.0)];
        }
        [_necessaryBuyView addSubview:_neceHeadView];
        
        _neceTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 35.0)];
        _neceTitleLab.text = necessaryModel.title;
        _neceTitleLab.textAlignment = NSTextAlignmentLeft;
        [_neceHeadView addSubview:_neceTitleLab];
        
        _neceSubtitleLab = [[UILabel alloc]initWithFrame:CGRectMake(_neceTitleLab.right, 0, 100, 35.0)];
        _neceSubtitleLab.text = necessaryModel.sub_title;
        _neceSubtitleLab.textColor = [UIColor lightGrayColor];
        _neceSubtitleLab.font = [UIFont systemFontOfSize:13.0f];
        [_neceHeadView addSubview:_neceSubtitleLab];
        
        if (!_neceLeftImage) {
            _neceLeftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, _neceHeadView.bottom+1, ZFScreenWidth/2.0-3, 387/2.0)];
            _neceLeftImage.tag = 55;
            _neceLeftImage.userInteractionEnabled = YES;
            [_neceLeftImage sd_setImageWithURL:[NSURL URLWithString:_necessaryGoodsLeftModel.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToBrandListViewController:)];
            [_neceLeftImage addGestureRecognizer:tapGesture];
            
        }
        [_necessaryBuyView addSubview:_neceLeftImage];
        
        for (int i=0;i<2;i++ ){
            _neceRightImage = [[UIImageView alloc]initWithFrame:CGRectMake(_neceLeftImage.right+1, i*(195/2.0)+1+_neceHeadView.bottom, ZFScreenWidth/2.0-3, 195/2.0-1)];
            _neceRightImage.tag = 56+i;
            _neceRightImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToBrandListViewController:)];
            [_neceRightImage addGestureRecognizer:tapGesture];
            ZHHomeListModel *neceModel = _necessaryGoodsArray[i];
            if ([neceModel.pic_url length]>0) {
                [_neceRightImage sd_setImageWithURL:[NSURL URLWithString:neceModel.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
            }
            [_necessaryBuyView addSubview:_neceRightImage];
        }
        
        
        if (!_hotGoodsHeadView) {
            _hotGoodsHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, _neceLeftImage.bottom, ZFScreenWidth, 45.0)];
            _hotGoodsHeadView.backgroundColor = ZFRGBColor(242, 242, 242);
        }
        [_necessaryBuyView addSubview:_hotGoodsHeadView];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 45.0)];
        titleLab.text = @"热门商品";
        titleLab.textAlignment = NSTextAlignmentLeft;
        [_hotGoodsHeadView addSubview:titleLab];
    }
    
}



- (void)requestHomeListModel {
    NSString *addURL  = @"mid=457465&sid=4e6c75c48668a635a9af8cd161febc9b&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5116220";
    NSString *action  =@"home/model_list.php?";
    NSString *baseURL = [NSString stringWithFormat:@"%@/1.0/%@%@",ZFBaseURL,action,addURL];
    [NetwokeManager requestGetMethodURL:baseURL parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data) {
            if ([data isKindOfClass:[NSDictionary class]]&& [data[@"msg"] isEqualToString:@"ok"]) {
                [self hanleWithModelListJsonResult:data];
                //有数据返回才开始创建
                [self initHomeListModelView];
                if (_delegate &&[_delegate respondsToSelector:@selector(endRefreshWithResult:)]){
                    [_delegate endRefreshWithResult:data];
                }
            }else {
                //加载无内容
            }
        }
    } failure:^(NSError *error) {
        ZFDEBUGLOG(@"错误信息为:%@",error);
    }];

}

- (void)hanleWithModelListJsonResult:(NSDictionary *)dic {
    _homeBaseModelArray   = [[NSMutableArray alloc]initWithCapacity:0];
    _worthBuyArray        = [[NSMutableArray alloc]initWithCapacity:0];
    //包含标题和子标题的数组
    _titleArray           = [[NSMutableArray alloc]initWithCapacity:0];
    _hotMarketLeftArray   = [[NSMutableArray alloc]initWithCapacity:0];
    _hotMarketRightArray  = [[NSMutableArray alloc]initWithCapacity:0];
    _hotMarketArray       = [[NSMutableArray alloc]initWithCapacity:0];
    _necessaryGoodsArray  = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary * tempDic in dic[@"data"] ) {
        ZFHomeListBaseModel *model = [[ZFHomeListBaseModel alloc]initWithDictionary:tempDic];
        [_homeBaseModelArray addObject:model];
    }
    
    //左边一张,右边两张图片
    ZFHomeListBaseModel *modelTwo = _homeBaseModelArray[1];
    //ZFHomeListModelTypeOne 含有标题子标题
    for (int i=1;i<4;i++){
        if (_homeBaseModelArray.count < i) {
            ZFHomeListBaseModel *testModel = _homeBaseModelArray[i];
            ZFHomeListModelTypeOne *titleModel = [[ZFHomeListModelTypeOne alloc]initWithDictionary:testModel.content_data];
            [_titleArray addObject:titleModel];
        }
    }
    _typeModel = [[ZFHomeListModelTypeOne alloc]initWithDictionary:modelTwo.content_data];
    //ZFHomeContentModel 包含三种不同的cell中的价格,过期价格,现在价格自己描述,图片等
    for(NSDictionary *dic in _typeModel.left_part) {
        _leftContentModel = [[ZFHomeContentModel alloc]initWithDictionary:dic];
    }
    for (NSDictionary *dic in _typeModel.right_part){
        ZFHomeContentModel *modelOne = [[ZFHomeContentModel alloc]initWithDictionary:dic];
        [_worthBuyArray addObject:modelOne];
    }
    if (_titleArray.count >0) {
        ZFHomeListModelTypeOne *hotModelTemp = _titleArray[1];
        for(NSDictionary *dic  in hotModelTemp.left_part){
            ZHHomeListModel *leftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
            [_hotMarketLeftArray addObject:leftModel];
        }
        for(NSDictionary *dic  in hotModelTemp.right_part){
            ZHHomeListModel *leftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
            [_hotMarketRightArray addObject:leftModel];
        }
        
        ZFHomeListModelTypeOne *necessaryModel = _titleArray[2];
        for (NSDictionary *dic in necessaryModel.left_part){
            _necessaryGoodsLeftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
        }
        for (NSDictionary *dic in necessaryModel.right_part){
            ZHHomeListModel *leftModel = [[ZHHomeListModel alloc]initWithDictionary:dic];
            [_necessaryGoodsArray addObject:leftModel];
        }

    }

}



-(void)timeAction:(NSTimer *)timer
{
    if(_imageArray.count >1){
        CGPoint newOffset = _adScrollView.contentOffset;
        newOffset.x = newOffset.x+CGRectGetWidth(_adScrollView.frame);
        if(newOffset.x>(CGRectGetWidth(_adScrollView.frame)*(_imageArray.count-1))){
            newOffset.x =0;
        }
        //  当前是第几个视图
        int index = newOffset.x/CGRectGetWidth(_adScrollView.frame);
        newOffset.x =index*CGRectGetWidth(_adScrollView.frame);
        [_adScrollView setContentOffset:newOffset animated:YES];
    }else{//关闭定时器
        [self invaliteTimer];
//        [_timer setFireDate:[NSDate distantPast]];
    }
}


//滚动就会执行(会多次)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
    _pageControl.currentPage = index;
}

//打开定时器
- (void)openTimerFire{
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)invaliteTimer{
    //   关闭定时器
    [_timer setFireDate:[NSDate distantFuture]];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_imageArray.count==0) {
        return;
    }
    CGRect visiableRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.frame.size.width, scrollView.frame.size.height);
    NSInteger currentIndex = 0;
    for(UIView *subview in scrollView.subviews){
        if ([subview isKindOfClass:[UIImageView class]]) {
            if ((CGRectContainsRect(visiableRect, subview.frame))) {
                currentIndex = subview.tag -100;
                break;
            }
        }
    }
    _pageControl.currentPage = currentIndex;
    
    
}

#pragma mark------轮播图的点击
- (void)lookAdInfo:(UITapGestureRecognizer *)sender{
    [self invaliteTimer];
    ZFHeadADsModel *model = _imageArray[_pageControl.currentPage];
    NSArray *array = [model.url componentsSeparatedByString:@"activity_type="];
    if ([[array lastObject] isEqualToString:@"6"]) {
        if (_delegate &&[_delegate respondsToSelector:@selector(clickCurrentIndex:)]) {
            [_delegate clickCurrentIndex:500];
        }
    }else{
        if (_delegate &&[_delegate respondsToSelector:@selector(clickCurrentIndex:)]) {
            [_delegate clickCurrentIndex:_pageControl.currentPage];
        }
    }
}

#pragma mark---品牌排行,摇一摇,签到,公众号的点击
- (void)clickLookInfoEvent:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(getCurrentClickButtonTag:)]) {
        [_delegate getCurrentClickButtonTag:sender.tag];
    }
}


#pragma mark------点击手势
- (void)pictureClickIndex:(UITapGestureRecognizer *)gesture {
    UIEvent *event = [[UIEvent alloc]init];
    CGPoint location = [gesture locationInView:gesture.view];
    UIView  *view = [gesture.view hitTest:location withEvent:event];
    ZFHomeContentModel *model ;
    if (view.tag==1005) {
        model = _leftContentModel;
    }else if(view.tag==1006||view.tag==1007) {
        model = _worthBuyArray[view.tag-1006];
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(didClickPicturesIndex:withModel:)]) {
        [_delegate didClickPicturesIndex:view.tag withModel:model];
    }
}

#pragma (一张图片,热门市场,必买清单)点击手势
- (void)ToBrandListViewController:(UITapGestureRecognizer *)gesture {
    //一张图片:200
    //热门市场:50,51,52,53(从左至右)
    //必买清单:55,56,57
    UIEvent *event = [[UIEvent alloc]init];
    CGPoint location = [gesture locationInView:gesture.view];
    UIView *view = [gesture.view hitTest:location withEvent:event];
    ZHHomeListModel *listModel;
    NSInteger tag = view.tag;
    if (tag==200) {
        listModel = _onePicturemodel;
    }else if (tag>=50&&tag<=53){
        listModel = _newHotMarketArray[view.tag-50];
    }else if (tag==55){
        listModel = _necessaryGoodsLeftModel;
    }else if (tag==56||tag==57){
        listModel = _necessaryGoodsArray[view.tag-56];
    }
    if (_delegate &&[_delegate respondsToSelector:@selector(didClickIndex:toBrandListViewControlerWithModel:)]) {
        [_delegate didClickIndex:tag toBrandListViewControlerWithModel:listModel];
    }
    
}




//这是解决手势滑动和定时器滑动冲突的重要方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (_timer &&_timer.isValid) {
        [self invaliteTimer];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    CGRect visiableRect = CGRectMake(scrollView.contentOffset.x, scrollView.contentOffset.y, scrollView.width, scrollView.height);
    NSInteger currentIndex = 0;
    for(UIImageView *imageView in scrollView.subviews ){
        if ([imageView isKindOfClass:[UIImageView class]]) {
            if (CGRectContainsRect(visiableRect, imageView.frame)) {
                currentIndex = imageView.tag -100;
                break;
            }
        }
    }
    _pageControl.currentPage = currentIndex;
}

- (void)dealloc {
    [self invaliteTimer];
    ZFDEBUGLOG(@"当前的定时器是不是存在%@",_timer);
}


@end
