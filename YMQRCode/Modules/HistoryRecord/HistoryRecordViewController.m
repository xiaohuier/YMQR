//
//  HistoryRecordViewController.m
//  YMQRCode
//
//  Created by junhaoshen on 17/2/27.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryRecordViewController.h"

#import "QRCodeProduceViewController.h"

#import "HistoryService.h"
#import "HistoryTextModel.h"

#import "HistoryTableViewCell.h"

#import "HistoryBookTableViewCell.h"

#import <SVPullToRefresh.h>

static NSString * const identifier   = @"HistoryTableViewCell";

static NSString * const bookIdentifier = @"HistoryBookTableViewCell";

@interface HistoryRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray * dataArray;

@property (nonatomic,assign)QRHistoryType type;

@property (nonatomic,assign)NSInteger count;

@property (nonatomic,assign)NSInteger offset;

@end

@implementation HistoryRecordViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.type = QRHistoryCreatType;
        self.count = 30;
        self.offset = 0;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initNavigation];
    
    [self initSubViews];
    
    [self loadData];
    
}

-(void)initNavigation
{
    self.title = @"历史记录";
    
    UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除记录" style:UIBarButtonItemStylePlain target:self action:@selector(onEditButton:)];
    
    self.navigationItem.rightBarButtonItem = editButtonItem;
}

-(void)initSubViews
{
    
    NSArray *SegmentedControlArray = @[@"创建",@"扫描",@"图书"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:SegmentedControlArray];
    segmentedControl.frame = CGRectMake((self.view.bounds.size.width - 270)/2, 18, 270, 30);
    segmentedControl.selectedSegmentIndex = 0;
    
    [segmentedControl addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segmentedControl];
    
    
    self.tableView = [[UITableView alloc]initWithFrame: CGRectMake(0, 48, self.view.bounds.size.width, self.view.bounds.size.height - 48) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[HistoryTableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.tableView registerClass:[HistoryBookTableViewCell class] forCellReuseIdentifier:bookIdentifier];
    
    [self.view addSubview:self.tableView];
    
//    typeof(self) weakSelf = self;
    
//    [self.tableView addInfiniteScrollingWithActionHandler:^{
//        _offset =_offset + _count;
//        [weakSelf loadData];
//        [weakSelf.tableView.infiniteScrollingView stopAnimating];
//    }];
  
}

-(void)changeType:(UISegmentedControl *)control
{
    self.type = control.selectedSegmentIndex;
    
    self.offset = 0;
    
    [self loadData];
}

-(void)loadData
{
   
    switch (self.type) {
        case QRHistoryCreatType:
            self.dataArray = [HistoryService selectHistoryTextCount:self.count offset:self.offset];
            break;
        case QRHistoryScanType:
            self.dataArray = [HistoryService selectHistoryScanTextCount:self.count offset:self.offset];
            break;
        case QRHistoryBookType:
            self.dataArray = [HistoryService selectHistoryScanBookCount:self.count offset:self.offset];
            break;
    }
    
    [self.tableView reloadData];
}

-(void)addMoreData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == QRHistoryBookType)
    {
        HistoryBookTableViewCell *cell = (HistoryBookTableViewCell *)[tableView dequeueReusableCellWithIdentifier:bookIdentifier];
        
        HistoryBookModel *model = self.dataArray[indexPath.row];
        
        if (cell == nil) {
            cell = [[HistoryBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.model = model;
        return cell;
        
    }else{
        HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        HistoryTextModel *model = self.dataArray[indexPath.row];
        
        if (cell == nil) {
            cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.model = model;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == QRHistoryBookType) {
        return 100.0f;
    }else{
        return 44.f;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *activityItems =@[self.dataArray[indexPath.row]];
    
    UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:vc animated:TRUE completion:nil];
    
}

-(void)onEditButton:(id)sender
{
    [HistoryService deleteAllData:self.type];
    self.dataArray = nil;
    
    [self.tableView reloadData];
}

@end
