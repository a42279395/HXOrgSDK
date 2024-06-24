//
//  HXOrgMemberHttpModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import <Foundation/Foundation.h>

#import "HXOrgMemberModel.h"


@interface HXOrgMemberHttpModel : NSObject
///企业成员id （主键）
@property (nonatomic, assign) int mainId;

///企业id
@property (nonatomic, assign) int org_id;

///所在部门id数组
@property (nonatomic, assign) int dept_id;

///修改后所在部门id数组
@property (nonatomic, strong) NSArray * dept_ids;

///修改前所在部门id数组
@property (nonatomic, strong) NSArray * old_dept_ids;

///成员名称
@property (nonatomic, strong) NSString * user_name;

///成员手机号
@property (nonatomic, strong) NSString * user_tel;

///职务
@property (nonatomic, strong) NSString * position;

///邮箱
@property (nonatomic, strong) NSString * email;

///性别：0：不详；1：男 ；2：女
@property (nonatomic, assign) int sex;

///生日
@property (nonatomic, strong) NSString * birthday;

///座机号码
@property (nonatomic, strong) NSString * landline;

///分机号码
@property (nonatomic, strong) NSString * extension_number;

///工号
@property (nonatomic, strong) NSString * job_number;

///是否激活： 0：否 1：是
@property (nonatomic, assign) int member_status;

///是否为企业高管 0：否 1：是
@property (nonatomic, assign) int is_senior_admin;

///身份
@property (nonatomic, strong) NSString * admin_type;

///可管理部门名称  "测试部门名称、测试部门名称1"
@property (nonatomic, strong) NSString * dept_name;


- (instancetype)initWithOrgMemberModel:(HXOrgMemberModel *)model;
@end

