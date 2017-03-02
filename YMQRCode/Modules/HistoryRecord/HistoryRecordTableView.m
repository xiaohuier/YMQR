//
//  HistoryRecordTableView.m
//  YMQRCode
//
//  Created by junhaoshen on 17/2/27.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryRecordTableView.h"
#import "QrcodeModel.h"

@interface HistoryRecordTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)NSMutableArray *myArray;

@property (nonatomic ,assign)BOOL isBool;

@property (nonatomic ,strong)UIButton *allButton;

@property (nonatomic ,strong)UIButton *deleteButton;

@property (nonatomic ,strong)QrcodeModel *qrcode;

@property (nonatomic ,strong)YMFMDatebase *database;

@property (strong ,nonatomic)UIViewController *presentViewController;

@end

@implementation HistoryRecordTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        
        self.dataSource = self;
        
        _myArray = [[NSMutableArray alloc]init];
        
        _database = [YMFMDatebase sharedYMFMDatabase];
        
        FMResultSet *resultSet =[_database selectFromTable:@"qrcodeTable" byParaName:nil  paraValue:nil];
        
        while ([resultSet next]) {
            
            _qrcode = [[QrcodeModel alloc]init];
            
            _qrcode.content = [resultSet stringForColumn:@"content"];
            _qrcode.time = [resultSet stringForColumn:@"time"];
            
            [_myArray addObject:_qrcode];
        }

        self.allowsMultipleSelectionDuringEditing = YES;
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        _bottomView.backgroundColor = RGB(41, 123, 241);
        
        [window addSubview:_bottomView];
        
        _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _allButton.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 50);
        
        [_allButton setTitle:@"全选" forState:UIControlStateNormal];
        
        [_allButton addTarget:self action:@selector(OnSubAllButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        
        [_deleteButton addTarget:self action:@selector(OnSubDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteButton.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 50);
        
        [_bottomView addSubview:_allButton];
        
        [_bottomView addSubview:_deleteButton];
        
        _bottomView.hidden = YES;
        
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return _myArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
        
    }

    cell.textLabel.text = [_myArray[indexPath.row] content];
    
    cell.detailTextLabel.text = [_myArray[indexPath.row] time];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_database deleteDataFromTable:@"qrcodeTable" byParaName:@"time" paraVulue:[self.myArray[indexPath.row]time]];
    
    // 删除模型
    [self.myArray removeObjectAtIndex:indexPath.row];
    
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (!self.allowClick) {
        
        if([_jumpDelegate respondsToSelector:@selector(jumpQrcodeGeneration:)]){
            
            [_jumpDelegate jumpQrcodeGeneration:[_myArray[indexPath.row]content]];
            
        }
        
    }else{
        
        [_deleteButton setTitle:[NSString stringWithFormat:@"删除(%lu)",(unsigned long)self.indexPathsForSelectedRows.count] forState:UIControlStateNormal];
        
    }

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.indexPathsForSelectedRows.count) {
        
        [_deleteButton setTitle:[NSString stringWithFormat:@"删除(%lu)",(unsigned long)self.indexPathsForSelectedRows.count] forState:UIControlStateNormal];

    }else{
        
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)OnEditButton:(id)sender;{
    
    [self setEditing:!self.isEditing animated:YES];
    
    [_allButton setTitle:@"全选" forState:UIControlStateNormal];
    
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
}

-(void)OnSubDeleteButton:(id)sender;{
    
    // 获得需要删除的酒模型数据
    NSMutableArray *deletedWineArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.indexPathsForSelectedRows) {
        [deletedWineArray addObject:self.myArray[indexPath.row]];
    }
    
    
    
    if(deletedWineArray.count){
        
        [_database deleteinTransactionDataFromTable:@"qrcodeTable" byParaName:@"time" paraVulue:deletedWineArray];
        
    }
    
    // 删除模型数据
    [self.myArray removeObjectsInArray:deletedWineArray];
    [self beginUpdates];
    
    // 刷新
    [self deleteRowsAtIndexPaths:self.indexPathsForSelectedRows withRowAnimation:UITableViewRowAnimationLeft];
    [self endUpdates];
    
    if (_isBool){
        
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        
    }
    
}

-(void)OnSubAllButton:(id)sender;{
    
    _isBool = !_isBool;
    
    if (_isBool) {
        
        [_allButton setTitle:@"全不选" forState:UIControlStateNormal];
        
        [_deleteButton setTitle:[NSString stringWithFormat:@"删除(%lu)",(unsigned long)self.myArray.count] forState:UIControlStateNormal];
    
        //通过遍历所有并选择
        for (int row=0; row<self.myArray.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }else{
   
        [_allButton setTitle:@"全选" forState:UIControlStateNormal];
        
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        
        //通过遍历所有并选择
        for (int row=0; row<self.myArray.count; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
            [self deselectRowAtIndexPath:indexPath animated:NO];
        }
        
    }
    
}

@end
