//
//  ZFHeadADsModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFHeadADsModel.h"

@implementation ZFHeadADsModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未定义的key:%@",key);
}

+ (id)baseModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDictionary:dic];
}

@end
