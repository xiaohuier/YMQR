//
//  HomePageViewController.m
//  YMQRCode
//
//  Created by 周正东 on 2017/1/25.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HomePageViewController.h"

#import "HomePageBodyView.h"
#import "HomePageHeaderView.h"
#import "AppDelegate.h"
#import "QRScanViewController.h"
#import "QRCodeProduceViewController.h"
#import "MoreViewController.h"
#import "HistoryRecordViewController.h"

@interface HomePageViewController ()<UITextViewDelegate,HomePageHeaderDelegate>
/**头部5个按钮*/
@property (nonatomic,strong)HomePageHeaderView *headerView;
/**中间接受输入的部分*/
@property (nonatomic,strong)HomePageBodyView *bodyView;
/**扫描按钮*/
@property (nonatomic,strong)UIButton *scanQRCodeButton;
/**生成二维码*/
@property (nonatomic,strong)UIButton *createQRCodeButton;

@end

@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self initSubViews];
    
}


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setu，p after loading the view.
    
    [self initNavigation];
    

}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
  
}

-(void)initNavigation
{
    self.title = @"二维码生成和扫描";

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"关于" style:UIBarButtonItemStylePlain target:self action:@selector(moreBarButton:)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.navigationItem.leftBarButtonItem.tintColor = RGB(41, 123, 231);
    
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"历史" style:UIBarButtonItemStylePlain target:self action:@selector(historyBarButton:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    self.navigationItem.rightBarButtonItem.tintColor = RGB(41, 123, 231);
    

}

-(void)initSubViews
{
    if (self.headerView) {
        [self.headerView removeFromSuperview];
        [self.bodyView  removeFromSuperview];
        [self.scanQRCodeButton removeFromSuperview];
        [self.createQRCodeButton removeFromSuperview];
    }
    
    self.headerView = [[HomePageHeaderView alloc]init];
    self.headerView.delegate = self;
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(220);
    }];
    
    self.bodyView = [HomePageBodyView bodyViewWithType:QRStringHTTPType];
    [self.view addSubview:self.bodyView];
    
    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.view.frame.size.height - 464);
    }];

    
    self.scanQRCodeButton = [[UIButton alloc]init];
    
    [self.scanQRCodeButton setBackgroundImage:[UIImage imageNamed:@"scanningImg"] forState:UIControlStateNormal];
    
    [self.scanQRCodeButton addTarget:self action:@selector(scanOnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.scanQRCodeButton];
    
    [self.scanQRCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 90));
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-90);
        
        make.top.mas_greaterThanOrEqualTo(self.bodyView.mas_bottom);

    }];

    
    self.createQRCodeButton = [[UIButton alloc]init];
    
    self.createQRCodeButton.backgroundColor = [UIColor grayColor];
    
    self.createQRCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.createQRCodeButton setBackgroundImage:[UIImage imageNamed:@"creatQRCode"] forState:UIControlStateNormal];
    
    [self.createQRCodeButton addTarget:self action:@selector(creatCodeOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.createQRCodeButton];
    
    [self.createQRCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (IS_IPHONE_5||IS_IPHONE_6||IS_IPHONE_4_OR_LESS) {
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
            
        }else{
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 99));
            
        }
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
        
        make.centerX.mas_equalTo(self.scanQRCodeButton.mas_centerX);
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    }];
    
}

-(void)moreBarButton:(id)sender
{
    MoreViewController *moreVC = [[MoreViewController alloc]init];
    
    [self.navigationController pushViewController:moreVC animated:YES];

}

-(void)historyBarButton:(id)sender
{
    HistoryRecordViewController *historyRecord = [[HistoryRecordViewController alloc]init];
    
    [self.navigationController pushViewController:historyRecord animated:YES];
}


-(void)scanOnClick:(id)sender
{
    QRScanViewController *scanVC = [[QRScanViewController alloc]init];
    
    [self.navigationController pushViewController:scanVC animated:NO];

}

-(void)creatCodeOnClick:(id)sender
{
    
    QRCodeProduceViewController *qrcode = [[QRCodeProduceViewController alloc]init];
    
    qrcode.textString = self.bodyView.textString;  
    qrcode.type = self.bodyView.type;
    
    [self.navigationController pushViewController:qrcode animated:NO];

}

-(void)homePageHeaderButtonChangeType:(QRStringType)qrStringType
{
    
    [self.bodyView removeFromSuperview];
    
    self.bodyView = [HomePageBodyView bodyViewWithType:qrStringType];
    [self.view addSubview:self.bodyView];
    

    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(0);
        //这时候代码self.automaticallyAdjustsScrollViewInsets = true;已经失效了。
        make.height.mas_equalTo(self.view.frame.size.height - 400);
    }];

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
