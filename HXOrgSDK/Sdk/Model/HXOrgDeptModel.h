//
//  HXOrgDeptModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXOrgDeptModel : NSObject
///部门id
@property (nonatomic, assign) int mainId;

///父部门id
@property (nonatomic, assign) int pid;

///企业id
@property (nonatomic, assign) int orgId;

///部门名称
@property (nonatomic, strong) NSString * deptName;

///是否有部门群
@property (nonatomic, assign) int isDeptGroup;

///是否包含子部门
@property (nonatomic, assign) int isDeptGroupChild;

///排序索引
@property (nonatomic, assign) int sort;

///管理员数组
@property (nonatomic, strong) NSArray * deptAdminUser;

///管理员id数组
@property (nonatomic, strong) NSArray * deptAdmin;

///部门群名称
@property (nonatomic, strong) NSString *  deptGroupName;

///群主成员id
@property (nonatomic, assign) int deptGroupMasterUser;

///群主成员名称
@property (nonatomic, strong) NSString *  deptGroupMasterUserName;

///父部门信息
@property (nonatomic, strong) NSDictionary * pDept;

///部门管理员名称
@property (nonatomic, strong) NSArray * deptAdminUserName;

@end

NS_ASSUME_NONNULL_END
