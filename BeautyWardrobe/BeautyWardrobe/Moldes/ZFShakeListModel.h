//
//  ZFShakeListModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFShakeListModel : NSObject
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_image_url;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *created_time;
- (id)initWithDictionary:(NSDictionary *)dic;


@end
