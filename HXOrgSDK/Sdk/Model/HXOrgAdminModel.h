//
//  HXOrgManagerModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/28.
//

#import <Foundation/Foundation.h>


@interface HXOrgAdminModel : NSObject
///管理id （主键）
@property (nonatomic, assign) int mainId;

///所属企业id
@property (nonatomic, assign) int orgId;

///管理部门id
@property (nonatomic, assign) int deptId;

///管理部门名称
@property (nonatomic, strong) NSString * deptName;

///成员id
@property (nonatomic, assign) int memberId;

///管理类型  C：创建者  E:企业  D：部门
@property (nonatomic, strong) NSString * adminType;

///用户电话
@property (nonatomic, strong) NSString * userTel;

///用户名称
@property (nonatomic, strong) NSString * userName;

@end

