//
//  HistoryRecordViewController.m
//  YMQRCode
//
//  Created by junhaoshen on 17/2/27.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryRecordViewController.h"
#import "HistoryRecordTableView.h"
#import "QRCodeProduceViewController.h"

@interface HistoryRecordViewController ()<HistoryRecordDelegate>

@property (strong ,nonatomic)HistoryRecordTableView *currentHistoryTableView;

@property (strong ,nonatomic)UIBarButtonItem *editButtonItem;

@property (strong ,nonatomic)UIBarButtonItem *deleteButtonItem;

@property (strong ,nonatomic)UIBarButtonItem *allSelectButtonItem;

@property (nonatomic ,assign)BOOL isShow;

@property (nonatomic ,assign)BOOL isAllShow;

@end

@implementation HistoryRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initSubViews];

}

-(void)initSubViews{
    
    self.title = @"历史记录";
    
    _editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(OnEditButton:)];

    self.navigationItem.rightBarButtonItem = _editButtonItem;
    
    _currentHistoryTableView = [[HistoryRecordTableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
    _currentHistoryTableView.jumpDelegate = self;
    
    [self.view addSubview:_currentHistoryTableView];
}

-(void)jumpQrcodeGeneration:(NSString *)content{
    
    QRCodeProduceViewController *qrcode = [[QRCodeProduceViewController alloc]init];
    
    qrcode.isPreservation = NO;
    
    qrcode.textString = content;
    
    [self.navigationController pushViewController:qrcode animated:NO];
    
}
// 编辑按钮
-(void)OnEditButton:(id)sender{

    _isShow = !_isShow;
    
    _currentHistoryTableView.allowClick = _isShow;
    
    if (_isShow) {
        
        self.currentHistoryTableView.bottomView.hidden = NO;
        
        [_editButtonItem setTitle:@"完成"];
        
    }else{
        
        [_editButtonItem setTitle:@"编辑"];
        
        self.currentHistoryTableView.bottomView.hidden = YES;
        
    }
    
    [_currentHistoryTableView OnEditButton:sender];
}
// 删除按钮
-(void)OnDeleteButton:(id)sender{

    [_currentHistoryTableView OnSubDeleteButton:sender];
    
}
// 全选按钮
-(void)OnAllButton:(id)sender{

    _isAllShow = !_isAllShow;
    
    if (_isAllShow) {
        
        [_allSelectButtonItem setTitle:@"全不选"];
        
    }else{
        
        [_allSelectButtonItem setTitle:@"全选"];
        
    }
    
    [_currentHistoryTableView OnSubAllButton:sender];

}

-(void)viewDidDisappear:(BOOL)animated{
    
    
    _currentHistoryTableView.bottomView.hidden = YES;
    
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
