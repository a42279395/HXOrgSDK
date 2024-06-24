//
//  HXORGSDK.h
//  Runner
//
//  Created by sunhaiping on 2024/5/24.
//

#import <Foundation/Foundation.h>


#import <HXOrgSDK/HXOrgModel.h>
#import <HXOrgSDK/HXOrgListModel.h>
#import <HXOrgSDK/HXOrgClassModel.h>
#import <HXOrgSDK/HXOrgClassListModel.h>
#import <HXOrgSDK/HXOrgDeptModel.h>
#import <HXOrgSDK/HXOrgDeptListModel.h>
#import <HXOrgSDK/HXOrgMemberModel.h>
#import <HXOrgSDK/HXOrgMemberListModel.h>
#import <HXOrgSDK/HXOrgExternalMemberModel.h>
#import <HXOrgSDK/HXOrgExternalMemberListModel.h>
#import <HXOrgSDK/HXInviteCodeListModel.h>
#import <HXOrgSDK/HXOrgAuditListModel.h>
#import <HXOrgSDK/HXTelCodeListModel.h>
#import <HXOrgSDK/HXDeptExtendListModel.h>
#import <HXOrgSDK/HXOrgAdminListModel.h>
#import <HXOrgSDK/HXOrgMemberDeptObjectsModel.h>
#import <HXOrgSDK/HXHttpErrorModel.h>

typedef void(^OrgSuccessBlock)(NSDictionary * object);

typedef void(^OrgFailureBlock)(HXHttpErrorModel * errorModel);

@interface HXORGSDK : NSObject
+ (instancetype)share;

- (void)setupToken:(NSString *)token BaseURL:(NSString *)baseURL;
#pragma mark - 企业
#pragma mark 获取用户所在企业列表
#pragma mark 获取用户所在企业列表
- (void)getOrgInfoListWithTopOrgId:(int)topOrgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgListModel * orgListModel))success Failure:(OrgFailureBlock)failure;



#pragma mark 创建企业
- (void)createOrgWithOrgName:(NSString *)name Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 更新企业信息
- (void)updateOrgInfoWithOrgModel:(HXOrgModel *)orgModel Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 解散企业
- (void)dissolveOrgWithOrgId:(int)orgid Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取企业信息详情
- (void)getOrgInfoWithOrgId:(int)orgid Success:(void (^)(HXOrgModel * orgModel))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取行业
- (void)getOrgClassListWithSuccess:(void (^)(HXOrgClassListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 加入企业
- (void)joinOrgWithCode:(NSString *)code Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取自身企业成员身份信息
- (void)getSelfMemberInfoWithOrgId:(int)orgid Success:(void (^)(HXOrgSelfRoleModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取国际号码段前缀信息
- (void)getTelCodeListSuccess:(void (^)(HXTelCodeListModel * model))success Failure:(OrgFailureBlock)failure;
#pragma mark - 部门
#pragma mark 创建部门
- (void)createDeptWithDeptModel:(HXOrgDeptModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 更新部门
- (void)updateDeptWithDeptModel:(HXOrgDeptModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 批量移除部门
- (void)deleteDeptWithOrgId:(int)orgId DeptIds:(NSArray *)deptIds Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取下级部门列表
- (void)getNextDeptWithOrgId:(int)orgId DeptId:(int)deptId PageIndex:(int)pageIndex Success:(void (^)(HXOrgDeptListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 按名称搜索下级部门列表
- (void)searchtNextDeptByNameWithOrgId:(int)orgId DeptId:(int)deptId DeptName:(NSString *)deptName PageIndex:(int)pageIndex Success:(void (^)(HXOrgDeptListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取部门详情
- (void)getDeptInfoWithOrgId:(int)orgId DeptId:(int)deptId Success:(void (^)(HXOrgDeptModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取部门成员总数
- (void)getDeptMemberNumberWithOrgId:(int)orgId DeptId:(int)deptId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark - 外部联系人
#pragma mark 通过姓名获取联系人列表
- (void)getExternalMemberListByNameWithUserName:(NSString *)userName MemberId:(int)memberid OrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgExternalMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取联系人列表
- (void)getExternalMemberListWithOrgId:(int)orgId MemberId:(int)memberid PageIndex:(int)pageIndex Success:(void (^)(HXOrgExternalMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 创建外部联系人
- (void)createExternalMemberWithExternalMemberModel:(HXOrgExternalMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 更新外部联系人
- (void)updateExternalMemberWithExternalMemberModel:(HXOrgExternalMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 删除外部联系人
- (void)deleteExternalMemberWithExternalMemberIds:(NSArray *)ids Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark - 成员管理
#pragma mark 创建企业成员 必填  deptId: [0] = 企业 , orgId: 900090, userTel: '13222222222', userName: 'ceshirenyuan2'
- (void)createOrgMemberWithMemberModel:(HXOrgMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 修改企业成员
- (void)updateOrgMemberWithMemberModel:(HXOrgMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取企业成员列表 (deptid = 0 查询企业成员， deptid != 0 查询部门id)
- (void)getOrgMemberListWithOrgId:(int)orgId DeptId:(int)deptId PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取成员归属部门对象（带权限）
- (void)getOrgMemberDeptObjectsWithOrgId:(int)orgId MemberId:(int)memberId MyMemberId:(int)myMemberId Success:(void (^)(HXOrgMemberDeptObjectsModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取企业成员详情
- (void)getOrgMemberInfoWithOrgId:(int)orgId MemberId:(int)memberId MyMemberId:(int)myMemberId Success:(void (^)(HXOrgMemberModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 搜索企业下全部成员
- (void)searchOrgAllMemberWithOrgId:(int)orgId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 搜索部门下全部成员
- (void)searchDeptAllMemberWithOrgId:(int)orgId DeptId:(int)deptId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取企业下未激活成员
- (void)getOrgUnactivatedMemberWithOrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 成员离职
- (void)dismissOrgMemberWithOrgId:(int)orgId MyMemberId:(int)myMemberId MemberIdList:(NSArray *)memberIdList Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 成员删除
- (void)deleteOrgMemberWithOrgId:(int)orgId DeptId:(int)deptId MyMemberId:(int)myMemberId MemberIdList:(NSArray *)memberIdList Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 搜索企业下可管理成员
- (void)searchOrgManageableMemberWithOrgId:(int)orgId MemberId:(int)memberId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 搜索部门下可管理成员
- (void)searchDeptManageableMemberWithOrgId:(int)orgId MemberId:(int)memberId DeptId:(int)deptId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark - 企业管理员
#pragma mark 获取管理员列表
- (void)getOrgAdminListWithMyMemberId:(int)myMemberId PageIndex:(int)pageIndex Success:(void (^)(HXOrgAdminListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 搜索管理员列表
- (void)getOrgAdminListWithMyMemberId:(int)myMemberId PageIndex:(int)pageIndex userName:(NSString *)userName Success:(void (^)(HXOrgAdminListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 创建管理员 （注：adminType 只能为E/D）
- (void)createOrgAdminWithOrgId:(int)orgId DeptId:(int)deptId MemberId:(int)memberId AdminType:(NSString *)adminType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 更新管理员 （仅能修改 部门与管理员类型 ，当为企管时 deptid = 0）（注：adminType 只能为E/D）
- (void)updateOrgAdminWithOrgId:(int)orgId DeptId:(int)deptId MainId:(int)mainId AdminType:(NSString *)adminType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 转移企业创建者
- (void)transOrgCreatorWithOrgId:(int)orgId MainId:(int)mainId MemberId:(int)memberId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 删除管理员
- (void)deleteOrgAdminWithOrgId:(int)orgId MainId:(int)mainId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark - 扩展信息
#pragma mark 获取扩展信息
- (void)getMemberInfoExtendWithOrgId:(int)orgId Success:(void (^)(HXDeptExtendListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark - 邀请码
#pragma mark 获取企业邀请状态
- (void)getInviteStatusWithOrgId:(int)orgId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取企业邀请码列表
- (void)getInviteCodeListWithOrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXInviteCodeListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 企业开启/关闭邀请
- (void)setupInviteDisableWithOrgId:(int)orgId Enable:(int)enable Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 企业创建邀请码 建立企业邀请码时  deptid = 0
- (void)createInviteCodeWithOrgId:(int)orgId DeptId:(int)deptId ValidityType:(int)validityType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 企业更新邀请码
- (void)updateInviteCodeWithMainId:(int)mainId OrgId:(int)orgId DeptId:(int)deptId ValidityType:(int)validityType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 设置企业邀请设置项 inviteType: <admin"/"member"; memberInviteTo: <org"/"dept"
- (void)setupInviteSettingWithOrgId:(int)orgId InviteType:(NSString *)inviteType EnableAudit:(int)enableAudit MemberInviteTo:(NSString *)memberInviteTo Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取审核列表
- (void)getAuditListWithOrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgAuditListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 根据成员名称搜索审核列表
- (void)searchAuditListByNameWithOrgId:(int)orgId MemberName:(NSString *)memberName PageIndex:(int)pageIndex Success:(void (^)(HXOrgAuditListModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 批量删除审核
- (void)deleteAuditWithOrgId:(int)orgId auditIds:(NSArray *)auditIds Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 审批 status= refuse拒绝   confirm同意  untreated未处理
- (void)auditInviteWithOrgId:(int)orgId auditIds:(NSArray *)auditIds MemberId:(int)memberId status:(NSString *)status Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取邀请设置详情
- (void)getInviteSettingWithOrgId:(int)orgId Success:(void (^)(HXOrgInviteSettingModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 通过邀请码获取企业名称
- (void)getInviteOrgInfoWithInviteCode:(NSString *)inviteCode Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;

#pragma mark 获取邀请码详情
- (void)getInviteCodeInfoWithMainId:(int)mainId Success:(void (^)(HXInviteCodeModel * model))success Failure:(OrgFailureBlock)failure;

#pragma mark 获取部门邀请码
- (void)getInviteCodeWithOrgId:(int)orgId DeptId:(int)deptId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure;
@end

