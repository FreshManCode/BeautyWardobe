//
//  ZFGoosDetailFourLogoCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/17.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFGoosDetailFourLogoCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@implementation ZFGoosDetailFourLogoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *identifier = @"googsDetailFourLogoCell";
    ZFGoosDetailFourLogoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFGoosDetailFourLogoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    CGFloat width   = 35;
    CGFloat offSetY = (ZFScreenWidth -4*width)/5.0;
    for(int i= 0;i<4;i++){
        CGFloat x = (offSetY +width) *i + offSetY;
        CGFloat y = 12;
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(i==3?x-5:x-15, y, width, width)];
        _image.layer.cornerRadius = width/2.0;
        _image.tag = 10+ i;
        [_image clipsToBounds];
        [self.contentView addSubview:_image];
        
        _titleLab = [UILabel new];
        _titleLab.font = ZFFont(11.0f);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = ZFRGBColor(100, 100, 100);
        _titleLab.tag = 20+i;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_image);
            make.top.equalTo(_image).offset(8+_image.height);
            make.height.equalTo(@(12.0));
            make.width.equalTo(@(width+offSetY+10));
        }];
    }
    if (!_sepratorLine) {
        _sepratorLine = [UIView new];
        _sepratorLine.backgroundColor =  ZFRGBColor(228, 228, 228);
    }
    [self.contentView addSubview:_sepratorLine];
    
}
- (void)layoutSubviews {
    _sepratorLine.frame = CGRectMake(0, self.height-1, ZFScreenWidth, 1.0);
}

- (void)setDetailModel:(ZFGoodsDetailModel *)detailModel {
    _detailModel = detailModel;
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    for(NSMutableDictionary *dic in _detailModel.service){
        ZFGoodsServiceModel *serviceModel = [[ZFGoodsServiceModel alloc]initWithDictionary:dic];
        [array addObject:serviceModel];
    }
    for(int i= 0;i<array.count;i++){
        ZFGoodsServiceModel *model = array[i];
        _image = (UIImageView *)[self viewWithTag:10+i];
        [_image sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:[UIImage imageNamed:@"plcaholer"]];
        _titleLab = (UILabel *)[self viewWithTag:20+i];
        [_titleLab setText:model.title];
    }
}



@end
