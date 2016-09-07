//
//  ZFHeadADsProductModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/29.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFHeadADsProductModel.h"


@implementation ZFHeadADsProductModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.taobao_num_iid  = dic[@"taobao_num_iid"];
        self.taobao_title= dic[@"taobao_title"];
        self.taobao_prices = dic[@"taobao_price"];
        self.taobao_promo_price = dic[@"taobao_promo_price"];
        self.taobao_selling_price = dic[@"taobao_selling_price"];
        self.money_symbol = dic[@"money_symbol"];
        self.integral = dic[@"integral"];
        self.taobao_url = dic[@"taobao_url"];
        self.mobile_cps_url = dic[@"mobile_cps_url"];
        self.pc_cps_url = dic[@"pc_cps_url"];
        self.tag_type = dic[@"tag_type"];
        self.tag_url = dic[@"tag_url"];
        self.taobao_delist_time = dic[@"taobao_delist_time"];
        self.taobao_pic_url= dic[@"taobao_pic_url"];
        self.taobao_item_imgs = dic[@"taobao_item_imgs"];
        self.taobao_volume = dic[@"taobao_volume"];
        self.visits_count = dic[@"visits_count"];
        self.comments_count = dic[@"comments_count"];
        self.likes_count = dic[@"likes_count"];
        self.share_count = dic[@"share_count"];
        self.product_id = dic[@"product_id"];
        self.is_deleist = dic[@"is_deleist"];
        self.discount = dic[@"discount"];
        self.quality_score = dic[@"quality_score"];
        self.conform_score = dic[@"conform_score"];
        self.synthesis_score = dic[@"synthesis_score"];
        self.merchant = dic[@"merchant"];
        self.brand = dic[@"brand"];
        self.from_title = dic[@"from_title"];
        self.from_logo_url = dic[@"from_logo_url"];
        self.from_type = dic[@"from_type"];
        self.price_score = dic[@"price_score"];
    }
    return self;
}



@end

@implementation ZFMyItemModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super initWithDictionary:dic]) {
        self.is_like = dic[@"is_like"];
        self.addded_time = dic[@"added_time"];
        self.current_lottery = dic[@"current_lottery"];
    }
    return self;
}

@end

