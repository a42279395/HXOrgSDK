//
//  HXOrgExternalMemberModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXOrgExternalMemberModel : NSObject
///外部联系人 id （主键）
@property (nonatomic, assign) int mainId;

///企业 id
@property (nonatomic, assign) int orgId;

///归属人 id
@property (nonatomic, assign) int toMemberId;

///邮箱
@property (nonatomic, strong) NSString * email;

///公司
@property (nonatomic, strong) NSString * company;

///手机
@property (nonatomic, strong) NSString * userTel;

///座机
@property (nonatomic, strong) NSString * landline;

///姓名
@property (nonatomic, strong) NSString * userName;

///职位
@property (nonatomic, strong) NSString * depposition;

///生日
@property (nonatomic, strong) NSString * birthday;

///性别 1 男;2 女;3 未知
@property (nonatomic, strong) NSString * gender;

///权限 E企业可见;U个人可见
@property (nonatomic, strong) NSString * authority;

///创建者userid
@property (nonatomic, strong) NSString * createUserId;

@end

NS_ASSUME_NONNULL_END
