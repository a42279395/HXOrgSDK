//
//  HXOrgModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/24.
//

#import <Foundation/Foundation.h>
#pragma mark - 企业邀请设置模型
@interface HXOrgInviteSettingModel : NSObject
///邀请类型 "admin" = 仅管理员 "member" = 所有成员邀请
@property (nonatomic, strong) NSString * inviteType;

///是否开启邀请审核
@property (nonatomic, assign) int enableAudit;

///邀请至 成员邀请加入至  "org" = 企业  ；"dept" = 所在部门
@property (nonatomic, strong) NSString * memberInviteTo;

///企业是否开启邀请
@property (nonatomic, assign) int enable;
@end


#pragma mark - 企业统计模型
@interface HXOrgDeptNumberModel : NSObject
///部门数量
@property (nonatomic, assign) int deptNum;
///成员数量
@property (nonatomic, assign) int memberNum;
///未激活成员数量
@property (nonatomic, assign) int noStateNum;

@end

@interface HXOrgModel : NSObject
///企业id
@property (nonatomic, assign) int mainId;

///企业名称
@property (nonatomic, strong) NSString * orgName;

///行业id
@property (nonatomic, strong) NSString * classId;

///地址
@property (nonatomic, strong) NSString * address;

///邮箱
@property (nonatomic, strong) NSString * memail;

///联系电话
@property (nonatomic, strong) NSString * utel;

///网站
@property (nonatomic, strong) NSString * webPage;

///最大人数
@property (nonatomic, assign) int maxNum;

///是否已认证
@property (nonatomic, strong) NSString * isAuth;

///企业头像
@property (nonatomic, strong) NSString * orgAvatar;

///营业执照号码
@property (nonatomic, strong) NSString * blid;

///自身身份
@property (nonatomic, strong) NSString * auth;

///自身成员id
@property (nonatomic, assign) int memberId;

///行业名称
@property (nonatomic, strong) NSString * className;

///地址名称
@property (nonatomic, strong) NSString * addressName;

///邀请设置
@property (nonatomic, strong) HXOrgInviteSettingModel * inviteSetting;

///统计
@property (nonatomic, strong) HXOrgDeptNumberModel * numbers;

@end




