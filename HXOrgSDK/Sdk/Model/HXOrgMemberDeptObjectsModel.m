//
//  HXOrgMemberDeptObjectsModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/31.
//

#import "HXOrgMemberDeptObjectsModel.h"

@implementation HXOrgMemberDeptInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"deptId":@[@"deptId", @"dept_id",],
             @"deptName":@[@"deptName", @"dept_name",],
    };
}
@end

@implementation HXOrgMemberDeptObjectsModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"deptObjects":@[@"deptObjects", @"dept_objects",],
    };
}
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
  return @{@"deptObjects" : [HXOrgMemberDeptInfoModel class]};
}
@end
