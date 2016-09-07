//
//  ZFExplanationViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/26.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFExplanationViewController.h"

@interface ZFExplanationViewController ()
@property (nonatomic,strong) UITextView *introduceView;
@property (nonatomic,strong) UIScrollView *bgScrollView;

@end

@implementation ZFExplanationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight-[self getStartOriginY])];
        _bgScrollView.bounces = YES;
        _bgScrollView.backgroundColor = ZFRGBColor(239, 239, 239);
        _bgScrollView.contentSize = CGSizeMake(ZFScreenWidth, ZFScreenHeight);
    }
    [self.view addSubview:_bgScrollView];
    self.titleLabel.text = _titleName;
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    NSString *introduce;
    NSString *intoduce1= @"1.如何领取\n美丽衣橱将通过各种活动,例如\"新手有礼\"等,向用户赠送优惠券,敬请各位mm经常关注哦\n\n2.使用条件\n用户可以到我的优惠券中,查看自己已拥有的优惠券,例如现金券等。请注意优惠券的使用条件，包括订单的最低价格、有限期限等，记得要及时使用哦\n\n3.通用商品\n美丽衣橱合作品牌、入住的商家,即显示\"立即够买\"的上篇。\n\n4.如何使用\n针对试用商品进行购买操作,在\"确认订单\"这个界面,系统会自动为你选择当前可用的优惠券。如您拥有多张适用优惠券,也可以手工更改。\n\n\n\n美丽衣橱官网拥有上树优惠使用的最终解释权,祝您购物愉快";
    
    NSString *introduce2 = @"1.什么是我的钱包?\n为了使广大会员购物更安全、顺畅,美丽衣橱退出了一种新型的电子账户--我的钱包。只要您注册了美丽衣橱,就可以立即拥有一个专属的\"我的钱包\"账户。我的钱包可以实现支付、退款、余额查询和提现等功能。\n\n2.钱包支付\n选购商品之后,在结算页选择支付方式时勾选\"余额支付\"。如果我的钱包中的可用余额大于或等于该订单金额,可用钱包对该订单进行全额支付;如果我的钱包中总额为0,不能勾选。\n\n3.忘了钱包的支付密码该怎么办?\n到\"我的\"-我的钱包-绑定手机-修改密码,根据提示先绑定手机,再修改密码\n\n4.钱包退款\n在美丽衣橱购物时所产生的退款金额,将默认直接推到您账户我的钱包上,即时到账,可用于下一次支付。\n\n5.钱包提现\n如果您有需要,请在美丽衣橱手机客户端,登录账号进去\"我的\"--我的钱包--钱包提现进行操作。";
    
    NSString *introduce3 = @"1.什么是美丽币?\n美丽币是用户在使用美丽衣橱时获得的奖励积分,可以在购物时抵扣现金使用,100枚美丽币可以抵1元现金。\n\n2.如何获得美丽币?\n a.每日签到,可以获得一定数量的美丽币,连续30天获得额外惊喜。\n b.\"摇一摇\"试试手气,也可以赚取美丽币,数量随机。\n c.其他官方活动。\n\n3.其他说明\n美丽币只可用于购物时候抵扣部门现金,不可提现,不可转让。\n\n美丽衣橱拥有活动最终解释权";
    if ([_titleName isEqualToString:@"使用说明"]) {
        introduce = intoduce1;
    }else if ([_titleName isEqualToString:@"赚美丽币"]){
        introduce = introduce3;
    }else if([_titleName isEqualToString:@"钱包说明"]){
        introduce = introduce2;
    }
    CGSize size = [ZFPublic sizeWithString:introduce font:ZFFont(16.0f) maxSize:CGSizeMake(ZFScreenWidth-20, MAXFLOAT)];
    if (!_introduceView) {
        _introduceView = [[UITextView alloc]initWithFrame:CGRectMake(8, 10, ZFScreenWidth-16, size.height+30)];
        _introduceView.backgroundColor = [UIColor whiteColor];
        _introduceView.text = introduce;
        _introduceView.bounces = YES;
        _introduceView.font = ZFFont(16.0f);
        _introduceView.textColor = ZFRGBColor(100, 100, 100);
        _introduceView.userInteractionEnabled = NO;
        _introduceView.contentSize = CGSizeMake(ZFScreenWidth-16, ZFScreenHeight);
    }
    [_bgScrollView addSubview:_introduceView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = ZFRGBColor(232, 232, 232);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
