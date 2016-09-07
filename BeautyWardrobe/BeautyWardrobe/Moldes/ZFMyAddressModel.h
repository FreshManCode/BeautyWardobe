//
//  ZFMyAddressModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFMyAddressModel : NSObject

@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,copy) NSString *yk_user_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *is_default;
@property (nonatomic,copy) NSString *id_card_front_img_url;
@property (nonatomic,copy) NSString *id_card_back_img_url;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
