//
//  BookModel.h
//  YMQRCode
//
//  Created by 周正东 on 2017/3/7.
//  Copyright © 2017年 周正东. All rights reserved.
//

#import "BaseModel.h"

@interface HistoryBookModel : BaseModel
/**图书本地id*/
//@property(nonatomic,assign)long long id;
/**豆瓣图书id*/
@property(nonatomic,assign)long long doubanId;
/**ISBN10*/
@property(nonatomic,copy)NSString *isbn10;
/**ISBN13*/
@property(nonatomic,copy)NSString *isbn13;
/**图书名称*/
@property(nonatomic,copy)NSString *title;
/**图书豆瓣URL*/
@property(nonatomic,copy)NSString *doubanUrl;
/**图书封面URL*/
@property(nonatomic,copy)NSString *image;
/**出版社*/
@property(nonatomic,copy)NSString *publisher;
/**发行时间*/
@property(nonatomic,copy)NSString *pubdate;
/**价格*/
@property(nonatomic,copy)NSString *price;
/**书籍简介*/
@property(nonatomic,copy)NSString *summary;
/**作者介绍*/
@property(nonatomic,copy)NSString *authorIntro;
/**作者*/
@property(nonatomic,copy)NSArray *author;
/**译者*/
@property(nonatomic,copy)NSArray *translator;
/**标签*/
@property(nonatomic,copy)NSArray *tags;

@end
