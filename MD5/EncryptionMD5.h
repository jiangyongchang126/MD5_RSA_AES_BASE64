//
//  EncryptionMD5.h
//  MD5
//
//  Created by 蒋永昌 on 16/6/10.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptionMD5 : NSObject

//简书md5加密方法
+ (NSString *)md5EncryptWithString:(NSString *)string;

// 网上md5
- (NSString *)md5:(NSString *)str;

//大神md5
+ (NSString *)Md5:(NSData *)s;



@end
