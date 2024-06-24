//
//  HXOrgManagerListModel.h
//  Runner
//
//  Created by sunhaiping on 2024/5/28.
//

#import <Foundation/Foundation.h>

#import <HXOrgSDK/HXOrgAdminModel.h>

@interface HXOrgAdminListModel : NSObject
@property (nonatomic, strong) NSArray<HXOrgAdminModel *> * list;
@end

