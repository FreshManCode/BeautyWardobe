//
//  ZFMyCouponModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyCouponModel.h"

@implementation ZFMyCouponModel
- (id)initWithDicionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.idNum = dic[@"id"];
        self.merchant_id = dic[@"merchant_id"];
        self.coupon_type_id = dic[@"coupon_type_id"];
        self.title = dic[@"title"];
        self.money = dic[@"money"];
        self.object_id = dic[@"object_id"];
        self.object_type = dic[@"object_type"];
        self.min_final_price = dic[@"min_final_price"];
        self.use_desc = dic[@"use_desc"];
        self.use_end_time = dic[@"use_end_time"];
        self.use_start_time = dic[@"use_start_time"];
        self.status = dic[@"status"];
    }
    return self;
}



@end


@implementation ZFMyWalletModel

-(id)initWithDiactionary:(NSDictionary *)dic {
    if (self =[super init] ) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefined:%@",key);
}

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDiactionary:dic];
}





@end