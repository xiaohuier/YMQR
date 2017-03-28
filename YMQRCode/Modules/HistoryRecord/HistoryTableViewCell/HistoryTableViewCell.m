//
//  HistoryTableViewCell.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/16.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "TextModel.h"

@implementation HistoryTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:10.f];
        self.timeLabel.textColor = [UIColor grayColor];

        [self.contentView addSubview:self.timeLabel];
        
        self.contentLabel  = [[UILabel alloc]init];
        [self.contentView addSubview:self.contentLabel];
        
        self.arrowsImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.arrowsImageView];
        
      /*  self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.lineView];*/
        
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.arrowsImageView.mas_left);
        make.height.mas_equalTo(8);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(5);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(self.arrowsImageView.mas_left);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(5);
    }];
    
    [self.arrowsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.timeLabel.text = nil;
    self.contentLabel.text = nil;
    
    _model = nil;
}

-(void)setModel:(HistoryTextModel *)model
{
    _model = model;
    
    self.timeLabel.text = _model.date;
    
    
    TextModel *textModel = [TextModel yy_modelWithJSON:_model.jsonString];
    NSDictionary *dic = textModel.yy_modelToJSONObject;
    if (dic) {
        self.contentLabel.text = dic[@"text"];

    }else{
        self.contentLabel.text = _model.jsonString;
    }
}
@end
