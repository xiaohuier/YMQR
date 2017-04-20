//
//  CardViewController.m
//  YMQRCode
//
//  Created by junhaoshen on 17/1/18.
//  Copyright © 2017年 junhaoshen. All rights reserved.
//

#import "CardViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface CardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UILabel *name;
@property (nonatomic ,strong)UILabel *companyName;
@property (nonatomic ,strong)UILabel *position;
@property (nonatomic ,strong)NSArray *messageArray;
@property (strong ,nonatomic)NSMutableDictionary *infoDictionary;
@property(strong ,nonatomic)UITableView *cardTabelView;

@end



@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"联系人";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _cardTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
    _cardTabelView.delegate = self;
    
    _cardTabelView.dataSource = self;
    
    [self.view addSubview:_cardTabelView];
    
    _messageArray = [self.cardMessage componentsSeparatedByString:@"\n"];
    
    _infoDictionary = [NSMutableDictionary dictionaryWithCapacity:8];
    [_infoDictionary setObject:[_messageArray[1] substringFromIndex:3] forKey:@"name"];
    [_infoDictionary setObject:[_messageArray[2] substringFromIndex:4] forKey:@"company"];
    [_infoDictionary setObject:[_messageArray[3] substringFromIndex:4] forKey:@"home"];
    [_infoDictionary setObject:[_messageArray[4] substringFromIndex:6] forKey:@"position"];
    [_infoDictionary setObject:[_messageArray[5] substringFromIndex:4] forKey:@"phone"];
    [_infoDictionary setObject:[_messageArray[6] substringFromIndex:4] forKey:@"url"];
    [_infoDictionary setObject:[_messageArray[7] substringFromIndex:6] forKey:@"email"];
    [_infoDictionary setObject:[_messageArray[8] substringFromIndex:5] forKey:@"remarks"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return 7;
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];

    switch (indexPath.row) {
        case 0:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            cell.textLabel.textColor = BLUECOLOR;
            
            cell.textLabel.text = @"电话";
            
            cell.detailTextLabel.text = [_messageArray[5] substringFromIndex:4];
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
         
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"开灯"]];

        }
            
            break;
        case 1:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            cell.textLabel.textColor = BLUECOLOR;
            cell.textLabel.text = @"电子邮箱";
            
            cell.detailTextLabel.text = [_messageArray[7] substringFromIndex:6];
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
        }
            
            break;
        case 2:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            cell.textLabel.textColor = BLUECOLOR
            
            cell.textLabel.text = @"首页";
            
            cell.detailTextLabel.text = [_messageArray[6] substringFromIndex:4];
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17];
        }
            
            break;
        case 3:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            
            UILabel *labelRemarks = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
            labelRemarks.text = @"住宅";
            labelRemarks.font = [UIFont systemFontOfSize:15];
            labelRemarks.textColor = BLUECOLOR
            
            [cell addSubview:labelRemarks];
            
            UILabel *detailRemarks = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(labelRemarks.frame) - 5, SCREEN_WIDTH - 30, cell.frame.size.height)];
            detailRemarks.numberOfLines = 0;
            detailRemarks.text = [_messageArray[3] substringFromIndex:4];
            [cell addSubview:detailRemarks];
            
        }
            
            break;
        case 4:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            
            UILabel *labelRemarks = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
            labelRemarks.text = @"备注";
            labelRemarks.font = [UIFont systemFontOfSize:15];
            labelRemarks.textColor = WORDSCOLOR;
            [cell addSubview:labelRemarks];
            
            UILabel *detailRemarks = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(labelRemarks.frame), SCREEN_WIDTH - 30, cell.frame.size.height)];
            detailRemarks.numberOfLines = 0;
            detailRemarks.text = [_messageArray[8] substringFromIndex:5];
            [cell addSubview:detailRemarks];
            
        }
            
            break;
        case 5:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            
            cell.textLabel.textColor = BLUECOLOR
            
            cell.textLabel.text = @"发送信息";
        }
            
            break;
        case 6:{
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            
            cell.textLabel.textColor =BLUECOLOR
            
            cell.textLabel.text = @"创建新联系人";
        }
            
            break;
//        case 7:{
//            
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
//            
//            cell.textLabel.font = [UIFont systemFontOfSize:17];
//            
//            cell.textLabel.textColor = BLUECOLOR
//            
//            cell.textLabel.text = @"添加到现有联系人";
//        }
//            
//            break;
            
        default:
            break;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 1 松开手选中颜色消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    
    
    switch (indexPath.row) {
        case 0:{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_messageArray[4] substringFromIndex:6]]];
            
        }
            
            break;
        case 1:{
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_messageArray[7] substringFromIndex:6]]];
            
        }
            
            break;
        case 2:{
            
            NSArray *array = [_messageArray[5] componentsSeparatedByString:@":"];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:array[1]]];
            
        }
            
            break;
        case 3:{
            
            
            
        }
            
            break;
        case 4:{
            
            
            
        }
            
            break;
        case 5:{
            
            NSArray *array = [_messageArray[5] componentsSeparatedByString:@":"];
        
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",array[1]]]];
            
        }
            
            break;
        case 6:{
            
            
            [self gotoAddContacts];
   
            
        }
            
            break;
//        case 7:{
//            
//            
//            
//        }
//            
//            break;
            
        default:
            break;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        
        if ([self sizeWithText:[_messageArray[8] substringFromIndex:5] font:[UIFont systemFontOfSize:17]].height > 76.0) {
            
            return [self sizeWithText:[_messageArray[8] substringFromIndex:5] font:[UIFont systemFontOfSize:17]].height;
            
        }else{
            
            return 76;
        }
        
    }else if (indexPath.row == 5||indexPath.row == 6||indexPath.row == 7){
        
        return 45;
        
    }else if (indexPath.row == 3){
        
        if ([self sizeWithText:[_messageArray[3] substringFromIndex:4] font:[UIFont systemFontOfSize:17]].height > 60.0) {
            
            return [self sizeWithText:[_messageArray[3] substringFromIndex:4] font:[UIFont systemFontOfSize:17]].height;
            
        }else{
            
            return 60;
        }
        
    }else{
        
        return 60;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
     return 108;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    
    view.backgroundColor = [UIColor whiteColor];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(15, 19, SCREEN_WIDTH - 30, 25)];
    
    _companyName = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_name.frame) - 5, SCREEN_WIDTH - 30, 25)];
    
    _position = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_companyName.frame) - 5, SCREEN_WIDTH - 30, 25)];
    
    _name.font = _companyName.font = _position.font = [UIFont systemFontOfSize:15];
    
    _name.textColor = [UIColor blackColor];
    
    _companyName.textColor = _position.textColor = WORDSCOLOR;
    
    _name.text = [_messageArray[1] substringFromIndex:3];
    _companyName.text = [_messageArray[2] substringFromIndex:4];
    _position.text = [_messageArray[4] substringFromIndex:6];
    
    [view addSubview:_name];
    
    [view addSubview:_companyName];
    
    [view addSubview:_position];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

-(void)interfaceSetup{
    
    
    

    
    
    
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxWidth:200];
}
/// 根据指定文本,字体和最大宽度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}

//联系人
- (void)gotoAddContacts{
    
    //添加到通讯录,判断通讯录是否存在
    if ([self isExistContactPerson]) {//存在，返回
        //提示
        if (IOS8_0) {
            UIAlertController *tipVc  = [UIAlertController alertControllerWithTitle:@"提示" message:@"联系人已存在..." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [tipVc addAction:cancleAction];
            [self presentViewController:tipVc animated:YES completion:nil];
        }else{
            UIAlertView *tip = [[UIAlertView alloc] initWithTitle:@"提示" message:@"联系人已存在..." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [tip show];
            //        [tip release];
        }
        return;
    }else{//不存在  添加
        [self creatNewRecord];
    }
}

- (BOOL)isExistContactPerson{
    //这个变量用于记录授权是否成功，即用户是否允许我们访问通讯录
    int __block tip=0;
    
    BOOL __block isExist = NO;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if (IOS8_0) {
        //创建通讯簿的引用，第一个参数暂时写NULL，官方文档就是这么说的，后续会有用，第二个参数是error参数
        CFErrorRef error = NULL;
        addBook=ABAddressBookCreateWithOptions(NULL, &error);
        //创建一个初始信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (!greanted) {
                tip=1;
                
            }else{
                //获取所有联系人的数组
                CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
                //获取联系人总数
                CFIndex number = ABAddressBookGetPersonCount(addBook);
                //进行遍历
                for (NSInteger i=0; i<number; i++) {
                    //获取联系人对象的引用
                    ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
                    //获取当前联系人名字
                    NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
                    
                    NSLog(@" %ld  %@ ",(long)i,firstName);
                    
                    
//                    if ([firstName isEqualToString:[_infoDictionary objectForKey:@"name"]]) {
//                        isExist = YES;
//                    }
                }
 
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        
        //IOS6之前
        addBook =ABAddressBookCreate();
        
        //获取所有联系人的数组
        CFArrayRef allLinkPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
        //获取联系人总数
        CFIndex number = ABAddressBookGetPersonCount(addBook);
        //进行遍历
        for (NSInteger i=0; i<number; i++) {
            //获取联系人对象的引用
            ABRecordRef  people = CFArrayGetValueAtIndex(allLinkPeople, i);
            //获取当前联系人名字
            NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
            
            if ([firstName isEqualToString:[_infoDictionary objectForKey:@"name"]]) {
                isExist = YES;
            }
        }
    }
    
    if (tip) {
        //设置提示
        if (IOS8_0) {
            UIAlertController *tipVc  = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [tipVc addAction:cancleAction];
            [tipVc presentViewController:tipVc animated:YES completion:nil];
        }else{
            UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            
        }
    }
    return isExist;
}

//创建新的联系人
- (void)creatNewRecord
{
    CFErrorRef error = NULL;
    
    //创建一个通讯录操作对象
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    //创建一条新的联系人纪录
    ABRecordRef newRecord = ABPersonCreate();
    
    NSString *name = [_infoDictionary objectForKey:@"name"];
    
    //为新联系人记录添加属性值
    ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)name, &error);
    
    NSString *phone = [_infoDictionary objectForKey:@"phone"];
    
    //创建一个多值属性(电话)
    ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phone, kABPersonPhoneMobileLabel, NULL);
    ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
    
    NSString *email = [_infoDictionary objectForKey:@"email"];
    
    //添加email
    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)(email), kABWorkLabel, NULL);
    ABRecordSetValue(newRecord, kABPersonEmailProperty, multiEmail, &error);

    NSString *url = [_infoDictionary objectForKey:@"url"];
    
    //添加URL
    ABMutableMultiValueRef multiURL = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiURL, (__bridge CFTypeRef)(url), kABPersonHomePageLabel, NULL);
    ABRecordSetValue(newRecord, kABPersonURLProperty, multiURL, &error);

    NSString *home = [_infoDictionary objectForKey:@"home"];
    
    NSDictionary *addressDict = [NSDictionary dictionaryWithObjectsAndKeys:home, kABPersonAddressStreetKey, nil];
    
    //添加home家庭住址
    ABMutableMultiValueRef multiHome = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(multiHome, (__bridge CFTypeRef)(addressDict), kABPersonAddressStreetKey, NULL);
    
    ABRecordSetValue(newRecord, kABPersonAddressProperty, multiHome, &error);

    NSString *remarks = [_infoDictionary objectForKey:@"remarks"];

    //添加remarks备注
    ABRecordSetValue(newRecord, kABPersonNoteProperty, (__bridge CFTypeRef)remarks, &error);
    
    
    NSString *company = [_infoDictionary objectForKey:@"company"];
    
    //添加company公司名
    ABRecordSetValue(newRecord, kABPersonOrganizationProperty, (__bridge CFTypeRef)company, &error);

    NSString *position = [_infoDictionary objectForKey:@"position"];
    
    //添加position职位
    ABRecordSetValue(newRecord, kABPersonJobTitleProperty, (__bridge CFTypeRef)position, &error);

    //添加记录到通讯录操作对象
    ABAddressBookAddRecord(addressBook, newRecord, &error);
    
    //保存通讯录操作对象
    ABAddressBookSave(addressBook, &error);
    
    //通过此接口访问系统通讯录
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        
        if (granted) {
            //显示提示
            if (IOS8_0) {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"添加成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }];
                [alertVc addAction:alertAction];
                [self presentViewController:alertVc animated:YES completion:nil];
                
            }else{
                
                UIAlertView *tipView = [[UIAlertView alloc] initWithTitle:nil message:@"添加成功" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [tipView show];
                
            }
        }
    });
    
    CFRelease(multiEmail);
    CFRelease(multi);
    CFRelease(newRecord);
    CFRelease(addressBook);
    CFRelease(multiURL);
    CFRelease(multiHome);



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
