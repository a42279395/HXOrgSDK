//
//  HXAFHTTPSessionManager.m
//  HXHY
//
//  Created by 孙海平 on 2024/5/23.
//  Copyright © 2024年 com. All rights reserved.
//

#import "HXAFHTTPSessionManager.h"

@implementation HXAFHTTPSessionManager

+ (instancetype)share{
    
    static HXAFHTTPSessionManager * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = (HXAFHTTPSessionManager *)[AFHTTPSessionManager manager];
        //申明返回的结果是json类型
        AFJSONResponseSerializer *  response = [AFJSONResponseSerializer serializer];
        response.readingOptions = 2;
        manager.responseSerializer = response;
        
        
        // 加上这行代码，https ssl 验证。
//      [self.manager setSecurityPolicy:[self customSecurityPolicy]];
        
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        
        //设置超时时间
        manager.requestSerializer.timeoutInterval = 30.0f;
        
        [manager.requestSerializer setHTTPShouldHandleCookies:YES];
        
        /**设置接受的类型*/
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
        
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        
        [manager setSecurityPolicy:securityPolicy];
        
        
        /** https */
//        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"www.haoxin.cn" ofType:@"cer"];
//        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//        NSSet*set = [[NSSet alloc] initWithObjects:cerData,nil];
//        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:set];
//        policy.allowInvalidCertificates = YES;
//        policy.validatesDomainName = NO;
//        [manager setSecurityPolicy:policy];
    });
    
    return manager;
}
@end
