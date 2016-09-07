//
//  CategoryModel.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/18.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZCategoryModel.h"

@implementation ZCategoryModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"未定义的key:%@",key);
}

+ (id)initModelWithDictionary:(NSDictionary *)dic {
    return [[self alloc]initWithDictionary:dic];
}

@end
