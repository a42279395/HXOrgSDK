//
//  HXOrgHttpModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import "HXOrgHttpModel.h"

@implementation HXOrgHttpModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@"id",
    };
}

- (instancetype)initWithOrgModel:(HXOrgModel *)model
{
    self = [super init];
    if (self) {
        self.mainId = model.mainId;
        self.orgname = model.orgName;
        self.classid = model.classId;
        self.address = model.address;
        self.memail = model.memail;
        self.utel = model.utel;
        self.webpage = model.webPage;
        self.maxnum = model.maxNum;
        self.isauth = model.isAuth;
        self.org_avatar = model.orgAvatar;
        self.blid = model.blid;
        self.auth = model.auth;
        self.memberid = model.memberId;
        
    }
    return self;
}
@end

