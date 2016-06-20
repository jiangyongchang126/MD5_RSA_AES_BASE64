//
//  EncryptionMD5.m
//  MD5
//
//  Created by 蒋永昌 on 16/6/10.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "EncryptionMD5.h"
#import <CommonCrypto/CommonDigest.h>

//秘钥
//static NSString *encryptionKey = @"nha735n197nxn(N′568GGS%d~~9naei';45vhhafdjkv]32rpks;lg,];:vjo(&**&^)";
static NSString *encryptionKey = @"";


@implementation EncryptionMD5

+ (NSString *)md5EncryptWithString:(NSString *)string{
    return [self md5:[NSString stringWithFormat:@"%@%@", encryptionKey, string]];
}

+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    
    return result;
}


- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSString *)Md5:(NSData *)data{//转换后的结果是可见字符
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes],(unsigned int)[data length],result);
    NSMutableString * hash=[NSMutableString string];
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++){
        [hash appendFormat:@"%02X",result[i]];
    }
    return hash;
}



@end
