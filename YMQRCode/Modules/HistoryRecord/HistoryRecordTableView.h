//
//  HistoryRecordTableView.h
//  YMQRCode
//
//  Created by junhaoshen on 17/2/27.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryRecordDelegate <NSObject>

-(void)jumpQrcodeGeneration:(NSString *)content;

@end

@interface HistoryRecordTableView : UITableView

-(void)OnEditButton:(id)sender;

-(void)OnSubDeleteButton:(id)sender;

-(void)OnSubAllButton:(id)sender;

@property (strong ,nonatomic)UIView *bottomView;

@property (weak ,nonatomic)id<HistoryRecordDelegate>jumpDelegate;

@property (nonatomic ,assign)BOOL allowClick;


@end
