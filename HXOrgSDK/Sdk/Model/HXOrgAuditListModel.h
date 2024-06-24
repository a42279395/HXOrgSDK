//
//  HXOrgAuditModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/30.
//

#import <Foundation/Foundation.h>
@interface HXOrgAuditModel : NSObject

///审核id
@property (nonatomic, assign) int mainId;

///申请人
@property (nonatomic, strong) NSString * applyUser;

///申请人电话
@property (nonatomic, strong) NSString * applyTel;

///部门名称
@property (nonatomic, strong) NSString * deptName;

///审批人
@property (nonatomic, strong) NSString * auditUser;

///审批时间
@property (nonatomic, strong) NSString * auditTime;

///审批状态
@property (nonatomic, strong) NSString * auditStatus;

@end

@interface HXOrgAuditListModel : NSObject
@property (nonatomic, strong) NSArray<HXOrgAuditModel *> * list;
@end


