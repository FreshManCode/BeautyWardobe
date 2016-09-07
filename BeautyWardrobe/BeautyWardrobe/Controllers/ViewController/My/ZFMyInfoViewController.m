
//
//  ZFMyInfoViewController.m
//  BeautyWardrobe
//
//  Created by ZhangJunjun on 16/5/31.
//  Copyright © 2016年 KingNet. All rights reserved.
//

#import "ZFMyInfoViewController.h"
#import "ZFMyInfoCell.h"
#import "NetwokeManager.h"
#import "ZFUserDefaults.h"
#import "ZFMyInfoModel.h"
#import <UIImageView+WebCache.h>
@interface ZFMyInfoViewController()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray *_titleArray;
    NSMutableArray *_contentArray;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImage *headImage;
@property (nonatomic,strong) ZFMyInfoModel *infoModel;
@end


@implementation ZFMyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)networkRequest {
    NSString *sessionID = [[ZFUserDefaults shareInstance]getAccessTokenWithKey:ZFUserSID];
    NSString *baseURL   = @"http://vapi.yuike.com/1.0/user/detail_ex.php?";
    NSString *rightPart = [NSString stringWithFormat:@"&mid=457465&sid=%@&yk_appid=1&yk_cbv=2.9.3.1&yk_pid=1&yk_user_id=5155032&sign=2ad5598f4e5b759db96f493eb54ed7ea",sessionID];
    NSString *urlString =[NSString stringWithFormat:@"%@%@",baseURL,rightPart];
    [NetwokeManager requestGetMethodURL:urlString parameters:nil uploadPreogerss:nil success:^(id data) {
        if ([data[@"ret"] integerValue]==0) {
            [self setSupSubViews];
            [self hanleWithResultDiationary:data[@"data"]];
        }else{
            [[NetwokeManager shareInstance]updateWindowsWithTitle:@"请检查参数问题" withTime:2.0f];
        }
    } failure:^(NSError *error) {
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"亲你的网络不太好啊" withTime:2.0f];
    }];
}

- (void)hanleWithResultDiationary:(NSDictionary *)dic {
    _infoModel = [[ZFMyInfoModel alloc]initWithDictionary:dic];
    [_tableView reloadData];

}

- (void)setSupSubViews {
    self.titleLabel.text = @"个人信息";
    _titleArray = [[NSMutableArray alloc]initWithObjects:@"头像",@"昵称",@"性别",@"生日",@"以下信息不公布",@"邮箱",@"手机",@"QQ",@"微信", nil];
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"button_back-iOS7"] forState:UIControlStateNormal];
    [self.rightButton setHidden:YES];
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [self getStartOriginY], ZFScreenWidth, ZFScreenHeight -[self getStartOriginY]) style:UITableViewStylePlain];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ZFRGBColor(231, 231, 231);
    }
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFMyInfoCell *cell = [ZFMyInfoCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        cell.cellType = ZFMyInfoCellTypeImage;
        NSData *data = [[NSData alloc]initWithContentsOfFile:[self headImageDocumentPath]];
        UIImage *image = [[UIImage alloc]initWithData:data];
        [cell.headImage setImage:image];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:_infoModel.user_image_url] placeholderImage:nil];
    }else if (indexPath.row==1){
        cell.cellType = ZFMyInfoCellTypeText;
        cell.rightLab.text = _infoModel.user_name;
    }else if (indexPath.row==4){
        cell.cellType = ZFMyInfoCellTypeOnlyText;
    }else if(indexPath.row ==6){
        cell.cellType = ZFMyInfoCellTypeText;
        cell.rightLab.text = _infoModel.login_phone;
    }else{
        cell.cellType = ZFMyInfoCellTypeText;
    }
    cell.leftLab.text = _titleArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0) {
        return 174/2.0;
    }else if (indexPath.row==4) {
        return 72/2.0;
    }else {
      return  104/2.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        [self appearActionSheet];
    }
}

- (void)appearActionSheet {
    UIActionSheet *action;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        action = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        
    }else{
        action = [[UIActionSheet alloc]initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    action.tag =100;
    [action showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag==100) {
        NSUInteger sourceType = 0;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //取消
                    return;
                    break;
                case 1:
                    //相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    //相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                default:
                    break;
            }
        }else{
            if (buttonIndex==0) {
                return;
            }else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        //跳转
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate =  (id)self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = sourceType;
        [self presentViewController:imagePicker animated:NO completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image) {
        [self uploadImage:image];
    }
    
}

- (void)uploadImage:(UIImage *)image {
    __weak typeof (self)weakSelf = self;
    [[NetwokeManager shareInstance]hudShowLoadingMessage:@"头像上传中"];
    NSString *urlTest = @"http://112.74.67.161:8080/foodOrder/service/file/upload.do";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:urlTest parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
        [formData appendPartWithFileData:data name:@"Filedata" fileName:fileName mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZFDEBUGLOG(@"%@",responseObject);
        [[NetwokeManager shareInstance]hudHiddenImmediately];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"头像上传成功" withTime:1.5f];
        [weakSelf saveImageToDocumentFile:image withName:kUserHeadImage];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZFDEBUGLOG(@"error:%@",error);
        [[NetwokeManager shareInstance]hudHiddenImmediately];
        [[NetwokeManager shareInstance]updateWindowsWithTitle:@"头像上传失败,请检查网络" withTime:2.0f];
    }];
}

- (void)saveImageToDocumentFile:(UIImage *)image withName:(NSString *)name{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [data writeToFile:[self headImageDocumentPath] atomically:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self networkRequest];
}

- (NSString *)headImageDocumentPath {
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:kUserHeadImage];
    return path;
}


@end
