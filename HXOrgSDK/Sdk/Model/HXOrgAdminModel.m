//
//  HXOrgManagerModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/28.
//

#import "HXOrgAdminModel.h"

@implementation HXOrgAdminModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId",@"id"],
             @"orgId":@[@"orgId", @"org_id"],
             @"deptId":@[@"deptId", @"dept_id"],
             @"deptName":@[@"deptName", @"dept_name"],
             @"memberId":@[@"memberId", @"member_id"],
             @"adminType":@[@"adminType", @"admin_type"],
             @"userTel":@[@"userTel", @"user_tel"],
             @"userName":@[@"userName", @"user_name"],
    };
}

@end
