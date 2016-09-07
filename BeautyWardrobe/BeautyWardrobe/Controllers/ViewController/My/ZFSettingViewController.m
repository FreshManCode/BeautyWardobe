//
//  ZFSettingViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFSettingViewController.h"
#import "ZFSettingCell.h"
#import <SDImageCache.h>

@interface ZFSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_leftIamgeArray;
    NSMutableArray *_titleArray;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZFSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    self.titleLabel.text = @"设置";
    _titleArray = [[NSMutableArray alloc]initWithObjects:@"新人有礼",@"修改密码",@"常见问题解答",@"清除本地图片缓存",@"关于",@"退出登录", nil];
    _leftIamgeArray = [[NSMutableArray alloc]initWithObjects:@"user_gift",@"user_editpwd",@"user_question",@"user_delete",@"user_about",nil];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight -[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZFRGBColor(242, 242, 242);
    }
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 13.0;
    }else{
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 13.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFSettingCell *cell = [ZFSettingCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        cell.type = ZFSettingCellTypeDefault;
        cell.titleLab.text  = _titleArray[indexPath.row];
        cell.leftIcon.image = [UIImage imageNamed:_leftIamgeArray[indexPath.row]];
        if (indexPath.row==1) {
            [cell.sepratorLine setHidden:YES];
        }
    }else if (indexPath.section==1){
        cell.type = ZFSettingCellTypeDefault;
        cell.titleLab.text = _titleArray[2];
        cell.leftIcon.image = [UIImage imageNamed:_leftIamgeArray[2]];
        [cell.sepratorLine setHidden:YES];
    }else if (indexPath.section==2){
        if (indexPath.row==0) {
            cell.type = ZFSettingCellTypeSubtitle;
            cell.titleLab.text  = _titleArray[3];
            cell.leftIcon.image = [UIImage imageNamed:_leftIamgeArray[3]];
            NSUInteger size = [[SDImageCache sharedImageCache]getSize];
            CGFloat mSize = size/1024/1024;
            NSString *cache = [NSString stringWithFormat:@"%.1fM",mSize];
            if ([cache length]>0) {
                cell.subTitleLab.text = cache;
            }
        }else{
            cell.type = ZFSettingCellTypeDefault;
            cell.titleLab.text = _titleArray[4];
            cell.leftIcon.image = [UIImage imageNamed:_leftIamgeArray[4]];
            [cell.sepratorLine setHidden:YES];
        }
    }else{
        cell.type = ZFSettingCellTypeOnltTitle;
        cell.loginOutLab.text = _titleArray[5];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
