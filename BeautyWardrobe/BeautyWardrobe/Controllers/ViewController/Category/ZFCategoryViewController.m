//
//  ZFCategoryViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFCategoryViewController.h"
#import "ZCategorySearchVC.h"

#import "NetwokeManager.h"

#import "ZCategoryModel.h"
#import "ZCategoryCollectionViewCell.h"
#import "ZCategoryCell.h"
#import "ZCategoryButton.h"

#define kTableViewWidth 70
#define kButtonTag 100
@interface ZFCategoryViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
UISearchBarDelegate
>
{
    NSInteger _currentItem;
}
@property (nonatomic, strong)UITableView         *tableView;
@property (nonatomic, strong)UICollectionView    *collectionView;
@property (nonatomic, strong)NSMutableArray      *titleArray;
@property (nonatomic, strong)NSMutableDictionary *contentDic;
@property (nonatomic, strong)UISearchBar         *searchBar;
@end

static NSString *const tableCellID = @"tableCell";
static NSString *const collectionCellID = @"collectionCell";

@implementation ZFCategoryViewController
#pragma mark - load data
- (void)loadData
{
    NSString *urlString = @"http://vapi.yuike.com/1.0/category/list.php?mid=457465&sid=7e59f585d7a6005889dbc6289b422f30&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5153314";
    
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        
        NSArray *datas = data[@"data"];
        for (NSInteger i = 0; i < datas.count; i ++) {
            NSDictionary *dic = datas[i];
            NSString *productString = dic[@"category_title"];
            [self.titleArray addObject:productString];

            NSArray *subCategories = dic[@"sub_categories"];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            for (NSInteger j = 0; j < subCategories.count; j ++) {
                
                NSDictionary *subDic = subCategories[j];
                ZCategoryModel *model = [ZCategoryModel initModelWithDictionary:subDic];
                [array addObject:model];
            }
            [self.contentDic setObject:array forKey:[NSString stringWithFormat:@"%ld", (long)i]];
        }
        
        [self.tableView reloadData];
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - view life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _currentItem = 0;
    self.navigationItem.titleView = self.searchBar;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    UILabel *line = [[UILabel alloc] init];
    line.frame = CGRectMake(kTableViewWidth - 0.5, 64, 0.5, ZFScreenHeight - 64 - 49);
    line.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line];
    
    [_tableView registerClass:[ZCategoryCell class] forCellReuseIdentifier:tableCellID];
    [_collectionView registerClass:[ZCategoryCollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
    
    [self loadData];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.nameTitle = self.titleArray[indexPath.row];
    
    if (indexPath.row == _currentItem) {
        cell.categoryBtn.selected = YES;
    }else {
        cell.categoryBtn.selected = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _currentItem = indexPath.row;
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

#pragma mark - collection view
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *index = [NSString stringWithFormat:@"%ld", (long)_currentItem];
    NSArray *datas = self.contentDic[index];
    return datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    NSString *index = [NSString stringWithFormat:@"%ld", (long)_currentItem];
    NSArray *datas = self.contentDic[index];
    ZCategoryModel *model = datas[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

#pragma mark - searceh delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    ZCategorySearchVC *vc = [[ZCategorySearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    return NO;
}

#pragma mark - getter
- (NSMutableDictionary *)contentDic
{
    if (_contentDic == nil) {
        _contentDic = [NSMutableDictionary dictionary];
    }
    return _contentDic;
}

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 64, kTableViewWidth, ZFScreenHeight - 64 - 49);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake(70, 90);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGRect frame = CGRectMake(kTableViewWidth, 64, ZFScreenWidth - kTableViewWidth, ZFScreenHeight - 64 - 49);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor lightTextColor];
    }
    return _collectionView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        CGRect frame = CGRectMake(10, 10, ZFScreenWidth - 10*2, 35);
        _searchBar = [[UISearchBar alloc] initWithFrame:frame];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索你喜欢的宝贝";
        [_searchBar setImage:[UIImage imageNamed:@"搜索按钮"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
    return _searchBar;
}

@end
