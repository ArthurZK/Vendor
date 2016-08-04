//
//  NetWorkJudge.h
//  MerchantsIpad
//
//  Created by Gloria on 14-11-11.
//  Copyright (c) 2014年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetWorkJudge : NSObject
/** *判断网络状态 */
+(BOOL)isConnectionAvailable;
+(BOOL) isENableWIFI;
@end
