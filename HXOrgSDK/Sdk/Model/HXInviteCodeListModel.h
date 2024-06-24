//
//  HXInviteCodeListModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/30.
//

#import <Foundation/Foundation.h>

@interface HXInviteCodeModel : NSObject

///所属企业id
@property (nonatomic, assign) int mainId;

///邀请码
@property (nonatomic, strong) NSString * code;

///是否生效
@property (nonatomic, assign) int status;

///部门名称
@property (nonatomic, strong) NSString * deptName;

///部门id
@property (nonatomic, assign) int deptId;

///企业id
@property (nonatomic, assign) int orgId;

///到期时间
@property (nonatomic, strong) NSString * expireTime;

///有效期类型 -1代表永久 其余数字代表天数
@property (nonatomic, assign) int validityType;

///操作用户
@property (nonatomic, strong) NSString * createUser;
@end

@interface HXInviteCodeListModel : NSObject
@property (nonatomic, strong) NSArray<HXInviteCodeModel *> * list;
@end


