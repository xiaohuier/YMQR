//
//  MoreViewTableViewCell.m
//  YMQRCode
//
//  Created by junhaoshen on 17/3/2.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "MoreViewTableViewCell.h"

@implementation MoreViewTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH/2, 50)];
        
        _moreLabel.textColor = UIColorFromRGB(666666);
        
        _moreLabel.textAlignment = NSTextAlignmentLeft;
        
        _moreLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:_moreLabel];
        
        _moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH  - 26, 18, 8, 14)];
        
        [self addSubview:_moreImageView];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
