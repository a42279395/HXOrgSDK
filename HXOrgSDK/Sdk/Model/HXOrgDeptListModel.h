//
//  HXOrgDeptListModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/25.
//

#import <Foundation/Foundation.h>

#import <HXOrgSDK/HXOrgDeptModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXOrgDeptListModel : NSObject
@property (nonatomic, strong) NSArray<HXOrgDeptModel *> * list;
@end

NS_ASSUME_NONNULL_END
