//
//  HistoryBookTableViewCell.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistoryBookModel.h"

@interface HistoryBookTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *coverImageView;
@property (nonatomic,strong) UILabel *authorLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *tagsView;

@property (nonatomic,strong) HistoryBookModel *model;

@end
