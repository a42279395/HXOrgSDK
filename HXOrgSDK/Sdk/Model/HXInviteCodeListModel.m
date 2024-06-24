//
//  HXInviteCodeListModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/30.
//

#import "HXInviteCodeListModel.h"

@implementation HXInviteCodeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId",@"id"],
             @"orgId":@[@"orgId", @"org_id"],
             @"deptId":@[@"deptId", @"dept_id"],
             @"deptName":@[@"deptName", @"dept_name"],
             @"expireTime":@[@"expireTime", @"expire_time"],
             @"validityType":@[@"validityType", @"validity_type"],
             @"createUser":@[@"createUser", @"create_user"],
    };
}
@end

@implementation HXInviteCodeListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
  return @{@"list" : [HXInviteCodeModel class]};
}
@end
