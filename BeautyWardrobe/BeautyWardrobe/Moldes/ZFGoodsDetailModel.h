//
//  ZFGoodsDetailModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFGoodsDetailModel : NSObject

@property (nonatomic,copy) NSString *taobao_num_iid;
@property (nonatomic,copy) NSString *taobao_title;
@property (nonatomic,copy) NSString *taobao_subtitle;
@property (nonatomic,copy) NSString *taobao_price;
@property (nonatomic,copy) NSString *taobao_promo_price;
@property (nonatomic,copy) NSString *taobao_selling_price;
@property (nonatomic,copy) NSString *money_symbol;
@property (nonatomic,copy) NSString *intergral;
@property (nonatomic,copy) NSString *taobao_url;
@property (nonatomic,copy) NSString *mobile_cps_url;
@property (nonatomic,copy) NSString *pc_cps_url;
@property (nonatomic,copy) NSString *tag_type;
@property (nonatomic,strong) NSArray *mobile_desc;
@property (nonatomic,copy) NSString *taobao_delist_time;
@property (nonatomic,copy) NSString *taobao_pic_url;
@property (nonatomic,strong) NSArray *taobao_item_imgs;
@property (nonatomic,strong) NSArray *props_name;
@property (nonatomic,copy) NSString *size_table;
@property (nonatomic,copy) NSString *taobao_volume;
@property (nonatomic,copy) NSString *freight_id;
@property (nonatomic,copy) NSString *is_custom_commision;
@property (nonatomic,copy) NSString *one_commision;
@property (nonatomic,copy) NSString *two_commision;
@property (nonatomic,copy) NSString *three_commision;
@property (nonatomic,copy) NSString *visits_count;
@property (nonatomic,copy) NSString *comments_counts;
@property (nonatomic,copy) NSString *likes_count;
@property (nonatomic,copy) NSString *shares_count;
@property (nonatomic,copy) NSString *last_lottery_id;
@property (nonatomic,copy) NSString *lottery_id;
@property (nonatomic,copy) NSString *lottery_show_prizes_count;
@property (nonatomic,copy) NSString *quality_score;
@property (nonatomic,copy) NSString *price_score;
@property (nonatomic,copy) NSString *conform_score;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,strong) NSArray *skus;
@property (nonatomic,copy) NSString *is_can_use_coupon;
@property (nonatomic,copy) NSString *is_delist;
@property (nonatomic,copy) NSString *discount;
@property (nonatomic,copy) NSString *synthsis_score;
@property (nonatomic,strong) NSDictionary *merchant;
@property (nonatomic,strong) NSDictionary *brand;
@property (nonatomic,copy) NSString *from_title;
@property (nonatomic,copy) NSString *from_logo_url;
@property (nonatomic,copy) NSString *from_type;
@property (nonatomic,strong) NSArray *service;
@property (nonatomic,copy) NSString *last_lottery;
@property (nonatomic,strong) NSArray *current_lottery;
@property (nonatomic,copy) NSString *commission_fee;
@property (nonatomic,strong) NSArray *promos;

- (id)initWithDictionary:(NSDictionary *)dic;

@end


@interface ZFGoodsDetailHeadImageModel : NSObject

@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,copy) NSString *position;
@property (nonatomic,copy) NSString *url;
- (id)initWithDictionary:(NSDictionary *)dic;

@end


@interface ZFGoodsServiceModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *pic_url;
- (id)initWithDictionary:(NSDictionary *)dic;

@end


@interface ZFGoodsPropsNameModel : NSObject
@property (nonatomic,copy) NSString *pname;
@property (nonatomic,copy) NSString *vname;
- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFGoodsMobileDescModel : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *content_type;
- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFGoodsBrandModel : NSObject
@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,copy) NSString *titile;
@property (nonatomic,copy) NSString *logo_url;
@property (nonatomic,copy) NSString *bind_user_id;

- (id)initWithDictionary:(NSDictionary *)dic;

@end


