//
//  LeftViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "LeftViewController.h"
#import "UIViewController+MMDrawerController.h"


@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *_headImageView;
}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.mm_drawerController.maximumLeftDrawerWidth = SCREEN_WIDTH*5/8;
    
    [self initSubView];
}

-(void)initSubView
{
    UITableView *leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    
    leftTableView.delegate = self;
    
    leftTableView.dataSource = self;
    
    [self.view addSubview:leftTableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 3;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    
    cell.textLabel.textColor = WORDSCOLOR;
    
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"推荐给好友";
        }
            break;
        case 1:{
            cell.textLabel.text = @"给我评论";
        }
            break;
        case 2:{
            cell.textLabel.text = [NSString stringWithFormat:@"当前版本:%@",BUNDLE_VERSION];
        }
            break;
            
        default:
            break;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1 松开手选中颜色消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
    if (indexPath.row == 0) {
        
        
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        
    
    }else if (indexPath.row == 1){
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1111162244&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    
    _headImageView = [[UIImageView  alloc]init];
    
    _headImageView.layer.borderWidth = 3;
    
    _headImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    _headImageView.image = [UIImage imageNamed:@"register_bg"];
    
    _headImageView.frame = CGRectMake(15, 48, 70, 70);
    
    _headImageView.layer.masksToBounds = YES;
    
    _headImageView.layer.cornerRadius = 35;
    
    [view addSubview:_headImageView];
    
    UILabel *headerImageLabel = [[UILabel alloc]init];
    
    headerImageLabel.text = @"我的头像";
    
    headerImageLabel.center = CGPointMake(125, _headImageView.center.y);
    
    headerImageLabel.textColor = WORDSCOLOR;
    
    headerImageLabel.textAlignment = NSTextAlignmentRight;
    
    headerImageLabel.bounds = CGRectMake(0, 0, 80, 35);
    
    [view addSubview:headerImageLabel];
    
    UIControl *controButton = [[UIControl alloc]initWithFrame:CGRectMake(15, 40, 150, 70)];
    
    [controButton addTarget:self action:@selector(myHeaderImage) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:controButton];
    
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
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
    
    _headImageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

//控制分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        
    {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
        
    {
        
        [cell setPreservesSuperviewLayoutMargins:NO];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        
    {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
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
