//
//  User.h
//  CRM
//
//  Created by Arthur on 15/12/15.
//  Copyright © 2015年 Arthur. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(strong,nonatomic)NSDictionary *locationDic;//地点字典
+(User *)shareUser;
/** *用户UID */
+(NSNumber *)userUID;

/**
 *  堆场dic
 */

+ (NSDictionary *)userYardDic;

/**
 *  用户类型Dic
 */
+ (NSDictionary *)userUserTypeDic;
/** *用户名 */
+(NSString *)userName;

/** *用户手机号 */
+(NSString *)userPhoneNum;

/** *用户类型 */
+(NSNumber *)userType;

/***堆场ID*/
+(NSString*)yardID;

/** *用户Accesstoken */
+(NSString *)yardName;

//用户密码
+(NSString *)userPassword;
/** *当前时间戳 */
+(long long)convertDateToTimestamp;

/** *当前用户头像 */
+(NSString *)userHeaderImgUrl;



/** *Number类型转string */
+(NSString *)timeSpChangeToString:(NSNumber *)timeNum;

/** *NSString类型转时间戳 */
+(long long)dateStringChangeToTimeStemp:(NSString *)timeStr;

//时间带秒
+(long long)dateStringChangeToTimeStempWithSecond:(NSString *)timeStr;
+(NSString *)timeNumberChangeToStringWithFormat:(NSString *)format Number:(NSNumber *)timeNum;
/**
 *  NSString 转 NSNumber
 */
+(NSNumber *)dateStringChangeToNumber:(NSString *)timeStr;

+(NSString *)dateStringWithDate:(NSDate *)date;

/** *字符串长度 */
+(int)convertToInt:(NSString*)strtemp;

/**
 * 删除 userDEFAULT 内信息
 */
+(void)deleteReadMessagesWithAssociateId:(NSNumber *)associateId;


/**
 *NSString 转 NSNumber
 */
+(NSNumber *)dateStringAllDayChangeToNumber:(NSString *)timeStr;

/**
 *  <#Description#>
 */
+ (NSString *)changeToString:(NSObject *)whatever;
@end
