//
//  ZFUserDefaults.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFUserDefaults.h"

@implementation ZFUserDefaults

+ (instancetype)shareInstance {
    static ZFUserDefaults *_intance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _intance = [[ZFUserDefaults alloc]init];
    });
    return _intance;
}

- (NSString *)getAccessTokenWithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults objectForKey:key];
}

- (void)setObject:(NSString *)account WithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account forKey:key];
    [userDefaults synchronize];
}


- (void)removeObjectWithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

@end
