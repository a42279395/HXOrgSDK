//
//  HXOrgExternalMemberHttpModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import "HXOrgExternalMemberHttpModel.h"

@implementation HXOrgExternalMemberHttpModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@"id",
    };
}

- (instancetype)initWithExternalMemberModel:(HXOrgExternalMemberModel *)model{
    self = [super init];
    if (self) {
        self.mainId = model.mainId;
        self.org_id = model.orgId;
        self.to_member_id = model.toMemberId;
        self.email = model.email;
        self.company = model.company;
        self.user_tel = model.userTel;
        self.landline = model.landline;
        self.user_name = model.userName;
        self.depposition = model.depposition;
        self.birthday = model.birthday;
        self.gender = model.gender;
        self.authority = model.authority;
        self.create_user_id = model.createUserId;
        
    }
    return self;
}

@end
