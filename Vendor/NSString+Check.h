//
//  NSString+Check.h
//  Riddle
//
//  Created by Xcode on 15/1/21.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
-(BOOL)IsValidEmail;
-(BOOL)IsTrimStringLongThen:(int)length;
-(BOOL)isEmpty;
-(BOOL)IsValidPhone;
-(BOOL)IsValidCarNo;
-(BOOL)isNameString;
- (BOOL)containsText:(NSString *)string;
- (NSString *)separatedDigitString;
@end

@interface NSObject (JSON)
-(NSString*) convertObjectToJson;

@end
