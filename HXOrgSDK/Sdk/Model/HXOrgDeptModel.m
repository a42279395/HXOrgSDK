//
//  HXOrgDeptModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/25.
//

#import "HXOrgDeptModel.h"

@implementation HXOrgDeptModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"mainId":@[@"id",@"mainId"],
//             @"orgId":@[@"org_id", @"orgId"],
//             @"deptName":@[@"dept_name", @"deptName"],
//             @"isDeptGroup":@[@"is_dept_group", @"isDeptGroup"],
//             @"isDeptGroupChild":@[@"is_dept_group_child", @"isDeptGroupChild"],
//             @"deptAdminUser":@[@"dept_admin_user", @"deptAdminUser"],
//             @"deptGroupName":@[@"dept_group_name", @"deptGroupName"],
//             @"deptGroupMasterUser":@[@"dept_group_master_user", @"deptGroupMasterUser"],
//             @"deptGroupMasterUserName":@[@"dept_group_master_user_name", @"deptGroupMasterUserName"],
//             @"pDept":@[@"p_dept", @"pDept"],
//             @"deptAdminUserName":@[@"dept_admin_user_name", @"deptAdminUserName"],};
//}


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId",@"id"],
             @"orgId":@[@"orgId",@"org_id"],
             @"deptName":@[@"deptName",@"dept_name"],
             @"isDeptGroup":@[@"isDeptGroup",@"is_dept_group"],
             @"isDeptGroupChild":@[@"isDeptGroupChild",@"is_dept_group_child"],
             @"deptAdminUser":@[@"deptAdminUser",@"dept_admin_user"],
             @"deptGroupName":@[@"deptGroupName",@"dept_group_name"],
             @"deptGroupMasterUser":@[@"deptGroupMasterUser",@"dept_group_master_user"],
             @"deptGroupMasterUserName":@[@"deptGroupMasterUserName",@"dept_group_master_user_name"],
             @"pDept":@[ @"pDept",@"p_dept"],
             @"deptAdminUserName":@[@"deptAdminUserName",@"dept_admin_user_name"],};
}


//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{@"mainId":@[@"id"],
//             @"orgId":@[@"org_id"],
//             @"deptName":@[@"dept_name"],
//             @"isDeptGroup":@[@"is_dept_group"],
//             @"isDeptGroupChild":@[@"is_dept_group_child"],
//             @"deptAdminUser":@[@"dept_admin_user"],
//             @"deptGroupName":@[@"dept_group_name"],
//             @"deptGroupMasterUser":@[@"dept_group_master_user"],
//             @"deptGroupMasterUserName":@[@"dept_group_master_user_name"],
//             @"pDept":@[@"p_dept", @"pDept"],
//             @"deptAdminUserName":@[@"dept_admin_user_name"],};
//}

@end
