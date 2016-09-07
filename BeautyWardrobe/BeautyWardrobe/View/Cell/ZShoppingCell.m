//
//  ZShoppingCell.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZShoppingCell.h"

#import <UIImageView+WebCache.h>

@interface ZShoppingCell ()

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsScaleLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (weak, nonatomic) IBOutlet UITextField *goodsNumberLabel;

@end

@implementation ZShoppingCell

- (void)setModel:(ZShoppingModel *)model
{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.taobao_pic_url] placeholderImage:nil];
    self.goodsNameLabel.text = model.taobao_title;
    self.goodsScaleLabel.text = [NSString stringWithFormat:@"%@:%@ %@:%@", model.style_key, model.style_key, model.size_key, model.size_key];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"价格:%@%@ %@%@", model.money_symbol, model.taobao_selling_price, model.money_symbol, model.taobao_price]];
    NSMutableAttributedString *attributeSubString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"价格:%@%@", model.money_symbol, model.taobao_selling_price]];
    NSUInteger len = attributedString.length;
    NSUInteger subLen = attributeSubString.length + 1;
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,subLen)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(0,subLen)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0f] range:NSMakeRange(subLen,len - subLen)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(subLen,len - subLen)];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(subLen,len - subLen)];
    self.goodsPriceLabel.attributedText = attributedString;
    self.goodsNumberLabel.text = model.number;
}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)selectedButtonClick:(UIButton *)sender {
    
}


- (IBAction)cutButtonClick:(UIButton *)sender {
    
}

- (IBAction)addButtonClick:(UIButton *)sender {
    
}


- (IBAction)deleteButtonClick:(UIButton *)sender {
    
}


@end
