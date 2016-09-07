//
//  ZFTaoBaoImageViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/19.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFTaoBaoImageViewController.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ZFTaoBaoImageViewController ()
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *saveImageBtn;
@property (nonatomic,strong) UIImageView *paperImage;

@end

@implementation ZFTaoBaoImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
}

- (void)setUpSubViews {
    if (!_paperImage) {
        _paperImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 302/2.0, ZFScreenWidth, ZFScreenHeight-302)];
        [_paperImage sd_setImageWithURL:[NSURL URLWithString:_mobileModel.content] placeholderImage:nil];
    }
    [self.view addSubview:_paperImage];
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(18.0, 50/2.0, 45, 45)];
        _backBtn.tag = 10;
        [_backBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"button_xback"] forState:UIControlStateNormal];
    }
    [self.view addSubview:_backBtn];
    
    if (!_saveImageBtn) {
        _saveImageBtn = [[UIButton alloc]initWithFrame:CGRectMake(ZFScreenWidth-48-15, 50/2.0, 45, 45)];
        _saveImageBtn.tag =11;
        [_saveImageBtn setBackgroundImage:[UIImage imageNamed:@"button_save_image"] forState:UIControlStateNormal];
        [_saveImageBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:_saveImageBtn];

}
- (void)clickEvent:(UIButton *)sender {
    if (sender.tag==10) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //下载图片
        [_paperImage sd_setImageWithURL:[NSURL URLWithString:_mobileModel.content] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self createAlbumWithImage:image];
        }];
        
    }
}

- (void)createAlbumWithImage:(UIImage *)image {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
    NSMutableArray *groups = [[NSMutableArray alloc]init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlcok = ^(ALAssetsGroup *group,BOOL *stop){
        if (group) {
            [groups addObject:group];
        }else{
            BOOL haveHUDGroup = NO;
            for(ALAssetsGroup *gp in groups){
                NSString *name = [gp valueForProperty:ALAssetsGroupPropertyName];
                if ([name isEqualToString:@"BeautyWardrobe"]) {
                    haveHUDGroup = YES;
                }
            }
            if (!haveHUDGroup) {
                [assetsLibrary addAssetsGroupAlbumWithName:@"BeautyWardrobe" resultBlock:^(ALAssetsGroup *group) {
                    [groups addObject:group];
                } failureBlock:^(NSError *error) {
                }];
                haveHUDGroup = YES;
            }
        }
    };
    
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlcok failureBlock:nil];
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(image) customAlbumName:@"BeautyWardrobe" completionBlock:^{
        [ZFPublic updateWindowsWithTitle:@"保存成功" withTime:1.0];
    } failureBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([error.localizedDescription rangeOfString:@"User denied access"].location !=NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location !=NSNotFound ) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                [alert show];
            }
        });
    }];
    
    
}

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata imageData:(NSData *)imageData customAlbumName:(NSString *)customAlbumName completionBlock:(void(^)(void))completionBlock failureBlock:(void(^)(NSError *error))failureBlock {
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
    __weak ALAssetsLibrary *weakSelf = assetsLibrary;
    
    void(^AddAsset)(ALAssetsLibrary *,NSURL *) = ^(ALAssetsLibrary *assetsLibrary,NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if ([[group valueForProperty:ALAssetsGroupPropertyName]isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
            
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(weakSelf,assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakSelf,assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self.view setBackgroundColor:[UIColor blackColor]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
