//
//  ZFGoodsDetailCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/16.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoodsDetailHeadCell.h"
#import <UIImageView+WebCache.h>
#import "NetwokeManager.h"
#import "ZFUserDefaults.h"

@implementation ZFGoodsDetailHeadCell
{
    CGFloat _scale;
    NSString *_action;
    NSString *_message;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"GoodsDetailHeadCell";
    ZFGoodsDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFGoodsDetailHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
        _contentHeight = 0;
    }
    return self;
}

- (void)setUpSubViews {
    if (!_topGoodsImage) {
        _topGoodsImage = [UIImageView new];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookPaperImage:)];
        _topGoodsImage.userInteractionEnabled = YES;
        [_topGoodsImage addGestureRecognizer:tapGesture];
        _topGoodsImage.frame = CGRectMake(0, 0, ZFScreenWidth, 370);
    }
    [self.contentView addSubview:_topGoodsImage];
    
    if (!_topImageBottomView) {
        _topImageBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _topGoodsImage.bottom-45, ZFScreenWidth, 45)];
        _topImageBottomView.backgroundColor = [UIColor whiteColor];
    }
    [_topGoodsImage addSubview:_topImageBottomView];
    
    
    if (!_topPriceLab) {
        _topPriceLab = [UILabel new];
        _topPriceLab.textColor = ZFRGBColor(219, 81, 128);
        _topPriceLab.textAlignment = NSTextAlignmentCenter;
        _topPriceLab.font = ZFFont(17.0);;
    }
    [self.contentView addSubview:_topPriceLab];
    
    if (!_originalLab) {
        _originalLab = [UILabel new];
        _originalLab.textAlignment = NSTextAlignmentCenter;
        _originalLab.textColor =  ZFRGBColor(100, 100, 100);
        _originalLab.font = ZFFont(12.0);;
    }
    [self.contentView addSubview:_originalLab];
    
    if (!_deleteLine) {
        _deleteLine = [UIView new];
        _deleteLine.backgroundColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_deleteLine];
    
    if (!_discountBtn) {
        _discountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_discountBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_discountBtn setBackgroundImage:[UIImage imageNamed: @"bg_btn"] forState:UIControlStateNormal];
        _discountBtn.titleLabel.font = ZFFont(12.0f);
    }
    [self.contentView addSubview:_discountBtn];

    if (!_describeLab) {
        _describeLab = [UILabel new];
        _describeLab.font = ZFFont(15.0);
        _describeLab.numberOfLines = 0;
        _describeLab.textAlignment = NSTextAlignmentCenter;
    }
    [self.contentView addSubview:_describeLab];
    if (!_sepratorLine) {
        _sepratorLine = [[UIView alloc] init];
        _sepratorLine.backgroundColor = ZFRGBColor(228, 228, 228);
    }
    [self.contentView addSubview:_sepratorLine];
    
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectBtn.frame = CGRectMake(ZFScreenWidth-75, _topGoodsImage.bottom-125, 50, 50);
        [_collectBtn addTarget:self action:@selector(joinCollectOrCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"button_like_borded"] forState:UIControlStateNormal];
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"button_liked_borded_hight"] forState:UIControlStateSelected];
    }
    
}

- (void)setDetailModel:(ZFGoodsDetailModel *)detailModel {
    _detailModel = detailModel;
    _object_id = detailModel.taobao_num_iid;
    [_topGoodsImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.taobao_pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_topGoodsImage addSubview:_collectBtn];
    }];
//    [_topGoodsImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.taobao_pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
    if (_detailModel.discount) {
        _topPriceLab.frame  = CGRectMake(ZFScreenWidth-470/2.0, _topGoodsImage.bottom-45, 75, 17.0f);
        _originalLab.frame  = CGRectMake(_topPriceLab.right+2, _topPriceLab.top+4, 50, 12.0f);
        _discountBtn.frame  = CGRectMake(_originalLab.right+8, _originalLab.top, 45, 18.0);
        if ([_detailModel.taobao_selling_price length]>0) {
            _topPriceLab.text   = [NSString stringWithFormat:@"%@ %@",_detailModel.money_symbol,_detailModel.taobao_selling_price];
            _originalLab.text   = [NSString stringWithFormat:@"%@ %@",_detailModel.money_symbol,_detailModel.taobao_price];
            _deleteLine.center  = CGPointMake(_originalLab.center.x, _originalLab.center.y);
            _deleteLine.bounds  = CGRectMake(0, 0, [ZFPublic sizeWithString:_originalLab.text font:ZFFont(12.0f) maxSize:CGSizeMake(50, 12.0)].width, 1.0);
             [_discountBtn setTitle:_detailModel.discount forState:UIControlStateNormal];
        }
    }else{
        _topPriceLab.frame = CGRectMake(20, _topGoodsImage.bottom-45, ZFScreenWidth-40, 17.0f);
        if ([_detailModel.taobao_selling_price length]>0) {
            _topPriceLab.text = [NSString stringWithFormat:@"%@ %@",_detailModel.money_symbol,_detailModel.taobao_selling_price];
        }
    }
    if ([_detailModel.taobao_title length]>0) {
        _describeLab.text = _detailModel.taobao_title;
    }
    CGSize size = [ZFPublic sizeWithString:_describeLab.text font:ZFFont(15.0) maxSize:CGSizeMake(ZFScreenWidth-20, MAXFLOAT)];
    _describeLab.frame = CGRectMake(8, _topPriceLab.bottom+10, ZFScreenWidth-20, size.height);
    _sepratorLine.frame = CGRectMake(0, _describeLab.bottom+5, ZFScreenWidth, 1.0f);
    _contentHeight = _sepratorLine.bottom+5;
    
}

- (void)lookPaperImage:(UITapGestureRecognizer *)gesture {
    if (_delegate &&[_delegate respondsToSelector:@selector(didClickImage:)]) {
        [_delegate didClickImage:_detailModel];
    }
}


- (void)joinCollectOrCancel:(UIButton *)sender {
    static NSInteger clickIndex;
    if ([_object_id length]>0) {
        if (clickIndex %2==0) {
            //加入收藏
            _message = @"收藏成功";
            _action = @"1.0/like/post.php?";
            sender.selected = YES;
        }else{
            //取消收藏
            _message = @"取消收藏";
            _action = @"1.0/like/cancel.php?";
            sender.selected = NO;
         }
        [self sendRequest];
    }
    clickIndex ++;
}

- (void)sendRequest {
    NSString *action = [NSString stringWithFormat:@"%@%@",@"object_id=",_object_id];
    NSString *mid    =  [_detailModel.merchant objectForKey:@"id"];
    NSString *sessID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *leftOthers  =  [NSString stringWithFormat:@"mid=%@&sid=%@",mid,sessID];
//    @"mid=457465&sid=c4fb4a00c9d18b2e3528ac94af8a1c11&";
    NSString *rightOthers = @"&type=product&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032";
    NSString *urlString = [NSString stringWithFormat:@"%@/%@%@&%@%@",ZFBaseURL,_action,action,leftOthers,rightOthers];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if (data &&[data[@"msg"] isEqualToString:@"ok"])
        {
             [ZFPublic updateWindowsWithTitle:_message withTime:1.0f];
        }else{
            [ZFPublic updateWindowsWithTitle:@"操作失败请检查参数设置"];
            _collectBtn.selected = NO;
         }
    } failure:^(NSError *error) {
        [ZFPublic updateWindowsWithTitle:@"请检查你的网络"];
    }];
}




- (CGFloat)cellContentHeight {
    return _contentHeight;
}



- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}





@end
