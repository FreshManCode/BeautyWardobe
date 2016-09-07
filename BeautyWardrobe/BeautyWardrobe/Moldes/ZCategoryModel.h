//
//  CategoryModel.h
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/18.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCategoryModel : NSObject


@property (nonatomic, copy)NSString *hot;
@property (nonatomic, copy)NSString *method;
@property (nonatomic, copy)NSString *pic_url;
@property (nonatomic, copy)NSString *taobao_cid;
@property (nonatomic, copy)NSString *taobao_title;

+ (id)initModelWithDictionary:(NSDictionary *)dic;

@end
