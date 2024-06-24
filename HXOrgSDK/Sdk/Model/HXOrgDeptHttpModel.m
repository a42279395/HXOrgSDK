//
//  HXOrgDeptHttpModel.m
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import "HXOrgDeptHttpModel.h"

@implementation HXOrgDeptHttpModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"mainId":@"dept_id",};
}

- (instancetype)initWithDeptModel:(HXOrgDeptModel *)model{
    self = [super init];
    if (self) {
        self.mainId = model.mainId;
        self.p_dept_id = model.pid;
        self.org_id = model.orgId;
        self.dept_name = model.deptName;
        self.is_dept_group = model.isDeptGroup;
        self.is_dept_group_child = model.isDeptGroupChild;
        self.sort = model.sort;
        self.dept_admin_user = model.deptAdminUser;
        self.dept_admin = model.deptAdmin;
        self.dept_group_master_user_name = model.deptGroupMasterUserName;
        self.p_dept = model.pDept;
        self.dept_admin_user_name = model.deptAdminUserName;
        
        
    }
    return self;
}
@end
