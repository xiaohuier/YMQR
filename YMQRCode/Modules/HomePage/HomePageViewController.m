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
    
    
    
    [self versionBox];
    
    
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
        
        if (IS_IPHONE_6P) {
            
             make.height.mas_equalTo(240);
            
        }else if(IS_IPHONE_5||IS_IPHONE_4_OR_LESS){
            
             make.height.mas_equalTo(180);
            
        }else{
            
             make.height.mas_equalTo(220);
        }
        
       
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
        
        if (IS_IPHONE_4_OR_LESS||IS_IPHONE_5) {
             make.bottom.mas_equalTo(self.view.mas_bottom).offset(-70);
        }else{
            
             make.bottom.mas_equalTo(self.view.mas_bottom).offset(-90);
            
        }
        
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
            
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 90));
            
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

- (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&[comp1 month] == [comp2 month] &&[comp1 year]  == [comp2 year];
}

-(void)versionBox{
    
        NSDate *curDate = [NSDate date];
        
        NSUserDefaults * Defaultes = [NSUserDefaults standardUserDefaults];
        
        NSDate * currentDate = [Defaultes valueForKey:@"currentDate"];
        
        if ([self isSameDay:curDate date2:currentDate]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:curDate forKey:@"currentDate"];
            
        }else{
            
            [self judgeAppVersion];
            
            [[NSUserDefaults standardUserDefaults] setObject:curDate forKey:@"currentDate"];
            
        }
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"version"] intValue]) {
            
            [self judgeAppVersion];
            
        }
    
}

-(void)judgeAppVersion{
    
    NSString *URL = @"https://itunes.apple.com/lookup?id=1111162244";
    //以免有中文进行UTF编码
    NSString *UTFPathURL = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //请求路径
    NSURL *url = [NSURL URLWithString:UTFPathURL];
    //创建请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求超时
    request.timeoutInterval = 2;
    //创建session配置对象
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建session对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    //添加网络任务
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //        NSLog(@"网络请求开始->");
        if (error) {
            //            NSLog(@"请求失败...");
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
            //            NSLog(@"请求成功:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            //用苹果字典JSON解析(NSJSONSerialization) 解析JSON
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *array = [dataDict objectForKey:@"results"];
            
            NSDictionary *dict = array[0];
            
            NSString *storeVersion = [dict objectForKey:@"version"];
            
            if ([BUNDLE_VERSION isEqualToString:storeVersion]) {
                
                
                
            }else{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本更新" message:[dict objectForKey:@"releaseNotes"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *sureJump = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/mi-jin-she/id1226825199?mt=8"]];
                    
                    
                }];
                
                UIAlertAction *cancelJump = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                
                [alert addAction:sureJump];
                
                [alert addAction:cancelJump];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
            //            NSLog(@"解析JSON完毕:打印下看看%@",dict);
            
            NSNull *result = [dataDict objectForKey:@"result"];
            
            if (result == [NSNull null]) {
                
                UIAlertController *av = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络错误,请重试" preferredStyle:UIAlertControllerStyleAlert];
                
                [av addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                
                [self presentViewController:av animated:YES completion:nil];
                
            }else{
                
                //                NSDictionary *resultDict = (NSDictionary *)result;
                //                NSLog(@"请求成功数据已经,继续展示到界面中:%@",resultDict);
                
            }
        }
    }];
    //开始任务
    [task resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
