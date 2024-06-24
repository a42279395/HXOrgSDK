//
//  HXOrgModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/24.
//

#import "HXOrgModel.h"

@implementation HXOrgInviteSettingModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"inviteType":@[@"inviteType", @"invite_type",],
             @"enableAudit":@[@"enableAudit", @"enable_audit",],
             @"memberInviteTo":@[@"memberInviteTo", @"member_invite_to",],
    };
}
@end

@implementation HXOrgDeptNumberModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"deptNum":@[@"deptNum", @"dept_num",],
             @"memberNum":@[@"memberNum", @"member_num",],
             @"noStateNum":@[@"noStateNum", @"no_state_num",],
    };
}
@end

@implementation HXOrgModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId",@"id",@"orgid"],
             @"orgName":@[@"orgName", @"orgname"],
             @"classId":@[@"classId", @"classid"],
             @"webPage":@[@"webPage", @"webpage"],
             @"maxNum":@[@"maxNum", @"maxnum"],
             @"isAuth":@[ @"isAuth", @"isauth"],
             @"orgAvatar":@[ @"orgAvatar", @"org_avatar"],
             @"memberId":@[@"memberId",@"memberid"],
             @"inviteSetting":@[@"inviteSetting",@"invite_setting"],
             @"className":@[@"className",@"class_name"],
             @"addressName":@[@"addressName",@"address_name"]
    };
}

// 声明自定义类参数类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
  // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
  return @{@"invite_setting" : [HXOrgInviteSettingModel class], @"numbers" : [HXOrgDeptNumberModel class]};
}

@end
