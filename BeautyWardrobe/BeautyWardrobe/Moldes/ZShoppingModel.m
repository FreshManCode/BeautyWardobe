//
//  ZShoppingModel.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZShoppingModel.h"

@implementation ZShoppingModel

- (instancetype)initWithModelDictionary:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)initWithModelDictionary:(NSDictionary *)dic
{
    return [[self alloc] initWithModelDictionary:dic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"未定义的key:%@",key);
}
@end
