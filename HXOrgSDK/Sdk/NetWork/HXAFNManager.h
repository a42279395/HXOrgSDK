//
//  HXAFNManager.h
//  封装AFN
//
//  Created by 孙海平 on 2024/5/23.
//  Copyright © 2024年 com. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "HXAFHTTPSessionManager.h"


#import "HXHttpErrorModel.h"


//HTTP请求类别
typedef NS_ENUM(NSInteger) {
    HttpRequestTypeGet,
    HttpRequestTypePost,
    HttpRequestTypePut,
    HttpRequestTypeDelete,
}HttpRequestType;

/**
 *  请求前预处理block
 */
typedef void(^PrepareExecuteBlock)(void);

typedef void(^SuccessBlock)(NSDictionary * object);

typedef void(^FailureBlock)(HXHttpErrorModel * errorModel);


@interface HXAFNManager : NSObject

@property (nonatomic, strong)HXAFHTTPSessionManager * AFSessionManager;

@property (nonatomic, assign) BOOL isConnect;

@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;

+ (instancetype)shareWithToken:(NSString *)token BaseURL:(NSString *)baseURL;

/********* 网络请求 ********/
- (void)requestWithPath:(NSString *)url
                 method:(HttpRequestType)method
            paramenters:(NSDictionary *)params
         prepareExecute:(PrepareExecuteBlock)prepare
                success:(SuccessBlock)success
                failure:(FailureBlock)failure;

@end
