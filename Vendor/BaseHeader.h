//
//  BaseHeader.h
//  CRM
//
//  Created by Arthur on 15/11/23.
//  Copyright © 2015年 Arthur. All rights reserved.
//


#ifndef BaseHeader_h
#define BaseHeader_h

enum
{
    investment = 0,
    government = 1,
    resulting = 2
};



#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0

#define ZERO_FRAME_UIVIEW [[UIView alloc]initWithFrame:CGRectZero]
#define VIEWCONTROLLER_DEFAULT_HEIGHT 568
#define RGBA(R/*红*/,G/*绿*/,B/*蓝*/,A/*透明度*/)  [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define NAVBAR_HEIGHT 64
#define TABBAR_HEIGHT 49
#define ANIMATION_TIME 0.34
#define TIME_OUT 10
#define TIMEZONE 28800 //时区差 （8小时）
#define TIME_COUNT 1000

#define NETWORK_CONNECT_FAILURE @"网络连接失败"
#define GET_DATA_FAILURE @"获取数据失败"
#define  COMPARE_STRING   @"起始值不能大于终止值"

#define SelectedColor   RGBA(30, 144, 255, 1)
#define DEFAULT_COLOR @"#1BA1EE"
#define NormalColor     [UIColor lightGrayColor]
#define Default_HeaderImg [UIImage imageNamed:@"默认头像"]

#define UIColorFromRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kWindow  [UIApplication sharedApplication].keyWindow

#pragma mark - limitTextLength
#define Yzm_maxLength 6
#define Phone_maxLength 11
#define Password_maxLength 18
#define YZM_TIME 60

#define JsonInfoSuccessTrue [json[@"success"] boolValue]
#define JsonInfoResultCode [[json[@"result"] objectForKey:@"errCode"] boolValue]
#define JsonBodyStatusCode [[json[@"body"] objectForKey:@"status"] boolValue]
#define JsonBody (NSDictionary *)json[@"body"]


#define JsonBodySendID [[json[@"body"] objectForKey:@"sendID"] boolValue]


/**
 *  msg内容
 */
#define JsonInfoResultMsg (NSString *)[json[@"result"] objectForKey:@"msg"]

#define JsonBodyErrMsg (NSString *)[json[@"body"] objectForKey:@"errMsg"]

#define JsonInfoMsg  json[@"msg"]
#define JsonDictionaryResult  ((NSDictionary*)json[@"result"])
#define JsonDictionaryResultList ((NSArray*)JsonDictionaryResult[@"resultList"])
#define JsonArrayResult  ((NSArray*)json[@"result"])
#define JsonStringResult  json[@"result"]
#define JsonLastPage (([JsonDictionaryResult[@"currentPage"] integerValue])>=([JsonDictionaryResult[@"totalPages"] integerValue]))

//#define SERVER_IP @"http://192.168.1.89:9512"//测试1

#define SERVER_IP @"http://nikophonecs.mc916.com:82"//测试2



//登录
#define Login_URL @"/1_0/user/log.ashx"

//堆场集合
#define Yard_URL @"/1_0/sys/getYard.ashx"

//验证码
#define IdentifyCode_URL @"/1_0/sys/sendSms.ashx"

//通知消息
#define NotifyList_URL @"/1_0/notify/getnotifyList.ashx"

//通知处理
#define NotifyAction_URL @"/1_0/notify/setAction.ashx"

//主界面消息
#define NotiAndWait_URL @"/1_0/user/getNewCount.ashx"
//注册
#define Register_URL @"/1_0/user/reg.ashx"

//待办事项
#define AgencyList_URL @"/1_0/Agency/AgencyList.ashx"

//待办处理
#define AgencyAction_URL @"/1_0/Agency/setAction.ashx"


//落箱预报
#define DropBoxPrediction_URL @"/1_0/businessUn/getunload.ashx"

//新增预报
#define Prediction_ADD_URL @"/1_0/businessUn/setunload.ashx"

//落箱预报列表
#define DropBoxList_URL @"/1_0/businessUn/getunloadList.ashx"

//落箱明细
#define DropBoxDetail_URL @"/1_0/businessUn/getunloadInfo.ashx"

//进港带箱列表
#define EnterPortWithBoxList_URL @"/1_0/businessTa/getTakeboxList.ashx"

//带箱明细
#define WithBoxDetail_URL @"/1_0/businessTa/getTakeboxInfo.ashx"

//月结列表
#define SummaryList_URL @"/1_0/businessMonth/getMonthList.ashx"

//月结明细
#define SummaryDetail_URL @"/1_0/businessMonth/getMonthInfo.ashx"

//落箱预报时间
#define DropBoxSetDate_URL @"/1_0/businessUn/setunloadInfo.ashx"

//搜索车队
#define CarList_URL @"/1_0/businessUn/getCarList.ashx"

//搜索船队
#define ShipList_URL @"/1_0/businessUn/getshipList.ashx"

//应收列表
#define ReceiveableList_URL @"/1_0/Receivable/getList.ashx"

//支出列表
#define CostList_URL @"/1_0/Expenses/getExpensesList.ashx"

//支出明细
#define CostDetail_URL @"/1_0/Expenses/getExpensesInfo.ashx"

//支出详情
#define CostEntity_URL @"/1_0/Expenses/getExpensesEntity.ashx"

/**
 *  支出审核+删除
 */
#define CostVerify_URL @"/1_0/Expenses/setAction.ashx"

//支出新增
#define CostAdd_URL @"/1_0/Expenses/setExpensesAdd.ashx"

//支出科目
#define CourseList_URL @"/1_0/Expenses/getcourse.ashx"

//获取金额
#define GetAmount_URL @"/1_0/businessUn/getAmount.ashx"

//修改手表
#define ChangePassword_URL @"/1_0/user/Password.ashx"





#define Banner_URL @"/m/pics"


#endif /* BaseHeader_h */
