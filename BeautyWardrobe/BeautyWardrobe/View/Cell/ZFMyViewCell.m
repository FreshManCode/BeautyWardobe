//
//  ZFMyViewCell.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/6.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyViewCell.h"
#import <Masonry.h>

@implementation ZFMyViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = ZFMyViewCellIdentifier;
    ZFMyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ZFMyViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, (self.height-30)/2.0, 25, 30)];
    }
    [self.contentView addSubview:_leftIcon];
    
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_leftIcon.right+5, (self.height-13)/2.0, 155, 13.0f)];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:13.0];
        _titleLab.textColor = ZFRGBColor(100, 100, 100);
    }
    [self.contentView addSubview:_titleLab];
    if (!_moreImage) {
        _moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-22, (self.height-8)/2.0, 8, 8)];
        _moreImage.image = [UIImage imageNamed:@"msgc_ic_arrow"];
    }
    [self.contentView addSubview:_moreImage];
    
    _contetntLab = [[UILabel alloc]initWithFrame:CGRectMake(ZFScreenWidth-_moreImage.width-2-130, 0, 110, self.height)];
    _contetntLab.textAlignment = NSTextAlignmentRight;
    _contetntLab.font = [UIFont systemFontOfSize:13.0f];
    _contetntLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_contetntLab];
}






@end
