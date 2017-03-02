//
//  MoreTableView.m
//  YMQRCode
//
//  Created by junhaoshen on 17/2/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "MoreTableView.h"
#import "ShareView.h"
#import <objc/runtime.h>
#import "MoreViewController.h"

@interface MoreTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic)UIViewController *presentViewController;

@end

@implementation MoreTableView

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if( self = [super initWithCoder:aDecoder] )
    {
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        
        self.dataSource = self;
        
        [self setCurrentController:[[MoreViewController alloc]init]];
        
        _presentViewController = [self currentViewController];
    }
    
    return self;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 4;
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
        
        ShareView* shareView =[[[NSBundle mainBundle]loadNibNamed:@"ShareView" owner:self options:nil]lastObject];
        
        shareView.isSelect = @"0";
        
        shareView.urlString = @"https://itunes.apple.com/cn/app/mi-jin-she/id1111162244?mt=8";
        
        shareView.titleString = @"二维码的邀请";
        
        shareView.shareImage = [UIImage imageNamed:@"more_hy"];
        
        shareView.contentString = @"我正在用二维码生成与扫描！";
        
        shareView.weiboString = [NSString stringWithFormat:@"我正在用二维码生成与扫描%@",shareView.urlString];
      
        [shareView shareViewController:_presentViewController];
        
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
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]) {
        
        _headImageView.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"headerImage"]];
        
    }
    
    _headImageView.frame = CGRectMake(SCREEN_WIDTH/2 - 35, 35, 80, 80);
    
    _headImageView.layer.masksToBounds = YES;
    
    _headImageView.layer.cornerRadius = 40;
    
    [view addSubview:_headImageView];
    
    UILabel *headerImageLabel = [[UILabel alloc]init];
    
    headerImageLabel.text = @"我的头像";
    
    headerImageLabel.center = CGPointMake(_headImageView.center.x, _headImageView.center.y + 62);
    
    headerImageLabel.textColor = WORDSCOLOR;
    
    headerImageLabel.textAlignment = NSTextAlignmentCenter;
    
    headerImageLabel.bounds = CGRectMake(0, 0, 80, 35);
    
    [view addSubview:headerImageLabel];
    
    UIControl *controButton = [[UIControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 35, 35, 80, 115)];
    
    [controButton addTarget:self action:@selector(myHeaderImageOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:controButton];
    
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(void)setCurrentController:(UIViewController *)currentViewController{
    
    return objc_setAssociatedObject(self, @selector(currentViewController), currentViewController, OBJC_ASSOCIATION_RETAIN);
    
}

-(UIViewController *)currentViewController{
    
    return objc_getAssociatedObject(self, _cmd);
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

-(void)myHeaderImageOnClick:(id)sender;{
    
    if ([self.moreDelegate respondsToSelector:@selector(myHeaderImage)]) {
        [self.moreDelegate myHeaderImage];
    }
    
}


@end
