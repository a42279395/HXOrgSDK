//
//  HXTelCodeModel.h
//  Runner
//
//  Created by sunhaiping on 2024/6/14.
//

#import <Foundation/Foundation.h>


@interface HXTelCodeModel : NSObject
///
@property (nonatomic, strong) NSString * code;

///
@property (nonatomic, strong) NSString * areadesc;

///
@property (nonatomic, strong) NSString * mark;

///
@property (nonatomic, strong) NSString * name;

///
@property (nonatomic, strong) NSString * nCode;

@end

@interface HXTelCodeListModel : NSObject
///
@property (nonatomic, strong) NSArray<HXTelCodeModel *> * list;

@end
