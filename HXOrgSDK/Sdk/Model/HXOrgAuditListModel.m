//
//  HXOrgAuditModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/30.
//

#import "HXOrgAuditListModel.h"

@implementation HXOrgAuditModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId",@"id"],
             @"applyUser":@[@"applyUser", @"apply_user"],
             @"applyTel":@[@"applyTel", @"apply_tel"],
             @"deptName":@[@"deptName", @"dept_name"],
             @"auditUser":@[@"auditUser", @"audit_user"],
             @"auditTime":@[@"auditTime", @"audit_time"],
             @"auditStatus":@[@"auditStatus", @"audit_status"],
    };
}
@end

@implementation HXOrgAuditListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
  return @{@"list" : [HXOrgAuditModel class]};
}
@end

