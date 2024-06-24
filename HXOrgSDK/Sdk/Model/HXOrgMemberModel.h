//
//  HXOrgMemberModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import <Foundation/Foundation.h>

#pragma mark - 自身企业成员身份模型
@interface HXOrgSelfRoleModel : NSObject
///自身成员id
@property (nonatomic, assign) int memberId;

///企业id
@property (nonatomic, assign) int orgId;

///自身角色 C企业创建人 E企业管理员 D部门管理员 M普通成员
@property (nonatomic, strong) NSString * auth;

///可管理部门id
@property (nonatomic, strong) NSArray * deptIds;

///当前管理的部门
@property (nonatomic, assign) int adminDeptId;

///当前管理部门的名称   如果为企业管理员会返回企业名称
@property (nonatomic, strong) NSString * adminDeptName;

@end


#pragma mark - 企业成员模型
@interface HXOrgMemberModel : NSObject
///企业成员id （主键）
@property (nonatomic, assign) int mainId;

///企业id
@property (nonatomic, assign) int orgId;

///所在部门id数组
@property (nonatomic, assign) int deptId;

///修改后所在部门id数组
@property (nonatomic, strong) NSArray * deptIds;

///修改前所在部门id数组
@property (nonatomic, strong) NSArray * oldDeptIds;

///成员名称
@property (nonatomic, strong) NSString * userName;

///成员手机号
@property (nonatomic, strong) NSString * userTel;

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
@property (nonatomic, strong) NSString * extensionNumber;

///工号
@property (nonatomic, strong) NSString * jobNumber;

///是否激活： 0：否 1：是
@property (nonatomic, assign) int memberStatus;

///是否为企业高管 0：否 1：是
@property (nonatomic, assign) int isSeniorAdmin;

///身份
@property (nonatomic, strong) NSString * adminType;

///可管理部门名称  "测试部门名称、测试部门名称1"
@property (nonatomic, strong) NSString * deptName;



@end

