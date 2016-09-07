//
//  NSString+Helper.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/30.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)
- (NSString *)timeStampTransStandardTime:(NSString *)timeStamp {
    NSInteger timeInteger = [timeStamp integerValue];
    NSDate *confirmTime = [NSDate dateWithTimeIntervalSince1970:timeInteger];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY MM dd HH mm"];
    NSString *standardTime = [formatter stringFromDate:confirmTime];
    return standardTime;
}


@end
