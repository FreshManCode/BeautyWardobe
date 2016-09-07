//
//  ZFBrandListModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFBrandListModel.h"

@implementation ZFBrandListModel
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.groupExpand = dic[@"group_is_expand"];
        self.groupName   = dic[@"group_name"];
        self.groupPicUrl = dic[@"group_pic_url"];
        self.items       = dic[@"items"];
    }
    return self;
}


@end


@implementation ZFBrandListContentModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.brand_type   = dic[@"brand_type"];
        self.descriptio   = dic[@"description"];
        self.idNum        = dic[@"id"];
        self.likes_count  = dic[@"likes_count"];
        self.logo_url     = dic[@"logo_url"];
        self.taobao_pic_urls = dic[@"taobao_pic_urls"];
        self.title        = dic[@"title"];
        self.bind_user_id = dic[@"bind_user_id"];
        self.quality_score   = dic[@"quality_score"];
        self.price_score  = dic[@"price_score"];
        self.conform_score   = dic[@"conform_score"];
        self.synthesis_score = dic[@"synthesis_score"];
        self.vistis_count    = dic[@"vistis_count"];
    }
    return self;
}

@end

@implementation ZFBrandShareModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.idNum       = dic[@"id"];
        self.merchant_id = dic[@"merchant_id"];
        self.title       = dic[@"title"];
        self.logo_url    = dic[@"logo_url"];
        self.pic_url     = dic[@"pic_url"];
        self.taobao_pic_urls = dic[@"taobao_pic_urls"];
        self.brand_type  = dic[@"brand_type"];
        self.descriptions = dic[@"description"];
        self.news_products_count = dic[@"new_products_count"];
        self.news_list_time   = dic[@"new_list_time"];
        self.taobao_pic_urls = dic[@"taobao_pic_urls"];
        self.bind_user_id    = dic[@"bind_user_id"];
        self.share_title     = dic[@"share_title"];
        self.share_message   = dic[@"share_message"];
        self.vistis_count    = dic[@"vistis_count"];
        self.likes_count     = dic[@"likes_count"];
        self.quality_score   = dic[@"quality_score"];
        self.price_score     = dic[@"price_score"];
        self.conform_score   = dic[@"conform_score"];
        self.synthesis_score = dic[@"synthesis_score"];
    }
    return self;
}

@end

