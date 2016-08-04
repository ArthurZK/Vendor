//
//  NSString+Check.m
//  Riddle
//
//  Created by Xcode on 15/1/21.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "NSString+Check.h"

@implementation NSString (Check)
/**
 *  是否是Emile
 */
-(BOOL)IsValidEmail
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)IsValidPhone{
    if ([self length] == 0) {
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(14[5|7])|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
                return NO;
    }
    return YES;
}
/*车牌号验证 MODIFIED BY HELENSONG*/
-(BOOL)IsValidCarNo
{
    if ([self length] == 0) {
        return NO;
    }
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:self];
}
-(BOOL)isEmpty{ 
    if (self==nil) {
        return YES;
    }
    return ![self IsTrimStringLongThen:1];
}
-(BOOL)IsTrimStringLongThen:(int)length{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>=length;
}
- (BOOL) containsText: (NSString*) substring
{
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}
- (NSString *)separatedDigitString

{
    NSLog(@"The begin string:%@",self);
    if (self.length <= 3) {
        return self;
    } else {
        NSMutableString *processString = [NSMutableString stringWithString:self];
        // 1
        int location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0)
            {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        //    NSLog(@"processArray = %@",processArray);
        // 2
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        //    NSLog(@"resultsArray = %@",resultsArray);
        // 3
        NSMutableString *resultString = [NSMutableString string];
        for (int i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        //    NSLog(@"resultStr = %@",resultString);
        return resultString;
    }
}

/**
 *  判断是否是可用的名字
 */
-(BOOL)isNameString
{
    NSString *name = @"^[A-Za-z0-9]+$";
    NSPredicate *namePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",name];
    return [namePre evaluateWithObject:self];
}
@end

@implementation NSObject(JSON)

-(NSString*) convertObjectToJson
{
    NSError *writeError = nil;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&writeError];
        NSString *result = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        
        return result;
    }
    return @"not valid json object....";
    
}

@end