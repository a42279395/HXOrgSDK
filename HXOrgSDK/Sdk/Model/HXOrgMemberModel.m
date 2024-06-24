//
//  HXOrgMemberModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import "HXOrgMemberModel.h"

@implementation HXOrgSelfRoleModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"memberId":@[@"memberId",@"member_id"],
             @"orgId":@[@"orgId", @"org_id"],
             @"deptIds":@[@"deptIds", @"dept_ids"],
             @"adminDeptId":@[@"adminDeptId", @"admin_dept_id"],
             @"adminDeptName":@[@"adminDeptName", @"admin_dept_name"],
    };
}

@end


@implementation HXOrgMemberModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId",@"id",@"member_id"],
             @"orgId":@[@"orgId", @"org_id"],
             @"deptId":@[@"deptId", @"dept_id"],
             @"deptIds":@[@"deptIds", @"dept_ids"],
             @"oldDeptIds":@[@"oldDeptIds", @"old_dept_ids"],
             @"userName":@[@"userName", @"user_name"],
             @"userTel":@[@"userTel", @"user_tel"],
             @"extensionNumber":@[@"extensionNumber", @"extension_number"],
             @"jobNumber":@[@"jobNumber", @"job_number"],
             @"memberStatus":@[@"memberStatus", @"member_status"],
             @"isSeniorAdmin":@[@"isSeniorAdmin", @"is_senior_admin"],
             @"adminType":@[@"adminType", @"admin_type"],
             @"deptName":@[@"deptName", @"dept_name"],
    };
}

@end
