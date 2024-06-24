//
//  HXHttpErrorModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXHttpErrorModel : NSObject
@property (nonatomic, assign) int errcode;
@property (nonatomic, strong) NSString * message;
@end

NS_ASSUME_NONNULL_END
