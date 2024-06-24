//
//  NSString+HXCategory.h
//  test
//
//  Created by 孙海平 on 16/12/13.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (HXCategory)
/**
 *  yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)stringFromDate:(NSDate *)date;
/********* yyyy-MM-dd HH:mm:00  ********/
/**
 yyyy-MM-dd HH:mm
 */
+ (NSString *)stringFromMinDate:(NSDate *)date;

/********* yyyy-MM-dd HH:mm:ss -> yyyy/MM/dd********/
+ (NSString *)stringFromDayDate:(NSDate *)date;

/********* yyyy-MM-dd HH:mm:ss -> yyyy/MM/dd HH:mm********/
+ (NSString *)stringFromNoticeDateStr:(NSString *)dateStr;
/********* yyyy-MM-dd HH:mm:ss -> yyyy-MM-dd********/
+(NSString *)stringFromDateStr:(NSString *)dateStr;

+(NSString *)zeroStringFromDate:(NSDate *)date;

+(NSString *)AMPMStringFromDateStr:(NSString *)dateStr;

/********* yyyy年MM月dd日 aaaHH:mm ********/
+ (NSString *)ymdsStringFromDate:(NSDate *)date;


/********* yyyy年MM月dd日 ********/

/**
 yyyy年MM月dd日

 @param dateStr 2019/1/1
 @return yyyy年MM月dd日 或 今天
 */
+ (NSString *)ymdStringFromDateStr:(NSString *)dateStr;


/********* hh:mm ********/
+(NSString *)hoursAndMinutesStringFromDate:(NSDate *)date;

#pragma mark - 以时间戳格式化时间 -> MM-dd HH:mm
+ (NSString *)changeStrFromTimeSince:(CGFloat)timeInterval;

#pragma mark - 以时间戳格式化时间 -> yyyyMMddHHmm
+ (NSString *)getTimeStrFromTimeSince:(CGFloat)timeInterval;

/********* hh:mm ********/
/**
 生成时间字符串

 @param date date对象
 @param dateFormatterStr 时间格式 如： yyyy-MM-dd HH:mm:ss 如果dateFormatterStr 为nil 默认yyyy-MM-dd HH:mm:ss
 @return 时间字符串
 */
+(NSString *)stringFromDate:(NSDate *)date DateFormatterStr:(NSString *)dateFormatterStr;

/**
 根据时间返回星期
 */
+ (NSString *)getWeekDayFordate:(NSDate *)data;

+ (NSDate *)getNextTwoHourDate;

+ (NSString *)dictionaryToJson:(NSDictionary *)dic;


/**
 获取六位随机数

 @return 六位随机数字符串
 */
+ (NSString *)getSixRandomNumber;

+ (NSString *)getFourRandomNumber;

+ (NSString *)getThreeRandomNumber;

/**
 *  MD5加密, 32位 小写
 *
 *
 *  @return 返回加密后的字符串
 */
-(NSString *)MD5ForLower32Bate;

/**
 *  MD5加密, 32位 大写
 *
 *
 *  @return 返回加密后的字符串
 */
-(NSString *)MD5ForUpper32Bate;

/**
 *  MD5加密, 16位 小写
 *
 *
 *  @return 返回加密后的字符串
 */
-(NSString *)MD5ForLower16Bate;

/**
 *  MD5加密, 16位 大写
 *
 *
 *  @return 返回加密后的字符串
 */
-(NSString *)MD5ForUpper16Bate;

/********* 将整型转为00：00格式 ********/
+ (NSString * )getDataStringByInt:(NSInteger)time;

/********* 将整型转为0：00格式 ********/
+ (NSString * )getDataStringByInt2:(NSInteger)time;

/********* 将整型转为00:00：00格式 ********/
+ (NSString * )getDataStringByInt3:(NSInteger)time;

/********* 将浮点型转为00：00格式 ********/
+ (NSString *)getDataStringByFloat:(CGFloat)time;

/********* 将秒为单位的时长字符串转 成 *时 *分 *秒 ********/
+ (NSString *)getDurationWithTimeStr:(NSString *)timeStr;

/********* 生成唯一ID ********/
+ (NSString *)createOnlyCode;

/********* 正则表达式 ********/
- (BOOL)regularExpressionWithPattern:(NSString *)pattern;


//邮箱
- (BOOL)isEmailAddress;

/********* 中文转拼音 ********/
//+ (NSString *)turnInChinesePinYinWithStr:(NSMutableString *)str;
///********* 获取大写首字母 ********/
//+ (NSString *)firstCharactor:(NSString *)str;
///********* 判断字符串首字符是否为字母 ********/
//+ (BOOL)judgeString:(NSString *)string;

/**
 获取头像title
 */
+ (NSString *)getAvatarStr:(NSString *)text;


/**
 直接转文件的MD5
 
 @param path 文件地址
 @return 32位小写的MD5
 */
+ (NSString *)file_md5:(NSString*)path;
//计算NSData 的MD5值
+ (NSString *)getMD5WithData:(NSData*)data;

/**
 根据整形比特获取文件

 @param size 大小
 @return xxM xxB xxk
 */
+ (NSString *)getFileSizeWithint:(NSInteger)size;

/**
 时间戳转时间

 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString DateFormatterStr:(NSString *)dateFormatterStr;
/**
 截取字符串成xxx...xxx

 @param str
 @return xxx...xxx
 */
+ (NSString *)cutString:(NSString *)str;

/**
 根据数组切割字符串

 @param numArr 分割字符数组
 @param replaseStr 插入的字符
 @return 分割的后的字符
 */
+ (NSString *)cutString:(NSMutableString *)str wtihNumArr:(NSArray *)numArr replaseStr:(NSString *)replaseStr;

/**
 把时间改成超过一天的显示正常日期 今天 显示今天 昨天显示昨天

 @param timeDate 时间日期
 @return ***
 */
//+ (NSString *)changeStrFramDate:(NSString *)timeDate;

//- (BOOL)tz_containsString:(NSString *)string;


/**
 相对路径转换成绝对路径

 @param relativePath 相对路径
 @return 绝对路径
 */
+ (NSString *)getAbsolutePathFromRelativePath:(NSString *)relativePath;

/**
 绝对路径转换成相对路径

 @param absolutePath 绝对路径
 @return 相对路径
 */
+ (NSString *)getRelativePathFromAbsolutePath:(NSString *)absolutePath;

/**
 不区分大小写比较字符串
 */
- (BOOL)isEqualToCaseString:(NSString *)aString;

#pragma mark - 按字节截取字符串

/**
 按字节从头截取字符串

 @param index 截取多少字节
 */
- (NSString *)subStringByByteWithIndex:(NSInteger)index;

#pragma mark - 按字节截取字符串
/**
 当前字符串有多少字节
 */
- (int)getByteNum;

/********* URL转码 （url中保含“+” 不转后台不识别） ********/
+ (NSString *)TranscodingURL:(NSString *)str;

-(CGSize)getSizeOfStringWihtFont:(int)fontSize addMaxSize:(CGSize)maxSize;

+ (CGRect)heightForString:(NSString *)str Size:(CGSize)size Font:(UIFont *)font Lines:(NSInteger)lines;

+ (CGRect)heightForString:(NSString *)str Size:(CGSize)size Font:(UIFont *)font;

/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxWidth label宽度
 *  @param font  字体
 *  @param lineSpacing  行间距
 *  @param text  内容
 */
+ (CGSize)boundingRectWithWidth:(CGFloat)maxWidth
                  withTextFont:(UIFont *)font
               withLineSpacing:(CGFloat)lineSpacing
                          text:(NSString *)text;

/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxHeight label高度度
 *  @param font  字体
 *  @param text  内容
 */
+ (CGSize)boundingRectWithHeight:(CGFloat)maxHeight
                    withTextFont:(UIFont *)font
                            text:(NSString *)text;

- (NSString *)formatTel;

#pragma mark - 获取计时时间字符串
/**
 获取计时时间字符串

 @param time 总时长
 @return 00:00：00
 */
+ (NSString * )getTimingStringByTime:(NSInteger)time;


#pragma mark - 获取计时时间字符串
/**
 获取计时时间字符串
 
 @param time 总时长
 @return 00：00
 */
+ (NSString * )getTimeStringByTime:(NSInteger)time;

/**
 去掉字符串首尾空格
 */
- (NSString *)removeTheLeadingAndTrailingSpaces;


#pragma mark - 电话号码格式化 +替换为00 去除0086
/**
 电话号码格式化 +替换为00 去除0086

 @param telStr 电话号码
 @return 新的电话号
 */
+ (NSString *)formatTelNumber:(NSString *)telStr;


+(NSString *)subTextString:(NSString*)str len:(NSInteger)len;



/// 字符串包含字符串
/// @param subStr 包含字符串
/// @param string 源字符串
+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string;

@end
