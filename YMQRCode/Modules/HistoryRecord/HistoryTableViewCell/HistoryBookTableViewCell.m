//
//  HistoryBookTableViewCell.m
//  YMQRCode
//
//  Created by 周正东 on 2017/3/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "HistoryBookTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HistoryBookTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews
{
    self.contentView.backgroundColor = UIColorFromRGB(0xF9F9F9);
    
    self.coverImageView = [[UIImageView alloc]init];
    self.coverImageView.backgroundColor = [UIColor whiteColor];
    self.coverImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(70);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    self.titleLabel.textColor = UIColorFromRGB(0x555555);
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImageView.mas_right).mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.right.mas_lessThanOrEqualTo(-15);
    }];
    
    self.authorLabel = [[UILabel alloc]init];
    self.authorLabel.font = [UIFont systemFontOfSize:13.0f];
    self.authorLabel.textColor = UIColorFromRGB(0x999999);
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.authorLabel];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_equalTo(6);
        make.left.mas_equalTo(self.coverImageView.mas_right).mas_equalTo(15);
        make.right.mas_lessThanOrEqualTo(-15);
    }];
    
    self.tagsView = [[UIView alloc]init];
    self.tagsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.tagsView];
    [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authorLabel.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(self.coverImageView.mas_right).mas_equalTo(15);
        make.height.mas_equalTo(18);
        make.right.mas_lessThanOrEqualTo(-15);
    }];
}

-(void)prepareForReuse
{
    self.titleLabel.text = nil;
    self.coverImageView.image = nil;
    self.authorLabel.text = nil;
    
    [self.tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _model = nil;
    
    [super prepareForReuse];
    
}

-(void)setModel:(HistoryBookModel *)model
{
    self.titleLabel.text = model.title;
    NSString *authorList = @"";
    for (NSString *author in model.author) {
        authorList = [[authorList stringByAppendingString:author] stringByAppendingString:@" "];
    }
    self.authorLabel.text = [NSString stringWithFormat:@"作者： %@",authorList];
    
    UIView *lastDockView = self.tagsView;
    
    for (int i = 0; i<MIN(model.tags.count, 4); i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        btn.layer.cornerRadius = 2.0f;
        btn.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        btn.layer.borderWidth = 0.5f;
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn setTitle:model.tags[i] forState:UIControlStateNormal];
        
        [self.tagsView addSubview:btn];
        if (i== 0 ) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.centerY.mas_equalTo(self.tagsView.mas_centerY);
            }];
        }else if (i == MIN(model.tags.count, 4) - 1){
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastDockView.mas_right).mas_offset(8);
                make.centerY.mas_equalTo(self.tagsView.mas_centerY);
                make.right.mas_equalTo(self.tagsView.mas_right).mas_offset(0);            }];
        }else{
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(lastDockView.mas_right).mas_offset(8);
                make.centerY.mas_equalTo(self.tagsView.mas_centerY);
            }];
        }
        [btn sizeToFit];
        [btn setContentEdgeInsets:UIEdgeInsetsMake(3.0f, 5.0f, 3.0f, 5.0f)];
        lastDockView =btn;
    }
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];

    
}
@end
