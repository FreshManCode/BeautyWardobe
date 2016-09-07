//
//  ZFBaseAdsView.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFHomeContentModel;

@class ZFBaseAdsView;
@class ZHHomeListModel;

@protocol ZFBaseAdsViewDelegate <NSObject>
- (void)clickCurrentIndex:(NSInteger)index;
- (void)endRefreshWithResult:(NSDictionary *)dic;
- (void)getCurrentClickButtonTag:(NSInteger)tag;
- (void)didClickPicturesIndex:(NSInteger)tag withModel:(ZFHomeContentModel *)contentModel;
- (void)didClickIndex:(NSInteger)tag toBrandListViewControlerWithModel:(ZHHomeListModel *)listModel;
@optional

@end


@interface ZFBaseAdsView : UIView
@property (nonatomic,strong) UIScrollView *adScrollView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) id<ZFBaseAdsViewDelegate>delegate;


//品牌排行,摇一摇,签到,公众号
@property (nonatomic,strong) UIView   *fourLogoView;
@property (nonatomic,strong) UIButton *logoBtn;
@property (nonatomic,strong) UILabel  *logoLab;
//只有一张图
@property (nonatomic,strong) UIView *onlyOnePicrureView;
@property (nonatomic,strong) UIImageView *picture;
//值得买,每日推荐
@property (nonatomic,strong) UIView  *worhBuyView;
@property (nonatomic,strong) UIView  *worthHeadView;
@property (nonatomic,strong) UILabel *worthHeadTitle;
@property (nonatomic,strong) UILabel *worthHeadSubtitle;
@property (nonatomic,strong) UIImageView *worthLeftImage;
@property (nonatomic,strong) UILabel *worthLeftDesLab;
@property (nonatomic,strong) UILabel *wordthLeftPriceLab;

@property (nonatomic,strong) UIView  *rightView;
@property (nonatomic,strong) UIImageView *rightImage;
@property (nonatomic,strong) UILabel *rightDesLab;
@property (nonatomic,strong) UILabel *rightOriginalPriceLab;
@property (nonatomic,strong) UILabel *rightCurrentPriceLab;


//热门市场,品牌精选
@property (nonatomic,strong) UIView *hotMarketView;
@property (nonatomic,strong) UIView *hotHeadView;
@property (nonatomic,strong) UILabel *hotSubTitle;
@property (nonatomic,strong) UILabel *hotViewTitle;
@property (nonatomic,strong) UIImageView *hotImage;


//必买清单 都帮你整理好了
@property (nonatomic,strong) UIView  *necessaryBuyView;
@property (nonatomic,strong) UIView  *neceHeadView;
@property (nonatomic,strong) UILabel *neceTitleLab;
@property (nonatomic,strong) UIImageView *neceLeftImage;
@property (nonatomic,strong) UIImageView *neceRightImage;
@property (nonatomic,strong) UILabel *neceSubtitleLab;
@property (nonatomic,strong) UIView  *hotGoodsHeadView;


- (void)requestHomeListModel;
- (id)initWithFrame:(CGRect)frame modelArray:(NSArray *)array;

- (void)openTimerFire;
- (void)invaliteTimer;





@end
