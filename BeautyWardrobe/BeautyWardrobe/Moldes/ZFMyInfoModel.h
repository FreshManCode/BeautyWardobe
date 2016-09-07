//
//  ZFMyInfoModel.h
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/31.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFMyInfoModel : NSObject
@property (nonatomic,copy) NSString *yk_user_id;
@property (nonatomic,copy) NSString *merchant_id;
@property (nonatomic,copy) NSString *user_type;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_image_url;
@property (nonatomic,copy) NSString *login_phone;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *descriptio;
@property (nonatomic,copy) NSString *last_login_time;
@property (nonatomic,copy) NSString *brands_count;
@property (nonatomic,copy) NSString *products_count;
@property (nonatomic,copy) NSString *carts_count;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *is_edit_pwd;
@property (nonatomic,copy) NSString *integral;
@property (nonatomic,copy) NSString *balance;
@property (nonatomic,copy) NSString *available_balance;
@property (nonatomic,copy) NSString *withdrawing_balance;
@property (nonatomic,copy) NSString *freeze_balance;
@property (nonatomic,copy) NSString *ykcoin_amount;
@property (nonatomic,copy) NSString *min_withdraw_cash_amount;
@property (nonatomic,copy) NSString *ykcoin_name;
@property (nonatomic,copy) NSString *money_symbol;
@property (nonatomic,strong) NSArray * agent;
@property (nonatomic,copy) NSString *wait_pay_orders_count;
@property (nonatomic,copy) NSString *wait_send_orders_count;
@property (nonatomic,copy) NSString *wait_confirm_orders_count;
@property (nonatomic,copy) NSString *wait_finished_orders_count;
@property (nonatomic,copy) NSString *wait_rate_orders_count;
@property (nonatomic,copy) NSString *is_apply_new_user_gift;

- (id)initWithDictionary:(NSDictionary *)dic;



@end
