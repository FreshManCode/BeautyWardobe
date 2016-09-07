//
//  ZFMyItemCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyItemCell.h"
#import <UIImageView+WebCache.h>
#import "NSString+Helper.h"
@implementation ZFMyItemCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZFMyItemCell";
    ZFMyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFMyItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    if (!_verticaLayer) {
        _verticaLayer = [CALayer layer];
        _verticaLayer.frame = CGRectMake(29, 0, 1.0, 12);
        _verticaLayer.backgroundColor = ZFRGBColor(181, 181, 181).CGColor;
    }
    [self.layer addSublayer:_verticaLayer];
    
    if (!_loopView) {
        _loopView = [UIView new];
        _loopView.frame = CGRectMake(14, 12, 32, 32);
        _loopView.backgroundColor = ZFRGBColor(249, 96, 39);
        _loopView.layer.cornerRadius = 16.0f;
        _loopView.layer.borderColor = [UIColor whiteColor].CGColor;
        _loopView.layer.borderWidth = 3.0f;
        [_loopView clipsToBounds];
    }
    [self.contentView addSubview:_loopView];
    
    if (!_bottomVerticalLayer) {
        _bottomVerticalLayer = [CALayer layer];
        _bottomVerticalLayer.frame = CGRectMake(29, _loopView.bottom, 1.0, 190-_loopView.bottom);
        _bottomVerticalLayer.backgroundColor = ZFRGBColor(181, 181, 181).CGColor;
    }
    [self.layer addSublayer:_bottomVerticalLayer];
    
    if (!_poingView) {
        _poingView = [UIView new];
        _poingView.frame = CGRectMake(25, 12+97, 8.0, 8.0);
        _poingView.backgroundColor = ZFRGBColor(184, 184, 184);
        _poingView.layer.cornerRadius = 4.0f;
        [_poingView clipsToBounds];
    }
    [self.contentView addSubview:_poingView];
    
    
    if (!_monthLab) {
        _monthLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 17, 32, 10)];
        _monthLab.font = ZFFont(10.0f);
        _monthLab.backgroundColor = [UIColor clearColor];
        _monthLab.textAlignment = NSTextAlignmentCenter;
        _monthLab.textColor = [UIColor whiteColor];
        
    }
    [_loopView addSubview:_monthLab];
    
    if (!_dayLab) {
        _dayLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 32, 14.0f)];
        _dayLab.font = ZFFont(14.0f);
        _dayLab.backgroundColor = [UIColor clearColor];
        _dayLab.textAlignment = NSTextAlignmentCenter;
        _dayLab.text = @"26";
        _dayLab.textColor = [UIColor whiteColor];
    }
    [_loopView addSubview:_dayLab];
    
    if (!_topLab) {
        _topLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, ZFScreenWidth-80, 13.0f)];
        _topLab.textColor = ZFRGBColor(100, 90, 90);
        _topLab.font = ZFFont(13.0f);
        _topLab.textAlignment = NSTextAlignmentCenter;
    }
    [self.contentView addSubview:_topLab];
    
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 50, ZFScreenWidth-30, 160)];
        _bgImage.image = [UIImage imageNamed:@"chat_receive_text_bg"];
        _bgImage.userInteractionEnabled = YES;
    }
    [self.contentView addSubview:_bgImage];
    
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(15+40, 10, 85, 90)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toItemDetailViewConttroller:)];
        _leftImage.userInteractionEnabled = YES;
        [_leftImage addGestureRecognizer:tapGesture];
    }
    [_bgImage addSubview:_leftImage];
    
    if (!_brandLab) {
        _brandLab = [[UILabel alloc]initWithFrame:CGRectMake(_leftImage.left, _leftImage.bottom+7, _leftImage.width, 12.0f)];
        _brandLab.font = ZFFont(12.0f);
        _brandLab.textColor = ZFRGBColor(100, 100, 100);
        _brandLab.textAlignment = NSTextAlignmentLeft;
    }
    [_bgImage addSubview:_brandLab];
    
    if (!_accurateTimeLab) {
        _accurateTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(_leftImage.right+5, 15, _bgImage.width-_leftImage.right-10, 12)];
        _accurateTimeLab.textAlignment = NSTextAlignmentLeft;
        _accurateTimeLab.font = ZFFont(12.0f);
        _accurateTimeLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [_bgImage addSubview:_accurateTimeLab];
    
    if (!_descriptionLab) {
        _descriptionLab = [[UILabel alloc]initWithFrame:CGRectMake(_accurateTimeLab.left, _accurateTimeLab.bottom+4, _accurateTimeLab.width-26, _leftImage.height -30-20)];
        _descriptionLab.numberOfLines = 0;
        _descriptionLab.font = ZFFont(11.0f);
        _descriptionLab.textAlignment = NSTextAlignmentLeft;
    }
    [_bgImage addSubview:_descriptionLab];
    
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(_accurateTimeLab.left, _descriptionLab.bottom+8, _descriptionLab.width, 15.0f)];
        _priceLab.textAlignment = NSTextAlignmentLeft;
        _priceLab.font = ZFFont(15.0f);
        _priceLab.textColor = [UIColor redColor];
    }
    [_bgImage addSubview:_priceLab];
    
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(_descriptionLab.right-45, _leftImage.bottom-10, 40, 40)];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"button_delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteItemEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_bgImage addSubview:_deleteBtn];
}


- (void)setItemModel:(ZFMyItemModel *)itemModel {
    _itemModel = itemModel;
    if ([_itemModel.addded_time length]>0) {
        NSString *time =[_itemModel.addded_time timeStampTransStandardTime:_itemModel.addded_time];
        NSArray *timeArray = [time componentsSeparatedByString:@" "];
        NSInteger month = [timeArray[1] integerValue];
        _monthLab.text =  [NSString stringWithFormat:@"%lu月",month];
        NSInteger day  =  [timeArray[2] integerValue];
        _dayLab.text   =   [NSString stringWithFormat:@"%lu",day];
        _descriptionLab.text = _itemModel.taobao_title;
        [_leftImage sd_setImageWithURL:[NSURL URLWithString:_itemModel.taobao_pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        _priceLab.text = _itemModel.taobao_prices;
        _accurateTimeLab.text = [NSString stringWithFormat:@"%lu月%lu日 %@",month,day,timeArray[3]];
    }
}


- (void)deleteItemEvent:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(didClickDeleteBtnWithModel:)]) {
        [_delegate didClickDeleteBtnWithModel:_itemModel];
    }
}

- (void)toItemDetailViewConttroller:(UITapGestureRecognizer *)gesture {
    if (_delegate &&[_delegate respondsToSelector:@selector(didClickLeftPicImageWithModel:)]) {
        [_delegate didClickLeftPicImageWithModel:_itemModel];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
