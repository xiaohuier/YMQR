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

@interface HomePageViewController ()<UITextViewDelegate,HomePageHeaderDelegate>
/**头部5个按钮*/
@property (nonatomic,strong)HomePageHeaderView *headerView;
/**中间接受输入的部分*/
@property (nonatomic,strong)HomePageBodyView *bodyView;
/**扫描按钮*/
@property (nonatomic,strong)UIButton *scanQRCodeButton;
/**生成二维码*/
@property (nonatomic,strong)UIButton *createQRCodeButton;

@property (nonatomic,strong)UIView *myBodyVeiw;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigation];
    [self initSubViews];

}

-(void)initNavigation
{
    self.title = @"二维码生成和扫描";
    
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //    leftButton.backgroundColor = [UIColor orangeColor];
    
    leftButton.frame = CGRectMake(0, 0, 29, 22);
    
    [leftButton addTarget:self action:@selector(sideSlipOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"navigationImg"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];;
    
    self.navigationItem.leftBarButtonItem=leftBarItem;
}

-(void)initSubViews
{
    self.headerView = [[HomePageHeaderView alloc]init];
    self.headerView.delegate = self;
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(220);
    }];

    _myBodyVeiw = [[UIView alloc]init];
    _myBodyVeiw.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_myBodyVeiw];
    
    
    [self.myBodyVeiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(0);
    }];
    
    self.scanQRCodeButton = [[UIButton alloc]init];
    
    [self.scanQRCodeButton setBackgroundImage:[UIImage imageNamed:@"scanningImg"] forState:UIControlStateNormal];
    
    [self.scanQRCodeButton addTarget:self action:@selector(scanOnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.scanQRCodeButton];
    
    [self.scanQRCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(90, 90));
        
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.bottom.equalTo(self.view.mas_bottom).offset(-90);
        
        make.top.mas_equalTo(self.myBodyVeiw.mas_bottom);

    }];
    
    
    self.createQRCodeButton = [[UIButton alloc]init];
    
    self.createQRCodeButton.backgroundColor = [UIColor grayColor];
    
    self.createQRCodeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [self.createQRCodeButton setBackgroundImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    
    [self.createQRCodeButton addTarget:self action:@selector(creatCodeOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.createQRCodeButton];
    
    [self.createQRCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (IS_IPHONE_5||IS_IPHONE_6||IS_IPHONE_4_OR_LESS) {
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
            
        }else{
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 99));
            
        }
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
        
        make.centerX.equalTo(self.scanQRCodeButton.mas_centerX);
        
        make.bottom.equalTo(self.view.mas_bottom).offset(0);

    }];
    
}

-(void)sideSlipOnClick:(id)sender
{
    
}

-(void)scanOnClick:(id)sender
{
    
}

-(void)creatCodeOnClick:(id)sender
{
    
}


-(void)buttonOnclick
{
    
    [self.bodyView removeFromSuperview];
    
    self.bodyView = [[HomePageBodyView alloc]initWithType:self.headerView.homePageBodyType];
    [self.myBodyVeiw addSubview:self.bodyView];
    self.bodyView.backgroundColor = [UIColor blueColor];
    
    [self.bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.top.bottom.mas_equalTo(0);
        
    }];
    
    
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
