//
//  HXORGSDK.m
//  Runner
//
//  Created by sunhaiping on 2024/5/24.
//

#import "HXORGSDK.h"

#import "HXAFNManager.h"

#import "HXOrgHttpModel.h"
#import "HXOrgDeptHttpModel.h"
#import "HXOrgExternalMemberHttpModel.h"
#import "HXOrgMemberHttpModel.h"

#import <YYModel.h>

#import <HXOrgSDK/HXPublicHeader.h>

@interface HXORGSDK()
@property (nonatomic, strong) HXAFNManager * afmanager;
@end

@implementation HXORGSDK
+ (instancetype)share{
    
    static HXORGSDK * m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[HXORGSDK alloc] init];
    });
    return m;
}

- (void)setupToken:(NSString *)token BaseURL:(NSString *)baseURL{
    self.afmanager = [HXAFNManager shareWithToken:token BaseURL:baseURL];
}

#pragma mark - 企业
#pragma mark 创建企业
- (void)createOrgWithOrgName:(NSString *)name Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * params = @{@"orgname":name};
    [self.afmanager requestWithPath:@"/org" method:(HttpRequestTypePost) paramenters:params prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"createOrgWithOrgName = %@",object);
        NSNumber * num = object[@"org_id"];
        NSDictionary * dic = @{@"orgId": num};
        if (success){
            success(dic);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"createOrgWithOrgName errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取用户所在企业列表
- (void)getOrgInfoListWithTopOrgId:(int)topOrgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgListModel * orgListModel))success Failure:(OrgFailureBlock)failure{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:@{
        @"row_count":@(20),
        @"page_index":@(pageIndex),
        }];
    
    if (topOrgId > 0){
        [dic setObject:@(topOrgId) forKey:@"top_org_id"];
    }
    
    [self.afmanager requestWithPath:@"/user/orgs" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgInfoList = %@",object);
        if (success){
            HXOrgListModel * model = [HXOrgListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgInfoList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取企业信息详情
- (void)getOrgInfoWithOrgId:(int)orgid Success:(void (^)(HXOrgModel * orgModel))success Failure:(OrgFailureBlock)failure{
    NSString * url = [NSString stringWithFormat:@"/org/%d",orgid];
    [self.afmanager requestWithPath:url method:(HttpRequestTypeGet) paramenters:NULL prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgInfo = %@",object);
        if (success){
            HXOrgModel * model = [HXOrgModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 更新企业信息
- (void)updateOrgInfoWithOrgModel:(HXOrgModel *)orgModel Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    HXOrgHttpModel * model = [[HXOrgHttpModel alloc] initWithOrgModel:orgModel];
    NSDictionary * params = [model yy_modelToJSONObject];
    [self.afmanager requestWithPath:@"/org" method:(HttpRequestTypePut) paramenters:params prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"updateOrgInfo = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"updateOrgInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 解散企业
- (void)dissolveOrgWithOrgId:(int)orgid Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSString * url = [NSString stringWithFormat:@"/org/%d",orgid];
    HXLog(@"dissolveOrg url = %@",url);
    [self.afmanager requestWithPath:url method:(HttpRequestTypeDelete) paramenters:NULL prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"dissolveOrg = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"dissolveOrg errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}


#pragma mark 获取行业
- (void)getOrgClassListWithSuccess:(void (^)(HXOrgClassListModel * model))success Failure:(OrgFailureBlock)failure{
    [self.afmanager requestWithPath:@"/class" method:(HttpRequestTypeGet) paramenters:NULL prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgClass = %@",object);
        if (success){
            HXOrgClassListModel * model = [HXOrgClassListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgClass errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}


#pragma mark 加入企业
- (void)joinOrgWithCode:(NSString *)code Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{@"code":code};
    HXLog(@"joinOrg dic = %@",dic);
    [self.afmanager requestWithPath:@"/invite/join/org" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"joinOrg = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"joinOrg errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取自身企业成员身份信息
- (void)getSelfMemberInfoWithOrgId:(int)orgid Success:(void (^)(HXOrgSelfRoleModel * model))success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{@"org_id":@(orgid)};
    
    [self.afmanager requestWithPath:@"/org/member" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getSelfMemberInfo = %@",object);
        if (success){
            HXOrgSelfRoleModel * model = [HXOrgSelfRoleModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getSelfMemberInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取国际号码段前缀信息
- (void)getTelCodeListSuccess:(void (^)(HXTelCodeListModel * model))success Failure:(OrgFailureBlock)failure{
    
    [self.afmanager requestWithPath:@"/telcodes" method:(HttpRequestTypeGet) paramenters:NULL prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getTelCodeList = %@",object);
        if (success){
            HXTelCodeListModel * model = [HXTelCodeListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getTelCodeList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark - 部门

#pragma mark 创建部门
- (void)createDeptWithDeptModel:(HXOrgDeptModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    
    HXOrgDeptHttpModel * httpmodel = [[HXOrgDeptHttpModel alloc] initWithDeptModel:model];
    
    NSDictionary * dic = [httpmodel yy_modelToJSONObject];
    
    [self.afmanager requestWithPath:@"/dept" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"createDept = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"createDept errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取部门树


#pragma mark 更新部门
- (void)updateDeptWithDeptModel:(HXOrgDeptModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    HXOrgDeptHttpModel * httpmodel = [[HXOrgDeptHttpModel alloc] initWithDeptModel:model];
    
    NSDictionary * dic = [httpmodel yy_modelToJSONObject];
    
    [self.afmanager requestWithPath:@"/dept" method:(HttpRequestTypePut) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"updateDept = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"updateDept errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 批量移除部门
- (void)deleteDeptWithOrgId:(int)orgId DeptIds:(NSArray *)deptIds Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{@"org_id":[NSNumber numberWithInt:orgId],
                           @"dept_ids":deptIds};
    
    [self.afmanager requestWithPath:@"/dept" method:(HttpRequestTypeDelete) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"deleteDept = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"deleteDept errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取下级部门列表
- (void)getNextDeptWithOrgId:(int)orgId DeptId:(int)deptId PageIndex:(int)pageIndex Success:(void (^)(HXOrgDeptListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId]};
    
    [self.afmanager requestWithPath:@"/dept/list" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getNextDept = %@",object);
        if (success){
            HXOrgDeptListModel * model = [HXOrgDeptListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getNextDept errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 按名称搜索下级部门列表
- (void)searchtNextDeptByNameWithOrgId:(int)orgId DeptId:(int)deptId DeptName:(NSString *)deptName PageIndex:(int)pageIndex Success:(void (^)(HXOrgDeptListModel * model))success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{
        @"deptName":deptName,
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId]};
    
    [self.afmanager requestWithPath:@"/dept/list" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchtNextDeptByName = %@",object);
        if (success){
            HXOrgDeptListModel * model = [HXOrgDeptListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchtNextDeptByName errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取部门详情
- (void)getDeptInfoWithOrgId:(int)orgId DeptId:(int)deptId Success:(void (^)(HXOrgDeptModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId]};
    
    [self.afmanager requestWithPath:@"/dept/detail" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getDeptInfo = %@",object);
        if (success){
            HXOrgDeptModel * model = [HXOrgDeptModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getDeptInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取部门成员总数
- (void)getDeptMemberNumberWithOrgId:(int)orgId DeptId:(int)deptId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId]};
    
    [self.afmanager requestWithPath:@"/dept/member/num" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getDeptMemberNumber = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getDeptMemberNumber errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}


#pragma mark - 外部联系人
#pragma mark 通过姓名获取联系人列表
- (void)getExternalMemberListByNameWithUserName:(NSString *)userName MemberId:(int)memberid OrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgExternalMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_id":[NSNumber numberWithInt:memberid],
        @"user_name":userName,};
    
    [self.afmanager requestWithPath:@"/orgmemberexternal" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getExternalMemberListByName = %@",object);
        if (success){
            HXOrgExternalMemberListModel * model = [HXOrgExternalMemberListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getExternalMemberListByName errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取联系人列表
- (void)getExternalMemberListWithOrgId:(int)orgId MemberId:(int)memberid PageIndex:(int)pageIndex Success:(void (^)(HXOrgExternalMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_id":[NSNumber numberWithInt:memberid]};
    
    [self.afmanager requestWithPath:@"/orgmemberexternal" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getExternalMemberList = %@",object);
        if (success){
            HXOrgExternalMemberListModel * model = [HXOrgExternalMemberListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getExternalMemberList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}


#pragma mark 创建外部联系人
- (void)createExternalMemberWithExternalMemberModel:(HXOrgExternalMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    HXOrgExternalMemberHttpModel * httpmodel = [[HXOrgExternalMemberHttpModel alloc] initWithExternalMemberModel:model];
    NSMutableDictionary * httpDic = [NSMutableDictionary dictionaryWithDictionary:[httpmodel yy_modelToJSONObject]];
    if (httpmodel.mainId == 0){
        [httpDic removeObjectForKey:@"id"];
    }
    NSDictionary * dic = @{@"data":@[httpDic]};
    
    [self.afmanager requestWithPath:@"/orgmemberexternal" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"createExternalMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"createExternalMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 更新外部联系人
- (void)updateExternalMemberWithExternalMemberModel:(HXOrgExternalMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    HXOrgExternalMemberHttpModel * httpmodel = [[HXOrgExternalMemberHttpModel alloc] initWithExternalMemberModel:model];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[httpmodel yy_modelToJSONObject]];
    if (httpmodel.mainId == 0){
        [dic removeObjectForKey:@"id"];
    }
    
    if (httpmodel.org_id == 0){
        [dic removeObjectForKey:@"org_id"];
    }
    
    if (httpmodel.to_member_id == 0){
        [dic removeObjectForKey:@"to_member_id"];
    }
    
    
    [self.afmanager requestWithPath:@"/orgmemberexternal" method:(HttpRequestTypePut) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"updateExternalMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"updateExternalMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 删除外部联系人
- (void)deleteExternalMemberWithExternalMemberIds:(NSArray<NSNumber *> *)ids Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSMutableArray * arr = [NSMutableArray array];
    for (NSNumber * temp in ids) {
        NSDictionary * dic = @{@"id":temp};
        [arr addObject:dic];
    }
    
    NSDictionary * dic = @{@"data":arr};
    [self.afmanager requestWithPath:@"/orgmemberexternal" method:(HttpRequestTypeDelete) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"deleteExternalMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"deleteExternalMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark - 成员管理
#pragma mark 创建企业成员 必填  deptId: [0] = 企业 , orgId: 900090, userTel: '13222222222', userName: 'ceshirenyuan2'
- (void)createOrgMemberWithMemberModel:(HXOrgMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    HXOrgMemberHttpModel * httpmodel = [[HXOrgMemberHttpModel alloc] initWithOrgMemberModel:model];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[httpmodel yy_modelToJSONObject]];
    if (httpmodel.mainId == 0){
        [dic removeObjectForKey:@"id"];
    }
    
    if (httpmodel.org_id == 0){
        [dic removeObjectForKey:@"org_id"];
    }
    
    if (httpmodel.sex != 1 && httpmodel.sex != 2){
        [dic removeObjectForKey:@"sex"];
    }
    
    [self.afmanager requestWithPath:@"/member" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"createOrgMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"createOrgMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 修改企业成员 必填 
- (void)updateOrgMemberWithMemberModel:(HXOrgMemberModel *)model Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    HXOrgMemberHttpModel * httpmodel = [[HXOrgMemberHttpModel alloc] initWithOrgMemberModel:model];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:[httpmodel yy_modelToJSONObject]];
    if (httpmodel.mainId == 0){
        [dic removeObjectForKey:@"id"];
    }
    
    if (httpmodel.org_id == 0){
        [dic removeObjectForKey:@"org_id"];
    }
    
    if (httpmodel.sex != 1 && httpmodel.sex != 2){
        [dic removeObjectForKey:@"sex"];
    }
    
    [self.afmanager requestWithPath:@"/member" method:(HttpRequestTypePut) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"updateOrgMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"updateOrgMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}


#pragma mark 获取企业成员列表 (deptid = 0 查询企业成员， deptid != 0 查询部门id)
- (void)getOrgMemberListWithOrgId:(int)orgId DeptId:(int)deptId PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId]
    };
    
    [self.afmanager requestWithPath:@"/member" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgMemberList = %@",object);
        HXOrgMemberListModel * model = [HXOrgMemberListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgMemberList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取成员归属部门对象（带权限）
- (void)getOrgMemberDeptObjectsWithOrgId:(int)orgId MemberId:(int)memberId MyMemberId:(int)myMemberId Success:(void (^)(HXOrgMemberDeptObjectsModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_id":[NSNumber numberWithInt:memberId],
        @"login_member_id":[NSNumber numberWithInt:myMemberId]
        
    };
    
    [self.afmanager requestWithPath:@"/member/deptobjects" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgMemberDept = %@",object);
        HXOrgMemberDeptObjectsModel * model = [HXOrgMemberDeptObjectsModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgMemberDept errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取企业成员详情
- (void)getOrgMemberInfoWithOrgId:(int)orgId MemberId:(int)memberId MyMemberId:(int)myMemberId Success:(void (^)(HXOrgMemberModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"login_member_id":[NSNumber numberWithInt:myMemberId],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_id":[NSNumber numberWithInt:memberId]};
    
    [self.afmanager requestWithPath:@"/memberinfo" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgMemberInfo = %@",object);
        HXOrgMemberModel * model = [HXOrgMemberModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgMemberInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 搜索企业下全部成员
- (void)searchOrgAllMemberWithOrgId:(int)orgId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"user_name":userName};
    
    [self.afmanager requestWithPath:@"/member" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchOrgAllMember = %@",object);
        HXOrgMemberListModel * model = [HXOrgMemberListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchOrgAllMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 搜索部门下全部成员
- (void)searchDeptAllMemberWithOrgId:(int)orgId DeptId:(int)deptId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId],
        @"user_name":userName};
    
    [self.afmanager requestWithPath:@"/member" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchDeptAllMember = %@",object);
        HXOrgMemberListModel * model = [HXOrgMemberListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchDeptAllMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取企业下未激活成员
- (void)getOrgUnactivatedMemberWithOrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_status":@(0)};
    
    [self.afmanager requestWithPath:@"/member" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchOrgAllMember = %@",object);
        HXOrgMemberListModel * model = [HXOrgMemberListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchOrgAllMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 成员离职
- (void)dismissOrgMemberWithOrgId:(int)orgId MyMemberId:(int)myMemberId MemberIdList:(NSArray *)memberIdList Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_id":[NSNumber numberWithInt:myMemberId],
        @"member_list":memberIdList};
    
    [self.afmanager requestWithPath:@"/member/depart" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"dismissOrgMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"dismissOrgMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 成员删除
- (void)deleteOrgMemberWithOrgId:(int)orgId DeptId:(int)deptId MyMemberId:(int)myMemberId MemberIdList:(NSArray *)memberIdList Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":[NSNumber numberWithInt:orgId],
        @"dept_id":[NSNumber numberWithInt:deptId],
        @"member_id":[NSNumber numberWithInt:myMemberId],
        @"member_list":memberIdList};
    
    [self.afmanager requestWithPath:@"/member/remove" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"deleteOrgMember = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"deleteOrgMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 搜索企业下可管理成员
- (void)searchOrgManageableMemberWithOrgId:(int)orgId MemberId:(int)memberId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"user_name":userName,
        @"member_id": @(memberId)};
    
    [self.afmanager requestWithPath:@"/memberselect" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchOrgManageableMember = %@",object);
        HXOrgMemberListModel * model = [HXOrgMemberListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchOrgManageableMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 搜索部门下可管理成员
- (void)searchDeptManageableMemberWithOrgId:(int)orgId MemberId:(int)memberId DeptId:(int)deptId UserName:(NSString *)userName PageIndex:(int)pageIndex Success:(void (^)(HXOrgMemberListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"user_name":userName,
        @"member_id": @(memberId),
        @"dept_id":@(deptId)};
    
    [self.afmanager requestWithPath:@"/memberselect" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchOrgManageableMember = %@",object);
        HXOrgMemberListModel * model = [HXOrgMemberListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchOrgManageableMember errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}


#pragma mark - 企业管理员
#pragma mark 获取管理员列表
- (void)getOrgAdminListWithMyMemberId:(int)myMemberId PageIndex:(int)pageIndex Success:(void (^)(HXOrgAdminListModel * model))success Failure:(OrgFailureBlock)failure{

    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"member_id":[NSNumber numberWithInt:myMemberId]
    };
    
    [self.afmanager requestWithPath:@"/admin" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgManagerList = %@",object);
        HXOrgAdminListModel * model = [HXOrgAdminListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgManagerList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 搜索管理员列表
- (void)getOrgAdminListWithMyMemberId:(int)myMemberId PageIndex:(int)pageIndex userName:(NSString *)userName Success:(void (^)(HXOrgAdminListModel * model))success Failure:(OrgFailureBlock)failure{

    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"member_id":[NSNumber numberWithInt:myMemberId],
        @"user_name":userName
    };
    
    [self.afmanager requestWithPath:@"/admin" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getOrgManagerList = %@",object);
        HXOrgAdminListModel * model = [HXOrgAdminListModel yy_modelWithJSON:object];
        if (success){
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getOrgManagerList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 创建管理员 （注：adminType 只能为E/D）
- (void)createOrgAdminWithOrgId:(int)orgId DeptId:(int)deptId MemberId:(int)memberId AdminType:(NSString *)adminType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{@"org_id":@(orgId),
                           @"data":@[@{
                               @"dept_id":@(deptId),
                               @"member_id":@(memberId),
                               @"admin_type":adminType,
                           }]};
    
    [self.afmanager requestWithPath:@"/admin" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"createOrgManager = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"createOrgManager errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 更新管理员 （仅能修改 部门与管理员类型 ，当为企管时 deptid = 0）（注：adminType 只能为E/D）
- (void)updateOrgAdminWithOrgId:(int)orgId DeptId:(int)deptId MainId:(int)mainId AdminType:(NSString *)adminType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{@"id":@(mainId),
                           @"org_id":@(orgId),
                           @"dept_id":@(deptId),
                           @"admin_type":adminType,
    };
    
    [self.afmanager requestWithPath:@"/admin" method:(HttpRequestTypePut) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"updateOrgManager = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"updateOrgManager errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 转移企业创建者
- (void)transOrgCreatorWithOrgId:(int)orgId MainId:(int)mainId MemberId:(int)memberId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{@"id":@(mainId),
                           @"org_id":@(orgId),
                           @"member_id":@(memberId),
    };
    
    [self.afmanager requestWithPath:@"/transadmin" method:(HttpRequestTypePut) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"transferOrgCreator = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"transferOrgCreator errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 删除管理员
- (void)deleteOrgAdminWithOrgId:(int)orgId MainId:(int)mainId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{@"org_id":@(orgId),
                           @"data":@[
                               @{@"id":@(mainId)
                           }]
    };
    
    [self.afmanager requestWithPath:@"/admin" method:(HttpRequestTypeDelete) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"deleteOrgManager = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"deleteOrgManager errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark - 扩展信息
#pragma mark 获取扩展信息
- (void)getMemberInfoExtendWithOrgId:(int)orgId Success:(void (^)(HXDeptExtendListModel * model))success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{
        @"Deptid":[NSNumber numberWithInt:orgId],
        @"IKeys":@"info",
    };
    
    [self.afmanager requestWithPath:@"/deptextend" method:(HttpRequestTypeGet) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getDeptExtend = %@",object);
        
        HXDeptExtendListModel * model = [[HXDeptExtendListModel alloc] init];
        model.ivalue = @[];
        if (success){
            id temp = object[@"list"];
            if (temp && [temp isKindOfClass:[NSArray class]]){
                NSDictionary * dic = [(NSArray *)temp firstObject];
                if (dic && [dic.allKeys containsObject:@"ivalue"]){
                    NSString * tempStr = dic[@"ivalue"];
                    if (tempStr){
                        NSData *jsonDataFromString = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
                        NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonDataFromString options:0 error:nil];
                        NSDictionary * tempdic = [NSMutableDictionary dictionaryWithDictionary:dic];
                        [tempdic setValue:arr forKey:@"ivalue"];
                        model = [HXDeptExtendListModel yy_modelWithDictionary:tempdic];
                    }
                }
            }
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getDeptExtend errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark - 邀请码
#pragma mark 获取企业邀请状态
- (void)getInviteStatusWithOrgId:(int)orgId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    NSDictionary * dic = @{
        @"org_id":@(orgId),
    };
    
    [self.afmanager requestWithPath:@"/invite/status" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getInviteStatus = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getInviteStatus errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取企业邀请码列表
- (void)getInviteCodeListWithOrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXInviteCodeListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId]};
    
    [self.afmanager requestWithPath:@"/invite/list" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getInviteCodeList = %@",object);
        if (success){
            HXInviteCodeListModel * model = [HXInviteCodeListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getInviteCodeList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 企业开启/关闭邀请
- (void)setupInviteDisableWithOrgId:(int)orgId Enable:(int)enable Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"enable":@(enable),
        @"org_id":@(orgId)};
    
    [self.afmanager requestWithPath:@"/invite/status" method:(HttpRequestTypePut) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"setupInviteDisable = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"setupInviteDisable errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 企业创建邀请码 建立企业邀请码时  deptid = 0
- (void)createInviteCodeWithOrgId:(int)orgId DeptId:(int)deptId ValidityType:(int)validityType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"dept_id":@(deptId),
        @"org_id":@(orgId),
        @"validity_type":@(validityType),
    };
    
    [self.afmanager requestWithPath:@"/invite" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"createInviteCode = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"createInviteCode errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 企业更新邀请码
- (void)updateInviteCodeWithMainId:(int)mainId OrgId:(int)orgId DeptId:(int)deptId ValidityType:(int)validityType Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"id":@(mainId),
        @"dept_id":@(deptId),
        @"org_id":@(orgId),
        @"validity_type":@(validityType),
    };
    
    [self.afmanager requestWithPath:@"/invite" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"setupInviteDisable = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"setupInviteDisable errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 设置企业邀请设置项 inviteType: "admin"/"member"; memberInviteTo: "org"/"dept"
- (void)setupInviteSettingWithOrgId:(int)orgId InviteType:(NSString *)inviteType EnableAudit:(int)enableAudit MemberInviteTo:(NSString *)memberInviteTo Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":@(orgId),
        @"invite_type":inviteType,
        @"enable_audit":@(enableAudit),
        @"member_invite_to":memberInviteTo,
    };
    
    [self.afmanager requestWithPath:@"/invite/setting" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"setupInviteSetting = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"setupInviteSetting errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取审核列表
- (void)getAuditListWithOrgId:(int)orgId PageIndex:(int)pageIndex Success:(void (^)(HXOrgAuditListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId]};
    
    [self.afmanager requestWithPath:@"/audit/list" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getAuditList = %@",object);
        if (success){
            HXOrgAuditListModel * model = [HXOrgAuditListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getAuditList errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 根据成员名称搜索审核列表
- (void)searchAuditListByNameWithOrgId:(int)orgId MemberName:(NSString *)memberName PageIndex:(int)pageIndex Success:(void (^)(HXOrgAuditListModel * model))success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"row_count":[NSNumber numberWithInt:20],
        @"page_index":[NSNumber numberWithInt:pageIndex],
        @"org_id":[NSNumber numberWithInt:orgId],
        @"member_name":memberName};
    
    [self.afmanager requestWithPath:@"/audit/list" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"searchAuditListByName = %@",object);
        if (success){
            HXOrgAuditListModel * model = [HXOrgAuditListModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"searchAuditListByName errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 批量删除审核
- (void)deleteAuditWithOrgId:(int)orgId auditIds:(NSArray *)auditIds Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":[NSNumber numberWithInt:orgId],
        @"audit_ids":auditIds};
    
    [self.afmanager requestWithPath:@"/audit" method:(HttpRequestTypeDelete) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"deleteAudit = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"deleteAudit errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 审批 status= refuse拒绝   confirm同意  untreated未处理
- (void)auditInviteWithOrgId:(int)orgId auditIds:(NSArray *)auditIds MemberId:(int)memberId status:(NSString *)status Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
    
    NSDictionary * dic = @{
        @"org_id":@(orgId),
        @"audit_ids":auditIds,
        @"member_id":@(memberId),
        @"status":status};
    
    [self.afmanager requestWithPath:@"/audit" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"auditInvite = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"auditInvite errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取邀请设置详情
- (void)getInviteSettingWithOrgId:(int)orgId Success:(void (^)(HXOrgInviteSettingModel * model))success Failure:(OrgFailureBlock)failure{
        
    NSString * url = [NSString stringWithFormat:@"/invite/setting/%d",orgId];
    
    [self.afmanager requestWithPath:url method:(HttpRequestTypeGet) paramenters:NULL prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getInviteSetting = %@",object);
        if (success){
            HXOrgInviteSettingModel * model = [HXOrgInviteSettingModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getInviteSetting errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 通过邀请码获取企业名称
- (void)getInviteOrgInfoWithInviteCode:(NSString *)inviteCode Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
        
    NSDictionary * dic = @{
        @"invite_code":inviteCode,
    };
    
    [self.afmanager requestWithPath:@"/invite/org" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getInviteOrgInfo = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getInviteOrgInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取邀请码详情
- (void)getInviteCodeInfoWithMainId:(int)mainId Success:(void (^)(HXInviteCodeModel * model))success Failure:(OrgFailureBlock)failure{
        
    NSString * url = [NSString stringWithFormat:@"/invite/code/%d",mainId];
    
    [self.afmanager requestWithPath:url method:(HttpRequestTypeGet) paramenters:NULL prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getInviteCodeInfo = %@",object);
        if (success){
            HXInviteCodeModel * model = [HXInviteCodeModel yy_modelWithJSON:object];
            success(model);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getInviteCodeInfo errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

#pragma mark 获取部门邀请码
- (void)getInviteCodeWithOrgId:(int)orgId DeptId:(int)deptId Success:(OrgSuccessBlock)success Failure:(OrgFailureBlock)failure{
        
    NSDictionary * dic = @{
        @"org_id":@(orgId),
        @"dept_id":@(deptId),
    };
    
    [self.afmanager requestWithPath:@"/invite/dept/code" method:(HttpRequestTypePost) paramenters:dic prepareExecute:NULL success:^(NSDictionary *object) {
        HXLog(@"getInviteCode = %@",object);
        if (success){
            success(object);
        }
    } failure:^(HXHttpErrorModel *errorModel) {
        HXLog(@"getInviteCode errorcode = %d  msg = %@",errorModel.errcode,errorModel.message);
        if (failure){
            failure(errorModel);
        }
    }];
}

@end

