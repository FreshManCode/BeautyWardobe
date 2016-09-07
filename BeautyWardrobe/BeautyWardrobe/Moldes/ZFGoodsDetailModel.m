//
//  ZFGoodsDetailModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoodsDetailModel.h"

@implementation ZFGoodsDetailModel
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.taobao_num_iid = dic[@"taobao_num_iid"];
        self.taobao_title = dic[@"taobao_title"];
        self.taobao_subtitle = dic[@"taobao_subtitle"];
        self.taobao_price = dic[@"taobao_price"];
        self.taobao_selling_price = dic[@"taobao_selling_price"];
        self.money_symbol = dic[@"money_symbol"];
        self.intergral = dic[@"intergral"];
        self.taobao_url = dic[@"taobao_url"];
        self.pc_cps_url = dic[@"pc_cps_url"];
        self.tag_type = dic[@"tag_type"];
        self.mobile_desc = dic[@"mobile_desc"];
        self.taobao_delist_time = dic[@"taobao_delist_time"];
        self.taobao_pic_url = dic[@"taobao_pic_url"];
        self.taobao_item_imgs = dic[@"taobao_item_imgs"];
        self.taobao_num_iid = dic[@"taobao_num_iid"];
        self.props_name = dic[@"props_name"];
        self.size_table = dic[@"size_table"];
        self.taobao_volume = dic[@"taobao_volume"];
        self.freight_id = dic[@"freight_id"];
        self.is_custom_commision = dic[@"is_custom_commision"];
        self.one_commision = dic[@"one_commision"];
        self.two_commision = dic[@"two_commision"];
        self.three_commision = dic[@"three_commision"];
        self.comments_counts = dic[@"comments_counts"];
        self.likes_count = dic[@"likes_count"];
        self.shares_count = dic[@"shares_count"];
        self.last_lottery_id = dic[@"last_lottery_id"];
        self.lottery_id = dic[@"lottery_id"];
        self.lottery_show_prizes_count = dic[@"lottery_show_prizes_count"];
        self.quality_score = dic[@"quality_score"];
        self.price_score = dic[@"price_score"];
        self.conform_score = dic[@"conform_score"];
        self.product_id = dic[@"product_id"];
        self.skus = dic[@"skus"];
        self.is_can_use_coupon = dic[@"is_can_use_coupon"];
        self.is_delist = dic[@"is_delist"];
        self.synthsis_score = dic[@"synthsis_score"];
        self.discount = dic[@"discount"];
        self.merchant = dic[@"merchant"];
        self.brand = dic[@"brand"];
        self.from_title = dic[@"from_title"];
        self.from_logo_url = dic[@"from_logo_url"];
        self.service = dic[@"service"];
        self.last_lottery = dic[@"last_lottery"];
        self.current_lottery = dic[@"current_lottery"];
        self.commission_fee = dic[@"commission_fee"];
        self.promos = dic[@"commission_fee"];
        
    }
    return self;
}


@end

@implementation ZFGoodsDetailHeadImageModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.idNum = dic[@"id"];
        self.position = dic[@"position"];
        self.url = dic[@"url"];
    }
    return self;
}

@end


@implementation ZFGoodsServiceModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.pic_url = dic[@"pic_url"];
    }
    return self;
}


@end


@implementation ZFGoodsPropsNameModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.pname = dic[@"pname"];
        self.vname = dic[@"vname"];
    }
    return self;
}

@end

@implementation ZFGoodsMobileDescModel
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.content = dic[@"content"];
        self.content_type = dic[@"content_type"];
    }
    return self;
}


@end

@implementation ZFGoodsBrandModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.idNum = dic[@"id"];
        self.titile = dic[@"title"];
        self.logo_url = dic[@"logo_url"];
        self.bind_user_id = dic[@"bind_user_id"];
    }
    return self;
}

@end


