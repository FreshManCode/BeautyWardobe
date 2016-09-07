//
//  ZFBrandListModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/9.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFBrandListModel : NSObject

@property (nonatomic,copy) NSString *groupExpand;
@property (nonatomic,copy) NSString *groupName;
@property (nonatomic,copy) NSString *groupPicUrl;
@property (nonatomic,strong) NSArray *items;
- (id)initWithDictionary:(NSDictionary *)dic;


@end

@interface ZFBrandListContentModel : NSObject


@property (nonatomic,copy) NSString *brand_type;
@property (nonatomic,copy) NSString *descriptio;
@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,copy) NSString *likes_count;
@property (nonatomic,copy) NSString *logo_url;
@property (nonatomic,strong )NSArray *taobao_pic_urls;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *bind_user_id;
@property (nonatomic,copy) NSString *quality_score;
@property (nonatomic,copy) NSString *price_score;
@property (nonatomic,copy) NSString *conform_score;
@property (nonatomic,copy) NSString *synthesis_score;
@property (nonatomic,copy) NSString *vistis_count;
- (id)initWithDictionary:(NSDictionary *)dic;
@end

@interface ZFBrandShareModel : NSObject
@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,copy) NSString *merchant_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *logo_url;
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,copy) NSString *taobao_seller_sid;
@property (nonatomic,copy) NSString *brand_type;
@property (nonatomic,copy) NSString *descriptions;
@property (nonatomic,copy) NSString *news_products_count;
@property (nonatomic,copy) NSString *news_list_time;
@property (nonatomic,strong) NSArray *taobao_pic_urls;
@property (nonatomic,copy) NSString *bind_user_id;
@property (nonatomic,copy) NSString *share_title;
@property (nonatomic,copy) NSString *share_message;
@property (nonatomic,copy) NSString *vistis_count;
@property (nonatomic,copy) NSString *likes_count;
@property (nonatomic,copy) NSString *quality_score;
@property (nonatomic,copy) NSString *price_score;
@property (nonatomic,copy) NSString *conform_score;
@property (nonatomic,copy) NSString *synthesis_score;
- (id)initWithDictionary:(NSDictionary *)dic;
@end