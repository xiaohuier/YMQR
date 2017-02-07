//
//  ShareView.h
//  
//
//  Created by zyh on 14-9-5.
//  Mr_Zhaohy 修改 2015-05
//  Copyright (c) 2014年 com.erongdu.QZW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"
#import "WXApi.h"
#import "WeiboSDK.h"



@interface ShareView : UIView<WXApiDelegate>
{
    //底部全屏的view
     UIView * shareView;
}
/*
 分享链接
 标题
 内容
 
 微博分享的内容

 */
@property (copy) NSString * urlString,* titleString,* contentString,* weiboString,* isSelect;

@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImg;

@property (weak, nonatomic) IBOutlet UILabel *labelWords;

@property (weak, nonatomic) IBOutlet UILabel *share;


//图片
@property (strong) UIImage * shareImage;
/*
 viewController  基于视图控制器弹出
 */
-(void)shareViewController:(UIViewController*)viewController;
@end
