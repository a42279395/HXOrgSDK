//
//  HXAFNManager.m
//  封装AFN
//
//  Created by 孙海平 on 2024/5/23.
//  Copyright © 2024年 com. All rights reserved.
//

#import "HXAFNManager.h"

#import "HXPublicHeader.h"

#import "NSString+HXCategory.h"
#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"

#import <AFNetworking/AFNetworking.h>
#import <YYModel.h>

@interface HXAFNManager()

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * baseURL;

@end



@implementation HXAFNManager
{
    BOOL _showAlert;
}

- (HXAFHTTPSessionManager *)AFSessionManager{
    
    if (!_AFSessionManager) {
        
        _AFSessionManager = [HXAFHTTPSessionManager share];
    }
    return _AFSessionManager;
}

+ (instancetype)shareWithToken:(NSString *)token BaseURL:(NSString *)baseURL{
    
    static HXAFNManager * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[HXAFNManager alloc]init];
        m.token = token;
        m.baseURL = baseURL;
        //开始网络监测
        [m openNetMonitoringStatusChangeBlock:nil];
    });
    return m;
}

/********* 检查网络状态 ********/
- (void)openNetMonitoringStatusChangeBlock:(void(^)(AFNetworkReachabilityStatus status))statusBlock{
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.isConnect = NO;
                self.networkStatus = AFNetworkReachabilityStatusUnknown;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.isConnect = NO;
                self.networkStatus = AFNetworkReachabilityStatusNotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.isConnect = YES;
                self.networkStatus = AFNetworkReachabilityStatusReachableViaWiFi;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.isConnect = YES;
                self.networkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                break;
            default:
                break;
        }
        
    }];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        
        self.isConnect = YES;
    });
    
}

/********* 仅仅是网络请求 ********/
- (void)requestWithPath:(NSString *)url
                 method:(HttpRequestType)method
            paramenters:(NSDictionary *)params
         prepareExecute:(PrepareExecuteBlock)prepare
                success:(SuccessBlock)success
                failure:(FailureBlock)failure{
    
    NSString * query = [url stringByReplacingOccurrencesOfString:self.baseURL withString:@""];
    //去除反斜杠。zoom 的 seqid 有时会有反斜杠。
    query = [query stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    query = [query stringByReplacingOccurrencesOfString:@"==" withString:@"%3D%3D"];
    
    
    NSString *charactersToEscape = @"#<>[]^`{|}+\":";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    query = [query stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    url = [NSString stringWithFormat:@"%@%@",self.baseURL,query];
    
    //判断参数是否为空
    if (!params) {
        params = @{};
    }
    __block NSString * sid = [self getSIDWithType:@"20"];
    
    HXLog(@"请求开始。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。。 \n url = %@; params = %@;  sid = %@;",url,params,sid);
    @synchronized(self){
        
        [self.AFSessionManager.requestSerializer setValue:sid forHTTPHeaderField:@"sid"];
        
        NSString * str = [self.AFSessionManager.requestSerializer valueForHTTPHeaderField:@"Authorization"];
        
        if (!str) {
            [self.AFSessionManager.requestSerializer setValue:self.token forHTTPHeaderField:@"Authorization"];
        }
        
        NSString *currentLanguageRegion = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] firstObject];
        
        
        NSString * languageValue = @"en";
        if ([currentLanguageRegion isEqualToString:@"zh-Hans-CN"]){
            languageValue = @"zh-CN";
        }
        
        [self.AFSessionManager.requestSerializer setValue:languageValue forHTTPHeaderField:@"language"];
        
        //添加客户端类型
        [self.AFSessionManager.requestSerializer setValue:@"client_type" forHTTPHeaderField:@"mobile"];
        
        
        HXLog(@"header = %@",self.AFSessionManager.requestSerializer.HTTPRequestHeaders);
    }
    
    if ([self isConnectionAvailable]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //预处理
            if (prepare) {
                
                prepare();
            }
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        });
        
        switch (method) {
            case HttpRequestTypeGet:{
                [self getWithUrl:url sid:sid paramenters:params success:success failure:failure];
                break;
            }
            case HttpRequestTypePost:{
                [self postWithUrl:url sid:sid paramenters:params success:success failure:failure];
                break;
            }
            case HttpRequestTypePut: {
                [self putWithUrl:url sid:sid paramenters:params success:success failure:failure];
                break;
            }
                
            case HttpRequestTypeDelete:{
                [self deleteWithUrl:url sid:sid paramenters:params success:success failure:failure];
                break;
            }
            default:
                break;
        }
        
    } else {
        
        HXHttpErrorModel * errorModel = [[HXHttpErrorModel alloc] init];
        errorModel.errcode = 900001;
        errorModel.message = @"请求失败，请检查网络";
        failure(errorModel);
    }
}


- (void)getWithUrl:(NSString *)url
               sid:(NSString *)sid
       paramenters:(NSDictionary *)params
           success:(SuccessBlock)success
           failure:(FailureBlock)failure{
    
    [self.AFSessionManager GET:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self successActionWithResponseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureActionWithError:error Failure:failure];
    }];
}




- (void)postWithUrl:(NSString *)url
                sid:(NSString *)sid
        paramenters:(NSDictionary *)params
            success:(SuccessBlock)success
            failure:(FailureBlock)failure{
    
    [self.AFSessionManager POST:url parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary * responseObject){
        [self successActionWithResponseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureActionWithError:error Failure:failure];
    }];
}

- (void)putWithUrl:(NSString *)url
               sid:(NSString *)sid
       paramenters:(NSDictionary *)params
           success:(SuccessBlock)success
           failure:(FailureBlock)failure{
    
    [self.AFSessionManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successActionWithResponseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureActionWithError:error Failure:failure];
    }];
}

- (void)deleteWithUrl:(NSString *)url
                  sid:(NSString *)sid
          paramenters:(NSDictionary *)params
              success:(SuccessBlock)success
              failure:(FailureBlock)failure{
    [self.AFSessionManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successActionWithResponseObject:responseObject success:success];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failureActionWithError:error Failure:failure];
    }];
}
#pragma mark - 成功处理
- (void)successActionWithResponseObject:(id  _Nullable)responseObject success:(SuccessBlock)success{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (success) {
        success(responseObject);
    }
}

#pragma mark - 错误处理
- (void)failureActionWithError:(NSError *)error Failure:(FailureBlock)failure{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    //初始化errModel
    HXHttpErrorModel * errModel = [[HXHttpErrorModel alloc] init];
    errModel.message = error.localizedDescription;
    errModel.errcode = (int)error.code;
    
    //获取错误原因
    if (error.userInfo && [error.userInfo.allKeys containsObject:@"com.alamofire.serialization.response.error.data"]){
        NSData * data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
        if (data.length > 0){
            NSString * errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if (!IsStrEmpty(errorStr)){
                errModel = [HXHttpErrorModel yy_modelWithJSON:errorStr];
            }
        }
    }
    
    if (failure != nil) {
        failure(errModel);
    }
}








#pragma mark - Actions


- (void)changDelectRequest:(BOOL)isLaoCai{
    
    if (isLaoCai) {
        
        self.AFSessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    }else{
        
        self.AFSessionManager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
    }
   
}

/********* 判断网络状态 ********/
- (BOOL)isConnectionAvailable {
    
    return self.isConnect;
}




#pragma mark - Private

#pragma mark - 判断是否成功
- (BOOL)isSuccess:(NSString *)str
{
    if ([str isEqualToString:@"0"]) {
        return YES;
    }
    else
    {
        return NO;
    }
}

/********* 请求发生错误的处理 ********/
- (NSString *)codeFromResponseObject:(NSDictionary *)responseObject{
    return @"";
}




/**
 生成SID

 @param type 模块id
 @return sid
 */
- (NSString *)getSIDWithType:(NSString *)type
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyyMMddHHmmss"];
    NSString * timeStr = [dateFormatter stringFromDate:[NSDate date]];
    
    int a = arc4random() % 100000;
    NSString * randomStr = [NSString stringWithFormat:@"%06d", a];
    
    NSString * str = [NSString stringWithFormat:@"%@%@%@",type,timeStr,randomStr];
    return str;
}


@end
