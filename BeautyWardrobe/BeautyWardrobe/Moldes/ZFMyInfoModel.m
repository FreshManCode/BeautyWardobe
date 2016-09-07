//
//  ZFMyInfoModel.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/31.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyInfoModel.h"

@implementation ZFMyInfoModel
- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.yk_user_id = dic[@"yk_user_id"];
        self.merchant_id = dic[@"merchant_id"];
        self.user_image_url = dic[@"user_image_url"];
        self.user_name = dic[@"user_name"];
        self.user_type = dic[@"user_type"];
        self.login_phone = dic[@"login_phone"];
        self.descriptio = dic[@"description"];
        self.last_login_time = dic[@"last_login_time"];
        self.brands_count = dic[@"brands_count"];
        self.carts_count = dic[@"carts_count"];
        self.status = dic[@"status"];
        self.is_edit_pwd = dic[@"is_edit_pwd"];
        self.integral = dic[@"integral"];
        self.balance = dic[@"balance"];
        self.available_balance = dic[@"available_balance"];
        self.withdrawing_balance = dic[@"withdrawing_balance"];
        self.freeze_balance = dic[@"freeze_balance"];
        self.ykcoin_amount = dic[@"ykcoin_amount"];
        self.min_withdraw_cash_amount = dic[@"min_withdraw_cash_amount"];
        self.ykcoin_name = dic[@"ykcoin_name"];
        self.money_symbol = dic[@"money_symbol"];
        self.agent = dic[@"agent"];
        self.wait_confirm_orders_count = dic[@"wait_confirm_orders_count"];
        self.wait_finished_orders_count = dic[@"wait_finished_orders_count"];
        self.wait_pay_orders_count = dic[@"wait_pay_orders_count"];
        self.wait_rate_orders_count = dic[@"wait_rate_orders_count"];
        self.wait_send_orders_count = dic[@"wait_send_orders_count"];
        self.is_apply_new_user_gift = dic[@"is_apply_new_user_gift"];
    }
    return self;
}



@end
