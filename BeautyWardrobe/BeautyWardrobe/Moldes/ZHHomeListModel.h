//
//  ZHHomeListModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/4.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZFHomeListBaseModel : NSObject

@property (nonatomic,copy) NSString *content_type;
@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,strong) NSDictionary *content_data;
- (id)initWithDictionary:(NSDictionary *)dic;

@end


@interface ZHHomeListModel : NSObject

@property (nonatomic,copy) NSString *action;
@property (nonatomic,copy) NSString *pic_url;

- (id)initWithDictionary:(NSDictionary *)dic;
@end


@interface ZFHomeListModelTypeOne : NSObject
@property (nonatomic,strong) NSArray *left_part;
@property (nonatomic,strong) NSArray *right_part;

@property (nonatomic,copy) NSString *sub_title;
@property (nonatomic,copy) NSString *title;


- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFHomeContentModel : NSObject
@property (nonatomic,copy) NSString *taobao_num_iid;
@property (nonatomic,copy) NSString *taobao_title;
@property (nonatomic,copy) NSString *taobao_price;
@property (nonatomic,copy) NSString *taobao_selling_price;
@property (nonatomic,copy) NSString *taobao_promo_price;
@property (nonatomic,copy) NSString *money_symbol;
@property (nonatomic,copy) NSString *integral;
@property (nonatomic,copy) NSString *taobao_url;
@property (nonatomic,copy) NSString *mobile_cps_url;
@property (nonatomic,copy) NSString *pc_cps_url;
@property (nonatomic,copy) NSString *tag_type;
@property (nonatomic,copy) NSString *taobao_delist_time;
@property (nonatomic,copy) NSString *taobao_pic_url;
@property (nonatomic,strong)NSArray *taobao_item_imgs;
@property (nonatomic,copy) NSString *taobao_volume;
@property (nonatomic,copy) NSString *visits_count;
@property (nonatomic,copy) NSString *comments_count;
@property (nonatomic,copy) NSString *likes_count;
@property (nonatomic,copy) NSString *shares_count;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *is_deleist;
@property (nonatomic,copy) NSString *quality_score;
@property (nonatomic,copy) NSString *price_score;
@property (nonatomic,copy) NSString *conform_score;
@property (nonatomic,copy) NSString *synthesis_score;
@property (nonatomic,strong)NSArray *merchant;
@property (nonatomic,strong)NSArray *brand;
@property (nonatomic,copy) NSString *from_title;
@property (nonatomic,copy) NSString *from_logo_url;
@property (nonatomic,copy) NSString *from_type;
@property (nonatomic,strong)NSArray *current_lottery;
@property (nonatomic,strong)NSArray *right_part;
@property (nonatomic,copy) NSString *sub_title;
@property (nonatomic,copy) NSString *title;

- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFHomeHotGoodsModel : NSObject

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

@interface ZFBrandInfoModel : NSObject


@property (nonatomic,copy) NSString *taobao_num_iid;
@property (nonatomic,copy) NSString *taobao_title;
@property (nonatomic,copy) NSString *taobao_price;
@property (nonatomic,copy) NSString *taobao_selling_price;
@property (nonatomic,copy) NSString *taobao_promo_price;
@property (nonatomic,copy) NSString *money_symbol;
@property (nonatomic,copy) NSString *integral;
@property (nonatomic,copy) NSString *taobao_url;
@property (nonatomic,copy) NSString *mobile_cps_url;
@property (nonatomic,copy) NSString *pc_cps_url;
@property (nonatomic,copy) NSString *tag_type;
@property (nonatomic,copy) NSString *taobao_delist_time;
@property (nonatomic,copy) NSString *taobao_pic_url;
@property (nonatomic,strong)NSArray *taobao_item_imgs;
@property (nonatomic,copy) NSString *taobao_volume;
@property (nonatomic,copy) NSString *visits_count;
@property (nonatomic,copy) NSString *comments_count;
@property (nonatomic,copy) NSString *likes_count;
@property (nonatomic,copy) NSString *shares_count;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *is_deleist;
@property (nonatomic,copy) NSString *quality_score;
@property (nonatomic,copy) NSString *price_score;
@property (nonatomic,copy) NSString *conform_score;
@property (nonatomic,copy) NSString *synthesis_score;
@property (nonatomic,strong)NSArray *merchant;
@property (nonatomic,strong)NSArray *brand;
@property (nonatomic,copy) NSString *from_title;
@property (nonatomic,copy) NSString *from_logo_url;
@property (nonatomic,copy) NSString *from_type;
@property (nonatomic,strong)NSArray *current_lottery;
@property (nonatomic,strong)NSArray *right_part;
@property (nonatomic,copy) NSString *sub_title;
@property (nonatomic,copy) NSString *title;


@property (nonatomic,strong) NSString *last_lottery_id;
@property (nonatomic,strong) NSString *lottery_id;
@property (nonatomic,strong) NSString *tag_url;
- (id)initWithDictionary:(NSDictionary *)dic;

@end

