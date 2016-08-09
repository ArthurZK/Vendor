//
//  User.m
//  CRM
//
//  Created by Arthur on 15/12/15.
//  Copyright © 2015年 Arthur. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "User.h"
#import "BaseHeader.h"
@implementation User
+(User *)shareUser
{
    static User *user = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        user = [[self alloc] init];
    });
    return user;
    
}
-(NSDictionary *)locationDic
{
    if (_locationDic == nil)
    {
        _locationDic = [[NSMutableDictionary alloc]init];
    }
    return _locationDic;
}

/**
 *  堆场dic
 */

+ (NSDictionary *)userYardDic
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userTypeDic = [userDefaults objectForKey:@"yardDic"];
    return userTypeDic;
}

/**
 *  用户类型Dic
 */
+ (NSDictionary *)userUserTypeDic
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userTypeDic = [userDefaults objectForKey:@"userTypeDic"];
    return userTypeDic;
}

+(NSNumber *)userUID{ //获取User_UID
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * userUID =  [userDefaults objectForKey:@"userID"];
    return userUID;
}
+(NSString *)userName{//获取用户名
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* userName =  [userDefaults objectForKey:@"userName"];
    return userName;
}


+(NSString *)userPassword{//获取密码
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* userName =  [userDefaults objectForKey:@"userPassword"];
    return userName;
}
+(NSString *)userPhoneNum{//用户绑定的手机号
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* userPhoneNum =  [userDefaults objectForKey:@"mobileNumber"];
    return userPhoneNum;
}
+(NSNumber *)userType{//用户部门
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber* depart =  [userDefaults objectForKey:@"userType"];
    return depart;
}
+(NSString*)yardID{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* duty =  [userDefaults objectForKey:@"yardID"];
    return duty;
}
+(NSString *)yardName
{//accesstoken
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token =  [userDefaults objectForKey:@"yardName"];
    return token;
}
+(long long)convertDateToTimestamp{//当前时间戳
    NSDate *datenow = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    long long currentTime = (long long)(([localeDate timeIntervalSince1970]-TIMEZONE)*TIME_COUNT);
    return currentTime;
}
+(NSString *)userHeaderImgUrl{ //用户头像
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* headerImg =  [userDefaults objectForKey:@"headImg"];
    return headerImg;
}
/**
 *  按照格式转码时间
 *
 *  @param format  @"yyyy-MM-dd HH:mm:ss",@"yyyy-MM-dd HH:mm",@"yyyy-MM-dd EEE",@"yyyy-MM-dd",@"MM-dd"
 *  @param timeNum NSNumebr
 *
 *  @return NSString
 */
+(NSString *)timeNumberChangeToStringWithFormat:(NSString *)format Number:(NSNumber *)timeNum
{
    NSTimeInterval time=[timeNum doubleValue]+TIMEZONE;
    NSDate *confromTimesp =  [NSDate dateWithTimeIntervalSince1970:time/TIME_COUNT];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *showtimeNew = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:confromTimesp]];
    return showtimeNew;
}

+(NSNumber *)dateStringChangeToNumber:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSNumber *timeNumber = [NSNumber numberWithDouble:[date timeIntervalSinceReferenceDate]];
    return timeNumber;
}

+(NSNumber *)dateStringAllDayChangeToNumber:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSNumber *timeNumber = [NSNumber numberWithDouble:[date timeIntervalSinceReferenceDate]];
    return timeNumber;
}
+(long long)dateStringChangeToTimeStemp:(NSString *)timeStr
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    long long currentTime = (long long)(([localeDate timeIntervalSince1970]-TIMEZONE)*TIME_COUNT);
    return currentTime;
}

+(NSString *)dateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *showtimeNew = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
    return showtimeNew;
}

/**
 *  计算字符串长度
 *
 *  @param strtemp string
 *
 *  @return int
 */
+(int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    int result = (strlength+1)/2;
    return result;
}
+(void)deleteReadMessagesWithAssociateId:(NSNumber *)associateId
{
    NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
    NSArray *pushArray = [userDefult objectForKey:[User userUID]];
    NSMutableArray *pushArray1 = [pushArray mutableCopy];
    for (NSDictionary *dic in pushArray)
    {
        if (dic[@"_j_msgid"] == associateId ||
            dic[@"associateId"] == nil )
        {
            [pushArray1 removeObject:dic];
        }
    }
    [userDefult setValue:pushArray1 forKey:[User userUID]];
//    NSNotification *noti =[[NSNotification alloc]initWithName:@"tapNum" object:nil userInfo:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:noti];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tabNoti" object:nil userInfo:nil];
}
+(long long)dateStringChangeToTimeStempWithSecond:(NSString *)timeStr
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    long long currentTime = (long long)(([localeDate timeIntervalSince1970]-TIMEZONE)*TIME_COUNT);
    return currentTime;
}
+ (NSString *)changeToString:(NSObject *)whatever
{
    return [whatever isKindOfClass:[NSNull class]] ? @"" :  [NSString stringWithFormat:@"%@",whatever];
}

@end
