//
//  HXOrgExternalMemberModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import "HXOrgExternalMemberModel.h"

@implementation HXOrgExternalMemberModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@[@"mainId", @"id"],
             @"orgId":@[@"orgId", @"org_id"],
             @"toMemberId":@[@"toMemberId", @"to_member_id"],
             @"userTel":@[@"userTel", @"user_tel"],
             @"userName":@[@"userName", @"user_name"],
             @"createUserId":@[@"createUserId", @"create_user_id"],
    };
}
@end
