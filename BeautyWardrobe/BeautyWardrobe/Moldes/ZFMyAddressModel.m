//
//  ZFMyAddressModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyAddressModel.h"

@implementation ZFMyAddressModel
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.idNum = dic[@"id"];
        self.yk_user_id = dic[@"yk_user_id"];
        self.name = dic[@"name"];
        self.phone = dic[@"phone"];
        self.province = dic[@"province"];
        self.city = dic[@"city"];
        self.area = dic[@"area"];
        self.address = dic[@"address"];
        self.is_default = dic[@"is_default"];
        self.id_card_front_img_url = dic[@"id_card_front_img_url"];
        self.id_card_back_img_url = dic[@"id_card_back_img_url"];
    }
    return self;
}




@end
