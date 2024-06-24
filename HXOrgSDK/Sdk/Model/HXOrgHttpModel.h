//
//  HXOrgHttpModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/27.
//

#import <Foundation/Foundation.h>

#import "HXOrgModel.h"

@interface HXOrgHttpModel : NSObject
///企业id
@property (nonatomic, assign) int mainId;

///企业名称
@property (nonatomic, strong) NSString * orgname;

///行业id
@property (nonatomic, strong) NSString * classid;

///地址
@property (nonatomic, strong) NSString * address;

///邮箱
@property (nonatomic, strong) NSString * memail;

///联系电话
@property (nonatomic, strong) NSString * utel;

///网站
@property (nonatomic, strong) NSString * webpage;

///最大人数
@property (nonatomic, assign) int maxnum;

///是否已认证
@property (nonatomic, strong) NSString * isauth;

///企业头像
@property (nonatomic, strong) NSString * org_avatar;

///营业执照号码
@property (nonatomic, strong) NSString * blid;

///自身身份
@property (nonatomic, strong) NSString * auth;

///自身成员id
@property (nonatomic, assign) int memberid;


- (instancetype)initWithOrgModel:(HXOrgModel *)model;
@end

