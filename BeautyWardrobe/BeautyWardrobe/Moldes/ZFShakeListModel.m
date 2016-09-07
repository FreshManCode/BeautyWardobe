//
//  ZFShakeListModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFShakeListModel.h"

@implementation ZFShakeListModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.user_name = dic[@"user_name"];
        self.user_image_url = dic[@"user_image_url"];
        self.message   = dic[@"message"];
        self.created_time = dic[@"created_time"];
    }
    return self;
}




@end
