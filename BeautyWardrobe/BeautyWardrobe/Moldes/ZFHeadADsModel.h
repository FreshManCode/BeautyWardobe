//
//  ZFHeadADsModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/28.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFHeadADsModel : NSObject

@property (nonatomic,strong) NSString *pic_url;
@property (nonatomic,strong) NSString *url;

- (id)initWithDictionary:(NSDictionary *)dic;
+ (id)baseModelWithDictionary:(NSDictionary *)dic;


@end
