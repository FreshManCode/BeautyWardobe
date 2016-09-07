//
//  ZShoppingCollectionViewCell.m
//  BeautyWardrobe
//
//  Created by 周成龙 on 16/5/13.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZShoppingCollectionViewCell.h"
#import "ZShoppingCell.h"


#define kSelfWidth self.contentView.bounds.size.width
#define kSelfHeight self.contentView.bounds.size.height

@interface ZShoppingCollectionViewCell ()
<
UITableViewDataSource, UITableViewDelegate
>

@property (nonatomic, strong)UITableView *tableView;

@end

static NSString *const cellID = @"cellID";
@implementation ZShoppingCollectionViewCell

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, kSelfWidth, kSelfHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.contentArray = @[@"a", @"b", @"c"];
        [self.contentView addSubview:self.tableView];
        [self.tableView registerNib:[UINib nibWithNibName:@"ZShoppingCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    
    return self;
}


#pragma mark - table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    ZShoppingModel *model = self.contentArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor lightGrayColor];
    headerView.frame = CGRectMake(0, 0, kSelfWidth, 35);
    
    CGFloat topMargin = (35 - 25)/2.0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, topMargin, 25, 25);
    button.backgroundColor = [UIColor redColor];
    button.tag = section;
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:button];
    
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(CGRectGetMaxX(button.frame) + 10, topMargin, 200, 25);
    titleLabel.font = [UIFont systemFontOfSize:14.f];
    titleLabel.textColor = [UIColor blackColor];
    [headerView addSubview:titleLabel];
    
    titleLabel.text = self.titleString;
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

#pragma mark - private

- (void)buttonClick:(UIButton *)sender
{
    NSLog(@"%ld", sender.tag);
    
    
    
    
}


@end
