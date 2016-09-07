//
//  ZShoppingModel.h
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  "add_time" = 1463218600;
 integral = 14600;
 "is_use_coupon" = 0;
 "money_symbol" = "\U00a5";
 number = 2;
 quantity = 100;
 size = M;
 "size_key" = "\U5c3a\U7801";
 "sku_id" = 548287;
 status = 0;
 style = "\U7c73\U767d\U8272";
 "style_key" = "\U989c\U8272";
 "taobao_num_iid" = 456721;
 "taobao_pic_url" = "http://7xkpsl.com2.z0.glb.qiniucdn.com/data/img/product/a0e4e43b6e638fba2618338aff45064b/47911548cea05d52d448997cfd0ca5c6.jpg";
 "taobao_price" = "288.00";
 "taobao_selling_price" = "146.00";
 "taobao_title" = "\U97e9\U90fd\U8863\U820d2016\U97e9\U7248\U5973\U88c5\U590f\U88c5\U65b0\U6b3eV\U9886\U6536\U8170\U62fc\U63a5\U8fde\U8863\U88d9";
 */
@interface ZShoppingModel : NSObject

@property (nonatomic, copy)NSString *add_time;
@property (nonatomic, copy)NSString *integral;
@property (nonatomic, copy)NSString *is_use_coupon;
@property (nonatomic, copy)NSString *money_symbol;
@property (nonatomic, copy)NSString *number;
@property (nonatomic, copy)NSString *quantity;
@property (nonatomic, copy)NSString *size;
@property (nonatomic, copy)NSString *size_key;
@property (nonatomic, copy)NSString *sku_id;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *style;
@property (nonatomic, copy)NSString *style_key;
@property (nonatomic, copy)NSString *taobao_num_iid;
@property (nonatomic, copy)NSString *taobao_pic_url;
@property (nonatomic, copy)NSString *taobao_price;
@property (nonatomic, copy)NSString *taobao_selling_price;
@property (nonatomic, copy)NSString *taobao_title;

+ (instancetype)initWithModelDictionary:(NSDictionary *)dic;

@end
