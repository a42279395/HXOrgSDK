//
//  HXPublicHeader.h
//  Runner
//
//  Created by sunhaiping on 2024/5/23.
//

#ifndef HXPublicHeader_h
#define HXPublicHeader_h



#ifdef DEBUG // 调试状态, 打开LOG功能
#define HXLog(...) NSLog(@"%@ %s 第%d行 \n %@\n\n",[NSDate date],__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else // 发布状态, 关闭LOG功能
#define HXLog(...)
#endif

// 判空处理
//是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
//字典是否为空
#define IsDicEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))


#define WS(weakSelf) __weak typeof(self) weakSelf = self;

#endif /* HXPublicHeader_h */
