//
//  HistoryTableViewCell.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/16.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistoryTextModel.h"

@interface HistoryTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UIImageView *arrowsImageView;
@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)HistoryTextModel *model;

@end
