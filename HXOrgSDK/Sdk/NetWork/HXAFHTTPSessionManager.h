//
//  HXAFHTTPSessionManager.h
//  HXHY
//
//  Created by 孙海平 on 2024/5/23.
//  Copyright © 2024年 com. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HXAFHTTPSessionManager : AFHTTPSessionManager

+(instancetype)share;

@end
