//
//  ZFHeadADsProductModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/29.
//  Copyright © 2016年 KingNet. All rights reserved.
//  头部的广告栏,点击后,下面的collectionview的model

#import <Foundation/Foundation.h>

@interface ZFHeadADsProductModel : NSObject

@property (nonatomic,copy) NSString *taobao_num_iid;
@property (nonatomic,copy) NSString *taobao_title;
@property (nonatomic,copy) NSString *taobao_prices;
@property (nonatomic,copy) NSString *taobao_promo_price;
@property (nonatomic,copy) NSString *taobao_selling_price;
@property (nonatomic,copy) NSString *money_symbol;
@property (nonatomic,copy) NSString *integral;
@property (nonatomic,copy) NSString *taobao_url;
@property (nonatomic,copy) NSString *mobile_cps_url;
@property (nonatomic,copy) NSString *pc_cps_url;
@property (nonatomic,copy) NSString *tag_type;
@property (nonatomic,copy) NSString *tag_url;
@property (nonatomic,copy) NSString *taobao_delist_time;
@property (nonatomic,copy) NSString *taobao_pic_url;
@property (nonatomic,strong) NSArray *taobao_item_imgs;
@property (nonatomic,copy) NSString *taobao_volume;
@property (nonatomic,copy) NSString *visits_count;
@property (nonatomic,copy) NSString *comments_count;
@property (nonatomic,copy) NSString *likes_count;
@property (nonatomic,copy) NSString *share_count;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *is_deleist;
@property (nonatomic,copy) NSString *discount;
@property (nonatomic,copy) NSString *quality_score;
@property (nonatomic,copy) NSString *price_score;
@property (nonatomic,copy) NSString *conform_score;
@property (nonatomic,copy) NSString *synthesis_score;
@property (nonatomic,strong) NSArray *merchant;
@property (nonatomic,strong) NSArray *brand;
@property (nonatomic,copy) NSString *from_title;
@property (nonatomic,copy) NSString *from_logo_url;
@property (nonatomic,copy) NSString *from_type;



- (id)initWithDictionary:(NSDictionary *)dic;

@end


@interface ZFMyItemModel : ZFHeadADsProductModel
@property (nonatomic,assign) BOOL is_like;
@property (nonatomic,copy)   NSString *addded_time;
@property (nonatomic,assign) NSArray *current_lottery;

- (id)initWithDictionary:(NSDictionary *)dic;

@end

