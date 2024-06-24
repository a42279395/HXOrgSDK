//
//  HXDeptExtendModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/29.
//

#import <Foundation/Foundation.h>
@interface HXDeptExtendModel : NSObject

@property (nonatomic, strong) NSString * label;


@property (nonatomic, strong) NSString * value;


@property (nonatomic, strong) NSString * info;


@property (nonatomic, assign) BOOL show;


@property (nonatomic, assign) int type;


@property (nonatomic, strong) NSString * checked;


@property (nonatomic, assign) BOOL disabled;
@end


@interface HXDeptExtendListModel : NSObject

@property (nonatomic, strong) NSString * ikey;

@property (nonatomic, strong) NSArray<HXDeptExtendModel *> * ivalue;

@end

