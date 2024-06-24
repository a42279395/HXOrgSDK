//
//  HXOrgMemberListModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/28.
//

#import <Foundation/Foundation.h>

#import <HXOrgSDK/HXOrgMemberModel.h>

@interface HXOrgMemberListModel : NSObject
@property (nonatomic, strong) NSArray<HXOrgMemberModel *> * list;
@end
