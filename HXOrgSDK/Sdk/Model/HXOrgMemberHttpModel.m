//
//  HXOrgMemberHttpModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import "HXOrgMemberHttpModel.h"

@implementation HXOrgMemberHttpModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@"id",};
}

- (instancetype)initWithOrgMemberModel:(HXOrgMemberModel *)model{
    self = [super init];
    if (self) {
        self.mainId = model.mainId;
        self.org_id = model.orgId;
        self.dept_id = model.deptId;
        self.dept_ids = model.deptIds;
        self.old_dept_ids = model.oldDeptIds;
        self.user_name = model.userName;
        self.user_tel = model.userTel;
        self.position = model.position;
        self.email = model.email;
        self.sex = model.sex;
        self.birthday = model.birthday;
        self.landline = model.landline;
        self.extension_number = model.extensionNumber;
        self.job_number = model.jobNumber;
        self.member_status = model.memberStatus;
        self.is_senior_admin = model.isSeniorAdmin;
        self.admin_type = model.adminType;
        self.dept_name = model.deptName;
    }
    return self;
}

@end
