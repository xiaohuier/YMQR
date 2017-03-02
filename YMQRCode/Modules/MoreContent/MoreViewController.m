//
//  MoreViewController.m
//  YMQRCode
//
//  Created by junhaoshen on 17/2/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableView.h"


@interface MoreViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MoreTableViewDelegate>

@property (strong ,nonatomic)MoreTableView *currentTableView;

@end

@implementation MoreViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [self initSubViews];
    
}

-(void)initSubViews{
    
    self.title = @"关于";
    
    _currentTableView = [[MoreTableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _currentTableView.moreDelegate = self;
    
//    [self myHeaderImage];
    
    [self.view addSubview:_currentTableView];
}

-(void)myHeaderImage{
    
    UIImagePickerController *imagrPicker = [[UIImagePickerController alloc]init];
    imagrPicker.delegate = self;
    imagrPicker.allowsEditing = YES;
    //将来源设置为相册
    imagrPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagrPicker animated:YES completion:nil];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取选中的照片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    _currentTableView.headImageView.image = image;
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(image) forKey:@"headerImage"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
