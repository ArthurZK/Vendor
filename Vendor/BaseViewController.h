//
//  ViewController.h
//  CRM
//
//  Created by Arthur on 15/11/23.
//  Copyright © 2015年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHeader.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "MJRefresh.h"
#import "NSString+Check.h"
#import "SDImageCache.h"
#import "AppDelegate.h"
#import "RealReachability/RealReachability.h"
#import "User.h"
#import "JHCustomMenu.h"
#import "CDPDatePicker.h"
#define kSourceData @"SourceData"
#define kChatType @"ChatType"


#define FILE_MAX_SIZE		65536
@interface BaseViewController : UIViewController
@property (nonatomic,retain) NSString *groupCreate;
@property (nonatomic,retain) AppDelegate *appDelegate;
@property (strong , nonatomic)    CDPDatePicker *datePicker;

/** *获取文字高度 */
- (CGFloat)heightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width;

/** *请求方式---->Post */
-(void)PostDataByByUrl:(NSString*)url  initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show;

/** *请求方式---->Get */
-(void)GetDataByByUrl:(NSString*)url  initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show;

/** *请求方式---->Delete */
-(void)DeleteDataByByUrl:(NSString*)url
            initWithParm:(NSDictionary*)param
               completed:(void (^)(id json))finish
                 failure:(void (^)(NSError * errror))failure
                 showHUD:(BOOL)show;

/** *请求方式---->Put*/
-(void)PutDataByByUrl:(NSString*)url initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show;
/** *中文编码 */
-(NSString *)URLEncodedString:(NSString *)str;
//文字高度
-(CGFloat)textHeight:(NSString *)string Width:(CGFloat )width;

- (void)changeRootViewController:(UIViewController *)viewController;
// 字典转json格式字符串：

- (NSString *)changeDictionaryToJson:(NSDictionary *)dic;
/** *关闭菊花 */
- (void)showHUD:(BOOL )show;

/** *打开菊花 */
- (void)closeHUD:(BOOL )show;

/** *提示语 */
-(void)showMessage:(NSString*)str;

/** *MD5加密 */
- (NSString*) md5:(NSString*) str;

/** *手机号格式验证 */
- (BOOL)isMobileNumber:(NSString *)mobileNum;

/** *限制字数 */
-(NSString*)byLengthText:(NSString*)text limitLength:(int)length typeStr:(NSString*)type;

/** *16进制字符串转颜色值*/
-(UIColor *)colorFromHexString:(NSString *)hexString ;

/** *时间戳转换*/ 
-(NSString*)timestampConvertToNsdate:(NSString*)str;

/** *当前系统时间（字符串） */
-(NSString*)currentTime:(NSString*)style;
- (void)setExtraCellLineHidden: (UITableView *)tableView;
/**
 *  json 解析辅助
 */
-(void)jsonDataChangeToString:(NSDictionary *)dic;




/**
 *  回到上上个界面
 */
-(void)backToRoot;

/**
 *  回到上个界面
 */
-(void)backAction;

/**
 *  下载 通过文件名
 */
//-(void)downLoadFileWithOption:(NSDictionary *)paramDic
//                    Interface:(NSString *)requestURL
//                         Name:(NSString *)fileName
//              downLoadSuccess:(void(^)(AFHTTPRequestSerializer))

//发送数据给服务器

//发送登录数据给服务器，因为登录不需要做断线重连
//保存在线信息到会话页面
- (void)saveHomeMessage:(NSDictionary *)dic;


@end

