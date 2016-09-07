//
//  ZFShoppingViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/4/27.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFShoppingViewController.h"

#import "ZShoppingCollectionViewCell.h"
#import "ZShoppingModel.h"

#import "NetwokeManager.h"

@interface ZFShoppingViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>


@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableDictionary *contentDictionary;
//@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

static NSString *const cellID = @"cellID";
@implementation ZFShoppingViewController
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        CGRect frame = CGRectMake(0, 64, ZFScreenWidth, ZFScreenHeight - 64 - 49);
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ZShoppingCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    
    [self loadData];
}

- (void)loadData
{
    NSString *urlString = @"http://vapi.yuike.com/1.0/cart/list.php";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"457465" forKey:@"mid"];
    [parameters setValue:@"7e59f585d7a6005889dbc6289b422f30" forKey:@"sid"];
    [parameters setValue:@"1" forKey:@"yk_appid"];
    [parameters setValue:@"2.9.3.1" forKey:@"yk_cbv"];
    [parameters setValue:@"1" forKey:@"yk_pid"];
    [parameters setValue:@"5153314" forKey:@"yk_user_id"];
    
    [NetwokeManager requestGetMethodURL:urlString parameters:parameters uploadPreogerss:nil success:^(id data) {
        NSDictionary *dataDic = data[@"data"];
        //NSLog(@"%@", dic);
        if ([dataDic isKindOfClass:[NSDictionary class]]) {
            NSArray *datas = dataDic[@"cart_groups"];
            NSMutableArray *titleArray = [NSMutableArray array];
            
            _contentDictionary = [NSMutableDictionary dictionary];
            for (int i = 0; i < datas.count; i ++) {
                
                NSDictionary *dic = datas[i];
                NSArray *skusArray = dic[@"skus"];
                
                [titleArray addObject:dic[@"brand_title"]];
                
                
                NSMutableArray *array = [NSMutableArray array];
                for (int j = 0; j < skusArray.count; j ++) {
                    NSDictionary *skusDic = skusArray[j];
                    ZShoppingModel *model = [ZShoppingModel initWithModelDictionary:skusDic];
                    [array addObject:model];
                }
                [_contentDictionary setObject:array forKey:@(i)];
                self.titleArray = titleArray;
            }
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - collection view delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZShoppingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1.f;
    
    NSNumber *item = [NSNumber numberWithInteger:indexPath.item];
    cell.contentArray = self.contentDictionary[item];
    cell.titleString = self.titleArray[indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *item = [NSNumber numberWithInteger:indexPath.item];
    NSArray *array = self.contentDictionary[item];
    
    return CGSizeMake(ZFScreenWidth - 20, 120 * array.count + 35);
}

@end
