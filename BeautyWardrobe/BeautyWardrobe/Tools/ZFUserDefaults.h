//
//  ZFUserDefaults.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFUserDefaults : NSObject
+ (instancetype)shareInstance;

- (NSString *)getAccessTokenWithKey:(NSString *)key;

- (void)setObject:(NSString *)account WithKey:(NSString *)key;

- (void)removeObjectWithKey:(NSString *)key;

@end
