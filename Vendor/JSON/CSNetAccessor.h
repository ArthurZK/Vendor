//
//  CSNetAccessor.h
//  JsonDemo
//
//  Created by ptc on 12-1-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSON.h"

@interface CSNetAccessor:NSObject 

-(NSObject*)GetObjWithURL:(NSString*)serviceURL;
-(NSObject*)GetObjWithURL:(NSString*)serviceURL andPostDict:(NSDictionary*)postDict;
-(UIImage*)GetImgWithURL:(NSString *)imageUrl;
-(NSMutableArray *)GetImgByteArray:(UIImage *)imageFile;
-(void)SetPlistValue:(id)value andKeyName:(NSString*)keyName andFileName:(NSString*)fileName;
-(NSObject*)GetPlistValueOfKey:(NSString*)keyName andFileName:(NSString*)fileName;

-(NSObject*)GetObjectWithURL:(NSString *)serviceURL;

-(NSObject*)GetObjFromURL:(NSString *)serviceURL andPostDict:(NSString *)postStr;

@end
