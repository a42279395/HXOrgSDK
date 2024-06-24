//
//  HXOrgDeptListModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/25.
//

#import "HXOrgDeptListModel.h"

@implementation HXOrgDeptListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
  return @{@"list" : [HXOrgDeptModel class]};
}
@end
