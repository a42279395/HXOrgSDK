//
//  HXOrgDeptHttpModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import <Foundation/Foundation.h>

#import "HXOrgDeptModel.h"

@interface HXOrgDeptHttpModel : NSObject
///部门id
@property (nonatomic, assign) int mainId;

///父部门id
@property (nonatomic, assign) int p_dept_id;

///企业id
@property (nonatomic, assign) int org_id;

///部门名称
@property (nonatomic, strong) NSString * dept_name;

///是否有部门群
@property (nonatomic, assign) int is_dept_group;

///是否包含子部门
@property (nonatomic, assign) int is_dept_group_child;

///排序索引
@property (nonatomic, assign) int sort;

///管理员数组
@property (nonatomic, strong) NSArray * dept_admin_user;

///管理员id数组
@property (nonatomic, strong) NSArray * dept_admin;

///部门群名称
@property (nonatomic, strong) NSString *  dept_group_name;

///群主成员id
@property (nonatomic, assign) int dept_group_master_user;

///群主成员名称
@property (nonatomic, strong) NSString *  dept_group_master_user_name;

///父部门信息
@property (nonatomic, strong) NSDictionary * p_dept;

///部门管理员名称
@property (nonatomic, strong) NSArray * dept_admin_user_name;


- (instancetype)initWithDeptModel:(HXOrgDeptModel *)model;
@end

