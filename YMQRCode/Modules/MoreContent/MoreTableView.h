//
//  MoreTableView.h
//  YMQRCode
//
//  Created by junhaoshen on 17/2/22.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreTableViewDelegate <NSObject>

-(void)myHeaderImage;

@end

@interface MoreTableView : UITableView

@property (strong ,nonatomic)UIImageView *headImageView;

@property (weak ,nonatomic)id<MoreTableViewDelegate>moreDelegate;

@end
