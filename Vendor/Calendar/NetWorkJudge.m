//
//  NetWorkJudge.m
//  MerchantsIpad
//
//  Created by Gloria on 14-11-11.
//  Copyright (c) 2014年 mc. All rights reserved.
//

#import "NetWorkJudge.h"

@implementation NetWorkJudge
#pragma mark  ----  判断网络是否可用
+(BOOL)isConnectionAvailable
{
    BOOL isExistenceNetwork;
    
    Reachability*reach=[Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
        {
            isExistenceNetwork=NO;
            NSLog(@"notReachable");
            break;
        }
        case ReachableViaWiFi:
        {
            isExistenceNetwork=YES;
            break;
        }
        case ReachableViaWWAN:
        {
            isExistenceNetwork = YES;
            break;
        }
        default:
            break;
    }
    return isExistenceNetwork;
}
+(BOOL)isENableWIFI{
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}
@end
