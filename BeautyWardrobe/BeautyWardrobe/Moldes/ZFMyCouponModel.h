//
//  ZFMyCouponModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFMyCouponModel : NSObject

@property (nonatomic,copy) NSString *idNum;
@property (nonatomic,copy) NSString *merchant_id;
@property (nonatomic,copy) NSString *coupon_type_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *object_type;
@property (nonatomic,copy) NSString *object_id;
@property (nonatomic,copy) NSString *min_final_price;
@property (nonatomic,copy) NSString *use_start_time;
@property (nonatomic,copy) NSString *use_end_time;
@property (nonatomic,copy) NSString *use_desc;
@property (nonatomic,copy) NSString *status;

- (id)initWithDicionary:(NSDictionary *)dic;


@end


@interface ZFMyWalletModel : NSObject
@property (nonatomic,copy) NSString *yk_user_id;
@property (nonatomic,copy) NSString *balance;
@property (nonatomic,copy) NSString *available_balance;
@property (nonatomic,copy) NSString *withdrawing_balance;
@property (nonatomic,copy) NSString *freeze_balance;
@property (nonatomic,copy) NSString *min_withdraw_cash_amount;
@property (nonatomic,copy) NSString *money_symbol;
@property (nonatomic,copy) NSString *pay_phone;
@property (nonatomic,copy) NSString *is_bind_pay_phone;
@property (nonatomic,copy) NSString *is_set_pay_pwd;
- (id)initWithDiactionary:(NSDictionary *)dic;
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

@end
