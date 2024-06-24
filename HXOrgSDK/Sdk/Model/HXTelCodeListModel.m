//
//  HXTelCodeModel.m
//  Runner
//
//  Created by sunhaiping on 2024/6/14.
//

#import "HXTelCodeListModel.h"

@implementation HXTelCodeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"nCode":@[@"newCode",@"new_code"]};
}
@end


@implementation HXTelCodeListModel
// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
  return @{@"list" : [HXTelCodeModel class]};
}
@end
