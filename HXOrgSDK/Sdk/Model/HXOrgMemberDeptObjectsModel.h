//
//  HXOrgMemberDeptObjectsModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/31.
//

#import <Foundation/Foundation.h>

#pragma mark - 成员所属部门模型
@interface HXOrgMemberDeptInfoModel : NSObject
///部门id
@property (nonatomic, assign) int deptId;

///父部门id
@property (nonatomic, assign) int pid;

///部门名称
@property (nonatomic, strong) NSString * deptName;
@end

@interface HXOrgMemberDeptObjectsModel : NSObject
@property (nonatomic, strong) NSArray <HXOrgMemberDeptInfoModel *>* deptObjects;
@end


