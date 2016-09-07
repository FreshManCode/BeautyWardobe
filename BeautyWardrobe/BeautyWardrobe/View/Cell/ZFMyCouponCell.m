//
//  ZFMyCouponCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyCouponCell.h"

@implementation ZFMyCouponCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZFMyCouponCell";
    ZFMyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFMyCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
    if (!_couponBg) {
        _couponBg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, ZFScreenWidth-20, 90)];
    }
    [self.contentView addSubview:_couponBg];
    
    if (!_priceLab) {
        _priceLab = [UILabel new];
        _priceLab.text = @"¥";
        _priceLab.font = ZFFont(15.0f);
        _priceLab.textAlignment = NSTextAlignmentCenter;
        _priceLab.textColor = [UIColor whiteColor];
        _priceLab.backgroundColor = [UIColor clearColor];
    }
    [_couponBg addSubview:_priceLab];
    
    if (!_leftPriceImage) {
        _leftPriceImage = [UIImageView new];
        _leftPriceImage.backgroundColor = [UIColor clearColor];
    }
    [_couponBg addSubview:_leftPriceImage];
    
    if (!_rightPriceImage) {
        _rightPriceImage = [UIImageView new];
        _rightPriceImage.backgroundColor = [UIColor clearColor];
    }
    [_couponBg addSubview:_rightPriceImage];
    
    if (!_usePlaceLab) {
        _usePlaceLab = [[UILabel alloc]initWithFrame:CGRectMake(_couponBg.width-380/2.0, 12, 380/2.0, 16.0f)];
        _usePlaceLab.font = ZFFont(16.0f);
        _usePlaceLab.textColor = [UIColor whiteColor];
        _usePlaceLab.backgroundColor = [UIColor clearColor];
        _usePlaceLab.textAlignment =NSTextAlignmentLeft;
    }
    [_couponBg addSubview:_usePlaceLab];
    
    if (!_useConditionLab) {
        _useConditionLab = [[UILabel alloc]initWithFrame:CGRectMake(_usePlaceLab.left, _usePlaceLab.bottom+8, 380/2.0, 16.0)];
        _useConditionLab.font = ZFFont(16.0f);
        _usePlaceLab.text = @"适用场所: 全场";
        _useConditionLab.textColor = [UIColor whiteColor];
        _useConditionLab.backgroundColor = [UIColor clearColor];
        _useConditionLab.textAlignment =NSTextAlignmentLeft;
    }
    [_couponBg addSubview:_useConditionLab];
    
    if (!_expireTimeLab) {
        _expireTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_usePlaceLab.left, _useConditionLab.bottom+8, 380/2.0, 16.0f)];
        _expireTimeLab.font = ZFFont(16.0f);
        _expireTimeLab.textColor = [UIColor whiteColor];
        _expireTimeLab.backgroundColor = [UIColor clearColor];
        _expireTimeLab.textAlignment =NSTextAlignmentLeft;
    }
    
    [_couponBg addSubview:_expireTimeLab];
    
    if (!_expireImage) {
        _expireImage = [[UIImageView alloc]initWithFrame:CGRectMake(_couponBg.width-55, 0, 55, 55)];
        _expireImage.image = [UIImage imageNamed:@"coupons_即将过期"];
        _expireImage.backgroundColor = [UIColor clearColor];
    }
    [_couponBg addSubview:_expireImage];
    
}

- (void)setCouponModel:(ZFMyCouponModel *)couponModel {
    _priceLab.frame = CGRectMake(8, 50, 10.0, 15.0f);
    _couponModel = couponModel;
    NSString *money = [NSString stringWithFormat:@"%@",_couponModel.money] ;
    int amount = [money intValue];
    _couponBg.image = [UIImage imageNamed:[NSString stringWithFormat:@"coupons_bg%d",amount]];
    if (amount>9) {
        int leftNum  = amount /10;
        _leftPriceImage.frame = CGRectMake(_priceLab.right+6, 25, 17, 45);
        _leftPriceImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"coupons_%d",leftNum]];
        int rightNum = amount %10;
        _rightPriceImage.frame = CGRectMake(_leftPriceImage.right+3, 25, 25, 45);
        _rightPriceImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"coupons_%d",rightNum]];
    }else{
        _leftPriceImage.frame = CGRectMake(_priceLab.right+6, 25, 45, 45);
        _leftPriceImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"coupons_%d",amount]];
        [_rightPriceImage setHidden:YES];
    }
    _useConditionLab.text = [NSString stringWithFormat:@"满足条件: %@",_couponModel.use_desc];
    //时间戳转时间
    //1525663323
    NSString  *timeString = _couponModel.use_end_time;
    NSInteger timeInteger = [timeString integerValue];
    NSDate *confirmTime = [NSDate dateWithTimeIntervalSince1970:timeInteger];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    NSString  *expireTime = [formatter stringFromDate:confirmTime];
    _expireTimeLab.text = expireTime;
   
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
