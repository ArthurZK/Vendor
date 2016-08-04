//
//  CSNetAccessor.m
//  JsonDemo
//
//  Created by ptc on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CSNetAccessor.h"
//#import "GTMBase64.h"

@implementation CSNetAccessor
//@synthesize mmDict;
-(NSObject*)GetObjWithURL:(NSString *)serviceURL
{
    NSURL *URL=[NSURL URLWithString:serviceURL];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSData *returnData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
    NSString *backString=[[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    NSObject *returnObj=[backString JSONValue];
    return returnObj;
}
/*
-(NSObject*)GetObjWithURL:(NSString *)serviceURL
{
     NSURL *URL=[NSURL URLWithString:[serviceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSError *error = nil;
    NSData *returnData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error];
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *backString=[[NSString alloc]initWithData:returnData encoding:gbkEncoding];
    NSObject *returnObj=[backString JSONValue];
    //[backString release];
    return returnObj;
}*/
/*
-(NSObject*)GetObjWithURL:(NSString *)serviceURL andPostDict:(NSString *)postDict
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);

    NSURL *URL=[NSURL URLWithString:serviceURL];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    NSData *postData=[postDict dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setHTTPBody:postData];
    NSError *error = nil;
    NSData *returnData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error];
    NSString *backString=[[NSString alloc]initWithData:returnData encoding:gbkEncoding];
    NSObject *returnObj=[backString JSONValue];
   //[backString release];
    return returnObj;
}
 */

-(NSObject*)GetObjWithURL:(NSString *)serviceURL andPostDict:(NSDictionary *)postDict
{
    NSURL *URL=[NSURL URLWithString:serviceURL];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    NSString *postString=[postDict JSONRepresentation];
    NSData *postData=[postString dataUsingEncoding:NSUnicodeStringEncoding allowLossyConversion:YES];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setHTTPBody:postData];
    NSData *returnData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
    NSString *backString=[[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    NSObject *returnObj=[backString JSONValue];
    return returnObj;
}

//webservice
-(NSObject*)GetObjFromURL:(NSString *)serviceURL andPostDict:(NSString *)postStr
{
    NSURL *URL=[NSURL URLWithString:serviceURL];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:6];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
//    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [theRequest setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSError *error = nil;
    NSData *returnData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error];
    NSString *backString=[[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
    return backString;
}

//以字典的形式传递
-(NSObject*)GetObjectWithURL:(NSString *)serviceURL
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSURL *URL=[NSURL URLWithString:[serviceURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3];
    NSData *returnData=[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil];
    NSString *backString=[[NSString alloc]initWithData:returnData encoding:gbkEncoding];
    NSObject *returnObj=[backString JSONValue];
   // [backString release];
    return returnObj;
}


-(UIImage*)GetImgWithURL:(NSString *)imageUrl
{
    NSURL* URL=[NSURL URLWithString:imageUrl];
    NSData *imageData=[NSData dataWithContentsOfURL:URL];
    
    UIImage *returnImage=[[UIImage alloc]initWithData:imageData];
    
    return returnImage;
}

-(NSMutableArray *)GetImgByteArray:(UIImage *)imageFile
{
    NSData *data=UIImageJPEGRepresentation(imageFile, 0.75f);
    Byte *myData = (Byte *)[data bytes];
    NSMutableArray *byteArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[data length]; i++)
        [byteArray addObject:[NSString stringWithFormat:@"%d",myData[i]]];
    return byteArray;
   // [byteArray release];
}

-(void)SetPlistValue:(id)value andKeyName:(NSString*)keyName andFileName:(NSString*)fileName
{
    //plist文件路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docu=[paths objectAtIndex:0];
    NSString *thePath=[docu stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    //新建空的CityPicked
    NSMutableDictionary *mDict;
    if([fileManager fileExistsAtPath:thePath])
    {
        mDict=[[[NSMutableDictionary alloc]initWithContentsOfFile:thePath] mutableCopy];
    }
    else
    {
        mDict=[[NSMutableDictionary alloc]init];
    }if (value) {
         [mDict setObject:value forKey:keyName];
    }
    [mDict writeToFile:thePath atomically:YES];
    //[mDict release];
}
-(NSObject*)GetPlistValueOfKey:(NSString*)keyName andFileName:(NSString*)fileName
{
    NSObject *returnObject;
    //plist文件路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docu=[paths objectAtIndex:0];
    NSString *thePath=[docu stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    //新建空的CityPicked
    NSMutableDictionary *tempMMDic;
    if([fileManager fileExistsAtPath:thePath])
    {
        tempMMDic=[[[NSMutableDictionary alloc]initWithContentsOfFile:thePath]mutableCopy];
        returnObject=[tempMMDic objectForKey:keyName];
    }
    else
    {
        tempMMDic=[[NSMutableDictionary alloc]init];
        [tempMMDic writeToFile:thePath atomically:YES];
        //[tempMMDic release];
        returnObject =nil;
    }
    //[mDict release];
    return returnObject;
}

//-(NSObject*)GetPlistValueOfKey:(NSString*)keyName andFileName:(NSString*)fileName
//{
//    NSObject *returnObject;
//    //plist文件路径
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docu=[paths objectAtIndex:0];
//    NSString *thePath=[docu stringByAppendingPathComponent:fileName];
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    //新建空的CityPicked
//    if([fileManager fileExistsAtPath:thePath])
//    {
//        NSMutableDictionary *tempMMDic=[[[NSMutableDictionary alloc]initWithContentsOfFile:thePath]autorelease];
//        self.mmDict=tempMMDic;
//        //[tempMMDic release];
//        returnObject=[self.mmDict objectForKey:keyName];
//    }
//    else
//    {
//        self.mmDict=[[NSMutableDictionary alloc]init];
//        [self.mmDict writeToFile:thePath atomically:YES];
//        [self.mmDict release];
//        returnObject =nil;
//    }
//    //[mDict release];
//    return returnObject;
//}

-(void)dealloc
{
    //    [mmDict release];
    //[super dealloc];
}
@end
