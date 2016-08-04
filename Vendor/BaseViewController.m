//
//  ViewController.m
//  CRM
//
//  Created by Arthur on 15/11/23.
//  Copyright © 2015年 Arthur. All rights reserved.
//


#import "BaseViewController.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface BaseViewController ()<UIGestureRecognizerDelegate,CDPDatePickerDelegate>

@property (strong , nonatomic)UIWindow *window;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    self.window = [UIApplication sharedApplication].keyWindow;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"消息-导航栏背景"] forBarMetrics:UIBarMetricsDefault];
        
        self.navigationController.navigationBar.barTintColor =  [self colorFromHexString:@"#1f71e5"];
        
        [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    }
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"按钮-返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = self.navigationController.viewControllers.count <= 1 ? nil : backBtn ;

    _appDelegate = [[UIApplication sharedApplication] delegate];
    

    
}
-(CGFloat)textHeight:(NSString *)string Width:(CGFloat )width
{
//    传字符串返回高度
    CGRect rect =[string boundingRectWithSize:CGSizeMake(width, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];//计算字符串所占的矩形区域的大小
    return rect.size.height;//返回高度
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    _datePicker=[[CDPDatePicker alloc] initWithSelectTitle:nil viewOfDelegate:keyWindow delegate:self];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_datePicker popDatePicker];
}
#pragma mark ----
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_datePicker popDatePicker];
}

-(void)backToRoot
{
    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index -2)] animated:YES];
}
#pragma mark - backAction
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - TextHetght
- (CGFloat)heightWithString:(NSString *)string fontSize:(CGFloat)fontSize width:(CGFloat)width{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}
#pragma mark - 中文编码
-(NSString *)URLEncodedString:(NSString *)str{
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)str,
                                                              NULL,
                                                              CFSTR("!*();+$,%#[] "),
                                                kCFStringEncodingUTF8));
    return result;
}
#pragma mark - phoneNumber //判断格式
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    
    NSString *cellPhoneString = @"^1[3|4||5|7|8][0-9]\\d{8}$";
    NSPredicate *cellPhone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",cellPhoneString];
    

    if ([cellPhone evaluateWithObject:mobileNum])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
}
#pragma mark - limitTextlength
-(NSString*)byLengthText:(NSString*)text limitLength:(int)length typeStr:(NSString*)type{
    if (text.length>length) {
        text = [text substringToIndex:length];
        [self showMessage:[NSString stringWithFormat:@"%@不能超过%d位",type,length]];
    }
    return text;
}

#pragma mark - MD5
- (NSString*) md5:(NSString*) str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


// 字典转json格式字符串：
- (NSString *)changeDictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark - 提示框
#pragma mark - 提示框
-(void )showMessage:(NSString*)str
{
    MBProgressHUD *ProgressHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    ProgressHUD.animationType = MBProgressHUDAnimationFade;
    
    ProgressHUD.mode = MBProgressHUDModeText;
    ProgressHUD.label.text = str;
    ProgressHUD.label.numberOfLines = 0;
    // Change the background view style and color.
    ProgressHUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    ProgressHUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    //    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD hideAnimated:YES afterDelay:1];
    });
    //    });
    
    
}
#pragma mark -
//登录动画
- (void)changeRootViewController:(UIViewController *)viewController
{
    if (self.window.rootViewController == nil)
    {
        self.window.rootViewController = viewController;
        return;
    }
    
    
    UIView *snapShot = [self.window snapshotViewAfterScreenUpdates:YES];
    [viewController.view addSubview:snapShot];
    self.window.rootViewController = viewController;
    
    //动画
    [UIView animateWithDuration:0.8 animations:^{
        snapShot.layer.opacity = 0;
        snapShot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
    }];
}



#pragma mark - RequestType
-(void)PostDataByByUrl:(NSString*)url initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show{
    if ([GLobalRealReachability currentReachabilityStatus])
    {
        [self showHUD:show];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        manger.responseSerializer = [AFHTTPResponseSerializer serializer];
        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
        manger.requestSerializer.timeoutInterval = TIME_OUT;
        
        [manger POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
        {
//            NSLog(@"进来了");
        }
            progress:^(NSProgress * _Nonnull uploadProgress)
        {
             
        } success:^(NSURLSessionDataTask * _Nonnull task, id  responseObject)
        {
             [self closeHUD:show];
             NSError * error;
             id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
             //            [self jsonDataChangeToString:json];
             finish(json);
        }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
        {
             [self closeHUD:show];
             if (failure)
             {
                 failure(error);
             }
             [self showMessage:GET_DATA_FAILURE];
        }];
    }
    else
    {
        [self closeHUD:show];
        //无网络返回
        if (failure)
        {
            NSError * error = [[NSError alloc]initWithDomain:NETWORK_CONNECT_FAILURE code:0 userInfo:nil];
            failure(error);
        }
        [self showMessage:NETWORK_CONNECT_FAILURE];
    }
}
-(void)GetDataByByUrl:(NSString*)url initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show
{
    if ([GLobalRealReachability currentReachabilityStatus])
    {
        [self showHUD:show];
        
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        manger.responseSerializer = [AFHTTPResponseSerializer serializer];
        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
        manger.requestSerializer.timeoutInterval = TIME_OUT;
        
        [manger GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress)
         {
             
         }
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [self closeHUD:show];
             NSError * error;
             id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
             finish(json);
         }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
         {
             [self closeHUD:show];
             if (failure)
             {
                 failure(error);
             }
             [self showMessage:GET_DATA_FAILURE];
         }];
    }
    else
    {
        [self closeHUD:show];
        //无网络返回
        if (failure)
        {
            NSError * error = [[NSError alloc]initWithDomain:NETWORK_CONNECT_FAILURE code:0 userInfo:nil];
            failure(error);
        }
        [self showMessage:NETWORK_CONNECT_FAILURE];
    }
}
-(void)DeleteDataByByUrl:(NSString*)url initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show{
    if ([GLobalRealReachability currentReachabilityStatus])
    {
        [self showHUD:show];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        manger.responseSerializer = [AFHTTPResponseSerializer serializer];
        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
        manger.requestSerializer.timeoutInterval = TIME_OUT;
        [manger DELETE:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
         {
             [self closeHUD:show];
             NSError * error;
             id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
             //            [self jsonDataChangeToString:json];
             finish(json);
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [self closeHUD:show];
             if (failure) {
                 failure(error);
             }
             [self showMessage:GET_DATA_FAILURE];
         }];
    }else{
        [self closeHUD:show];
        //无网络返回
        if (failure) {
            NSError * error = [[NSError alloc]initWithDomain:NETWORK_CONNECT_FAILURE code:0 userInfo:nil];
            failure(error);
        }
        [self showMessage:NETWORK_CONNECT_FAILURE];
    }
}
-(void)PutDataByByUrl:(NSString*)url initWithParm:(NSDictionary*)param completed:(void (^)(id json))finish failure:(void (^)(NSError * errror))failure showHUD:(BOOL)show{
    if ([GLobalRealReachability currentReachabilityStatus]) {
        [self showHUD:show];
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        manger.responseSerializer = [AFHTTPResponseSerializer serializer];
        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
        manger.requestSerializer.timeoutInterval = TIME_OUT;
        
        [manger PUT:url parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self closeHUD:show];
            NSError * error;
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
            //            [self jsonDataChangeToString:json];
            finish(json);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self closeHUD:show];
            if (failure) {
                failure(error);
            }
            [self showMessage:GET_DATA_FAILURE];
        }];
    }else{
        [self closeHUD:show];
        //无网络返回
        if (failure) {
            NSError * error = [[NSError alloc]initWithDomain:NETWORK_CONNECT_FAILURE code:0 userInfo:nil];
            failure(error);
        }
        [self showMessage:NETWORK_CONNECT_FAILURE];
    }
}

#pragma mark - 显示HUD
#pragma mark - 显示HUD
- (void)showHUD:(BOOL )show
{
    if (show)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = @"正在加载···";
        hud.mode=MBProgressHUDModeIndeterminate;
    }
}
#pragma mark - 隐藏HUD
- (void)closeHUD:(BOOL )show
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark - ColorFromHexString
-(UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}
#pragma mark - 时间戳转换
-(NSString*)timestampConvertToNsdate:(NSString*)str{
    
    NSTimeInterval time=[str doubleValue]+TIMEZONE;
    NSDate *confromTimesp =  [NSDate dateWithTimeIntervalSince1970:time/TIME_COUNT];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeStr = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:confromTimesp]];
    return timeStr;
}
-(NSString*)currentTime:(NSString*)style
{
    NSDate * currentDate = [NSDate date];
    NSDateFormatter * dateFormaste = [[NSDateFormatter alloc]init];
    [dateFormaste setDateFormat:style];
    NSString * timeString = [dateFormaste stringFromDate:currentDate];
    return timeString;
}
//plain类型的tableview去掉多于分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window)
    {
        self.view = nil;
    }
}
-(void)jsonDataChangeToString:(NSDictionary *)dic
{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"打印的json:%@",jsonStr);
}

@end
