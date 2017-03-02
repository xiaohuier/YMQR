//
//  MoreViewController.m
//  YMQRCode
//
//  Created by junhaoshen on 17/2/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "MoreViewController.h"
#import "ShareView.h"
#import "MoreViewTableViewCell.h"


@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic)UITableView *currentTableView;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    [self initNavigation];
    
    [self initSubViews];
    
}
#pragma mark - Navigation
-(void)initNavigation{
    
    self.title = @"关于";
    
    UIButton *backBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"gray-back"] forState:UIControlStateNormal];
    [backBtn  sizeToFit];
    [backBtn addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}

-(void)initSubViews{
 
    _currentTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _currentTableView.alwaysBounceVertical = NO;
    
    _currentTableView.delegate = self;
    
    _currentTableView.dataSource = self;
    
    [self.view addSubview:_currentTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreViewTableViewCell *cell = [[MoreViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    
    switch (indexPath.row) {
        case 1:{
            
            cell.moreLabel.text = @"推荐给好友";

            cell.moreImageView.image = [UIImage imageNamed:@"right-button"];
            
        }
            break;
        case 2:{
            
            cell.moreLabel.text = @"给我评论";
            
            cell.moreImageView.image = [UIImage imageNamed:@"right-button"];
            
        }
            break;
        case 3:{
            
            cell.moreLabel.text = [NSString stringWithFormat:@"当前版本V%@",BUNDLE_VERSION];
            
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
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
    if (indexPath.row == 1) {
        
        ShareView* shareView =[[[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:self options:nil]lastObject];
        
        shareView.isSelect = @"0";
        
        shareView.urlString = @"https://itunes.apple.com/cn/app/mi-jin-she/id1111162244?mt=8";
        
        shareView.titleString = @"二维码的邀请";
        
        shareView.shareImage = [UIImage imageNamed:@"more_hy"];
        
        shareView.contentString = @"我正在用二维码生成与扫描！";
        
        shareView.weiboString = [NSString stringWithFormat:@"我正在用二维码生成与扫描%@",shareView.urlString];
        
        [shareView shareViewController:self];
        
    }else if (indexPath.row == 2){
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1111162244&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 200;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIImageView *headImageView = [[UIImageView  alloc]init];

    headImageView.image = [UIImage imageNamed:@"topImage"];

    return headImageView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
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

-(void)didTapBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
