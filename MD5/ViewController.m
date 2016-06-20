//
//  ViewController.m
//  MD5
//
//  Created by 蒋永昌 on 16/6/10.
//  Copyright © 2016年 蒋永昌. All rights reserved.
//

#import "ViewController.h"
#import "EncryptionMD5.h"
#import "RSAEncryptor.h"
#import "AESCrypt.h"
#import "ZCTool_Base64.h"

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#define PUBLICKEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDE7aF/hkeTkOPvAzWCfAbwKlDAHo8Ai7+NKYbDLxIgnDGqaBMzoyQPdMIh9gGKil60Fvsr41HWvnDFB55nO2MY1mmHzzjqTRLe6Zv3rVkgbD9mN7q/Qeiib7TPbBJOyRmkDn1qh9VtI6tblnuJy/fYRDKtBOXIXhWpZl38IhOwEQIDAQAB"

#define PRIVATEKEY @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMTtoX+GR5OQ4+8DNYJ8BvAqUMAejwCLv40phsMvEiCcMapoEzOjJA90wiH2AYqKXrQW+yvjUda+cMUHnmc7YxjWaYfPOOpNEt7pm/etWSBsP2Y3ur9B6KJvtM9sEk7JGaQOfWqH1W0jq1uWe4nL99hEMq0E5cheFalmXfwiE7ARAgMBAAECgYBx/qDbAi8S0++t3uytwP//LG+cFtRu23ahz2UMPYY/zErPuvlKjeiE7fCm2hIgUWLq2tbAnBE2vvzmgTeHyI/evrMbbRzdksVPdFm3eGTyTLCCFYiZiv3cBM31vZ0wGOFye8YBCcm+vkVRaQgreuzXT/nmPAUb0BpnvA64ZS+05QJBAPcYx4dGiWZiQLecuVM7ZMLf4EFulaAlAdIFhJmA5dbRAGb/aWRuMt12h6Hd0sGIvtx7TsCxkN5D7riDa99UH58CQQDMBhjHq+k1AGe2yJshQtzfAf2Jcno4OOa+ZjpJNlxY7lyW2uK2fBiAEETveFx30vmoKlAP9xStk3/+wLjl41JPAkA0nIAPW4Nx20WwUpxbDnBb1dMn22XcXUTP9QDQtlM5s/KD+6nzCkumP9CNNG/laTpKM68G9EfGK2yuuLzFJmI9AkEAmxuHe0WW5lSIhM2+ImtSv7gjqHr/r/6Sbe4KId7SFkog2g9OjK2LctDrl6NJqU8bvl1swLZ3Yf7hMCwUZbGMwQJASoXu7SkJQsd5THMws3bbtAQygRpEhbypgRV77gn6uF5/wQJf2Ww48+nE6r+U2fMCp6mQhT0HZ9/rHc8zXqyJSw=="

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    EncryptionMD5 *md = [[EncryptionMD5 alloc]init];
    

    NSLog(@"简书str:%@",[EncryptionMD5 md5EncryptWithString:@"jiangyongchang"]);
    
    NSLog(@"大神str:%@",[EncryptionMD5 Md5:[@"jiangyongchang" dataUsingEncoding:NSUTF8StringEncoding]]);
    
    NSLog(@"网上str:%@",[md md5:@"jiangyongchang"]);
    
    
    NSLog(@"--------------");
    
    
//    //RSA 原始数据
    NSString *originalString = @"jiangyongchang";
//
////    //使用.der和.p12中的公钥私钥加密解密
//    NSString *public_key_path = [[NSBundle mainBundle] pathForResource:@"public_key.der" ofType:nil];
//    NSString *private_key_path = [[NSBundle mainBundle] pathForResource:@"private_key.p12" ofType:nil];
//    
//    NSString *encryptStr = [RSAEncryptor encryptString:originalString publicKeyWithContentsOfFile:public_key_path];
//
//    DLog(@"加密前:%@",originalString);
//    DLog(@"加密后:%@",encryptStr);
//    DLog(@"解密后:%@",[RSAEncryptor decryptString:encryptStr privateKeyWithContentsOfFile:private_key_path password:@"Jyc19910629"]);
//
////    //使用.der和.p12中的公钥私钥加密解密
//    
    NSString *encryptStr1 = [RSAEncryptor encryptString:originalString publicKey:PUBLICKEY];
    NSLog(@"加密前:%@", originalString);
    NSLog(@"加密后:%@", encryptStr1);
    NSLog(@"解密后:%@", [RSAEncryptor decryptString:encryptStr1 privateKey:PRIVATEKEY]);
    

    
    NSDictionary *dict = @{@"jiang":@"将",@"yong":@"永"};
    NSLog(@"dict:%@",dict);

    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"data:%@",data);
    
    NSData *rsaData = [RSAEncryptor encryptData:data publicKey:PUBLICKEY];
    NSLog(@"rsaData:%@",rsaData);

    NSData *finishData = [RSAEncryptor decryptData:rsaData privateKey:PRIVATEKEY];
    NSLog(@"finishData:%@",finishData);

    
    
    NSDictionary *finishDict = [NSJSONSerialization JSONObjectWithData:finishData options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"finishDict:%@",finishDict);
    
    
    
//    // AES加密
//    NSString *str = [AESCrypt encrypt:@"jiangyongchangjiangjsdl的实例开始考虑的" password:@"123456"];
//    
//    DLog(@"解密前：%@",str);
//    
//    DLog(@"解密后：%@",[AESCrypt decrypt:str password:@"123456"]);
//    
    
    

    // Base64
    
    
//    NSString *path = @"/Users/jiangyongchang/Desktop/girl.png";
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSData *base64Data = [data base64EncodedDataWithOptions:0];
//    [base64Data writeToFile:@"/Users/jiangyongchang/Desktop/base64" atomically:YES];
//    
//    
//    
//    NSString *base64Str = [data base64EncodedStringWithOptions:0];
//    NSLog(@"base64Str: %@",base64Str);
//    NSLog(@"%@ %ld base64Data: %@ %ld",data,data.length,base64Data,base64Data.length);
//    
//
//    
//    
//    NSData *endata = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
//    [endata writeToFile:@"/Users/jiangyongchang/Desktop/123.png" atomically:YES];
//    UIImage *image = [UIImage imageWithData:endata];
//
//    self.imageV.image = image;
    
    
    
    

//    UIImage *imageI = [UIImage imageNamed:@"girl"];
//    
//    NSData *data = UIImagePNGRepresentation(imageI);
//    
//    NSString *imageStr = [ZCTool_Base64 Encrypt:data];
////
//    NSLog(@"imageStr:%@",imageStr);
//    
//    
//    UIImage *image = [UIImage imageWithData:[ZCTool_Base64 Decrypt:imageStr]];
//    
//    self.imageV.image = image;
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
