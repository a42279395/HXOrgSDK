//
//  NSString+HXCategory.m
//  test
//
//  Created by 孙海平 on 16/12/13.
//  Copyright © 2016年 孙海平. All rights reserved.
//

#import "NSString+HXCategory.h"
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSDate+Category.h"

#import "HXPublicHeader.h"

#define CHUNK_SIZE 1024

@implementation NSString (HXCategory)


+(NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+ (NSString *)stringFromDayDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


+(NSString *)stringFromDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * date = [dateFormatter dateFromString:dateStr];
    
    NSString *destDateString = [dateFormatter1 stringFromDate:date];
    
    return destDateString;
}

+ (NSString *)stringFromNoticeDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter1 setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSDate * date = [dateFormatter dateFromString:dateStr];
    
    NSString *destDateString = [dateFormatter1 stringFromDate:date];
    
    return destDateString;
}


+ (NSString *)stringFromMinDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}


+ (NSString *)stringFromDate:(NSDate *)date DateFormatterStr:(NSString *)dateFormatterStr
{
    if(IsStrEmpty(dateFormatterStr))
    {
        dateFormatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatterStr];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(NSDate *)data
{
//    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], GetSysStr(@"Sunday"), GetSysStr(@"Monday"), GetSysStr(@"Tuesday"), GetSysStr(@"Wednesday"), GetSysStr(@"Thursday"), GetSysStr(@"Friday"), GetSysStr(@"Saturday"), nil];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:data];
    
//    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return @"";
//    return weekStr;
}

+(NSString *)zeroStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:00"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)ymdsStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setAMSymbol:@"上午"];
    [dateFormatter setPMSymbol:@"下午"];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 aaaHH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)AMPMStringFromDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate * date = [dateFormatter dateFromString:dateStr];
    
    [dateFormatter setAMSymbol:@"上午"];
    [dateFormatter setPMSymbol:@"下午"];
    [dateFormatter setDateFormat:@"aaaHH:mm"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSString *)ymdStringFromDateStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate * date = [dateFormatter dateFromString:dateStr];
    
    if ([date isToday]) {
        return @"今天";
    }
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * newStr = [dateFormatter stringFromDate:date];
    return newStr;
}


+(NSString *)hoursAndMinutesStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+ (NSDate *)getNextTwoHourDate{
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [calendar components: NSCalendarUnitEra |NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute fromDate: date];
    
    [comps setMinute:00];
    
    return [calendar dateFromComponents:comps];
}

/********* 获取六位随机数 ********/
+ (NSString *)getSixRandomNumber
{
    int a = arc4random() % 100000;
    
    NSString *str = [NSString stringWithFormat:@"%06d", a];
    return str;
}

+ (NSString *)getThreeRandomNumber
{
    int a = arc4random() % 100;
    
    NSString *str = [NSString stringWithFormat:@"%03d", a];
    return str;
}

+ (NSString *)getFourRandomNumber
{
    int a = arc4random() % 1000;
    
    NSString *str = [NSString stringWithFormat:@"%04d", a];
    return str;
}

/********* 正则表达式过滤字符串 ********/
+ (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *filterText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:filterText options:NSMatchingReportCompletion range:NSMakeRange(0, filterText.length) withTemplate:@""];
    return result;
}


//字典转为Json字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - MD5 32位 小写
-(NSString *)MD5ForLower32Bate{
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - MD5 32位 大写
-(NSString *)MD5ForUpper32Bate{
    
    //要进行UTF8的转码
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - MD5 16位 大写
-(NSString *)MD5ForUpper16Bate{
    
    NSString *md5Str = [self MD5ForUpper32Bate];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - MD5 16位 小写
-(NSString *)MD5ForLower16Bate{
    
    NSString *md5Str = [self MD5ForLower32Bate];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
//将整型转为00：00格式
+ (NSString * )getDataStringByInt:(NSInteger)time{
    
    NSInteger b = 0;
    NSInteger c = 0;
    b = (time%(60*60))/60;
    c = (time%(60*60))%60;
    if (b == 0 && c == 0) {
        c = 1;
    }
    return [@"" stringByAppendingFormat:@"%ld%ld:%ld%ld",(long)(b/10),(long)(b%10),(long)(c/10),(long)(c%10)];
}
//将整型转为00：00格式
+ (NSString * )getDataStringByInt2:(NSInteger)time{
    
    NSInteger b = 0;
    NSInteger c = 0;
    b = (time%(60*60))/60;
    c = (time%(60*60))%60;
    if (b == 0 && c == 0) {
        c = 1;
    }
    return [@"" stringByAppendingFormat:@"%ld:%ld%ld",(long)(b%10),(long)(c/10),(long)(c%10)];
}
//将整型转为00:00：00格式
+ (NSString * )getDataStringByInt3:(NSInteger)time{
    NSInteger a = 0;
    NSInteger b = 0;
    NSInteger c = 0;
    a = (time/(60*60));
    b = (time%(60*60))/60;
    c = (time%(60*60))%60;
    if ( a == 0 && b == 0 && c == 0) {
        c = 1;
    }
    if (a == 0) {
        return [@"" stringByAppendingFormat:@"%ld%ld:%ld%ld",(long)(b/10),(long)(b%10),(long)(c/10),(long)(c%10)];
    } else {
        return [@"" stringByAppendingFormat:@"%ld:%ld%ld:%ld%ld",a,(long)(b/10),(long)(b%10),(long)(c/10),(long)(c%10)];
    }
}

//将浮点型转为00：00格式
+ (NSString * )getDataStringByFloat:(CGFloat)time{
    NSInteger a = roundf(time);
    NSInteger b = 0;
    NSInteger c = 0;
    b = (a%(60*60))/60;
    c = (a%(60*60))%60;
    if (b == 0 && c == 0) {
        c = 1;
    }
    return [@"" stringByAppendingFormat:@"%ld%ld:%ld%ld",(long)(b/10),(long)(b%10),(long)(c/10),(long)(c%10)];
    
}

/********* 将秒为单位的时长字符串转 成 *时 *分 *秒 ********/
+ (NSString *)getDurationWithTimeStr:(NSString *)timeStr{
    NSInteger time = [timeStr integerValue];
    NSInteger min = time/60;
    NSInteger hour = min/60;
    if (time < 60) {
        
        return [NSString stringWithFormat:@"%ld 秒",time];
        
    }else if (min < 60){
        NSInteger sec = time%60;
        if (sec == 0) {
            return [NSString stringWithFormat:@"%ld 分",min];
        }else{
            
            return [NSString stringWithFormat:@"%ld 分 %ld 秒",min,sec];
        }
        
    }else{
        
        NSInteger tMin = min%60;
        
        if (tMin == 0) {
            
            return [NSString stringWithFormat:@"%ld 小时",hour];
            
        }else{
            
            return [NSString stringWithFormat:@"%ld 小时 %ld 分",hour,tMin];
        }
        
    }
    
}

#pragma mark 正则表达
- (BOOL)regularExpressionWithPattern:(NSString *)pattern{

    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;

}

#pragma mark 判断邮箱格式

/**
 判断邮箱格式

 @return yes/no
 */
- (BOOL)isEmailAddress{
    NSString *emailRegex = @"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    return [self regularExpressionWithPattern:emailRegex];
}

+ (NSString *)createOnlyCode
{
    //nid 生成唯一字符串
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *uniqueId = (__bridge NSString *)(uuidStringRef);

    NSArray *array = [uniqueId componentsSeparatedByString:@"-"];

    NSString *machineId = [array componentsJoinedByString:@""];
    
//    NSMutableString * machineId = [NSMutableString string];
//
//    for (NSString * str in array) {
//        [machineId appendString:str];
//    }
    
    CFRelease(uuidStringRef);

    return machineId;
}

//+ (NSString *)firstCharactor:(NSString *)str
//{
//    if (IsStrEmpty(str)) {
//        return @"";
//    }
//    NSString * str1 = [NSString turnInChinesePinYinWithStr:[NSMutableString stringWithString:str]];
////    //转化为大写拼音
////    NSString *pinYin = [str1 capitalizedString];
//    //获取并返回首字母
//    
//    if (str1.length < 1) {
//        return @"#";
//    }
//    char c = [str1 characterAtIndex:0];
//    if (c>='a' && c<='z')
//    {
//        return [NSString stringWithFormat:@"%c",c-32];
//    }else if(c>='A' && c<='Z')
//    {
//        return  [str1 substringToIndex:1];
//        
//    }
//    else //其他字符都用#代替
//    {
//        return @"#";
//    }
//}

//
//+ (NSString *)getAvatarStr:(NSString *)text
//{
//  
//    
//    text = [text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    if (IsStrEmpty(text)) {
//        return @"";
//    }
//    
//    NSRange range = [text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
//    
//    NSString * newStr = [text substringWithRange:range];
//
//    if ([NSString judgeString:newStr]) {
//        //英文
//        char tempChar = [newStr characterAtIndex:0];
//        
//        if (tempChar >= 'a' && tempChar <= 'z')
//        {
//            return [NSString stringWithFormat:@"%c",tempChar-32];
//        }else{
//            return  newStr;
//        }
//    }else{
//        return  newStr;
//    }
//}

//+ (BOOL)judgeString:(NSString *)string{
//    
//    NSString *regex =@"[A-Za-z]+";
//    NSPredicate*predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//    return[predicate evaluateWithObject:string];
//}





+ (NSString *)file_md5:(NSString*) path

{
    
    NSFileHandle* handle = [NSFileHandle fileHandleForReadingAtPath:path];
    
    if(handle == nil)
        
        return nil;
    
    
    
    CC_MD5_CTX md5_ctx;
    
    CC_MD5_Init(&md5_ctx);
    
    
    
    NSData* filedata;
    
    do {
        
        filedata = [handle readDataOfLength:CHUNK_SIZE];
        
        CC_MD5_Update(&md5_ctx, [filedata bytes], (int)[filedata length]);
        
    }
    
    while([filedata length]);
    
    
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5_Final(result, &md5_ctx);
    
    
    
    [handle closeFile];
    
    
    
    NSMutableString *hash = [NSMutableString string];
    
    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
        
    {
        
        [hash appendFormat:@"%02x",result[i]];
        
    }
    
    return [hash lowercaseString];
    
}

+ (NSString*)getMD5WithData:(NSData *)data{
//    const char* original_str = (const char *)[data bytes];
//    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
//    CC_MD5(original_str, (uint)strlen(original_str), digist);
//    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
//    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
//        [outPutStr appendFormat:@"%02x",digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
//    }
//    //也可以定义一个字节数组来接收计算得到的MD5值
//    //    Byte byte[16];
//    //    CC_MD5(original_str, strlen(original_str), byte);
//    //    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
//    //    for(int  i = 0; i<CC_MD5_DIGEST_LENGTH;i++){
//    //        [outPutStr appendFormat:@"%02x",byte[i]];
//    //    }
//    //    [temp release];
//    
//    return outPutStr;
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        
        [ret appendFormat:@"%02x",result[i]];
        
    }
    
    return ret;
    
}


//+(NSString *)MD5HexDigest:(NSData *)input {
//    
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5(input.bytes, (CC_LONG)input.length, result);
//    
//    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
//    
//    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
//        
//        [ret appendFormat:@"%02x",result[i]];
//        
//    }
//    
//    return ret;
//    
//}

#pragma mark - 返回文件大小

+ (NSString *)getFileSizeWithint:(NSInteger)size{
    
    CGFloat k = size/1024;
    CGFloat m;
    CGFloat g;
    NSString * sizeStr;
    if (k >= 1) {
        
        m = k/1024;
        if (m >= 1) {
            
            g = m/1024;
            
            if (g >= 1) {
                 sizeStr = [NSString stringWithFormat:@"%.1lfG",g];
            }else{
                
                sizeStr = [NSString stringWithFormat:@"%.1lfM",m];
            }
            
        }else{
            
            sizeStr = [NSString stringWithFormat:@"%.1lfK",k];
        }
        
    }else{
        
        sizeStr = [NSString stringWithFormat:@"%ldB",size];
    }
    
    return sizeStr;
}

//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString DateFormatterStr:(NSString *)dateFormatterStr{
    
    
    if(IsStrEmpty(dateFormatterStr))
    {
        dateFormatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatterStr];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

//截取长字符串
+ (NSString *)cutString:(NSString *)str{
    if (str.length >= 25) {
        
        NSString * startStr = [str substringToIndex:8];
        
        NSString * endStr = [str substringFromIndex:str.length - 8];
        
        return [NSString stringWithFormat:@"%@%@%@",startStr,@"...",endStr];
    }else{
        return str;
    }
    
}

//切割字符串
+ (NSString *)cutString:(NSMutableString *)str wtihNumArr:(NSArray *)numArr replaseStr:(NSString *)replaseStr{
    
    for (NSNumber * num in numArr) {
        
        NSInteger numInt = [num integerValue];
        
        if (numInt < str.length) {
            [str insertString:replaseStr atIndex:numInt];
        }
    }
    
    return str;
}

//+ (NSString *)changeStrFramDate:(NSString *)timeStr{
//    
//    NSString * str;
//    
//    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
//    
//    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    NSDate * date = [dateformatter dateFromString:timeStr];
//    
//    NSDateFormatter * dateformatter1 = [[NSDateFormatter alloc] init];
//    
//    dateformatter1.dateFormat = @"yyyy/MM/dd";
//    
//    str = [dateformatter1 stringFromDate:date];
//    
//    if (!date) {
//        
//        NSDateFormatter * dateformatter2 = [[NSDateFormatter alloc] init];
//        
//        dateformatter2.dateFormat = @"yyyy-MM-dd";
//        
//        date = [dateformatter2 dateFromString:timeStr];
//        
//        str = [dateformatter1 stringFromDate:date];;
//    }
//    
//    if (date.isToday) {
//        
//        str = GetSysStr(@"today");
//    }
//    
//    if ([date isYesterday]) {
//        
//        str = GetSysStr(@"yesterday");
//    }
//    
//    if ([date isTomorrow]) {
//        
//        str = GetSysStr(@"tomorrow");
//    }
//    
//    return str;
//}

#pragma mark - 以时间戳格式化时间 -> MM-dd HH:mm
+ (NSString *)changeStrFromTimeSince:(CGFloat)timeInterval{
    
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSString * str;
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    
    dateformatter.dateFormat = @"YYYY/MM/dd HH:mm";
    
    str = [dateformatter stringFromDate:date];
    
    
    NSDateFormatter * timeDateformatter = [[NSDateFormatter alloc] init];
    
    timeDateformatter.dateFormat = @"HH:mm";
    
    NSString * timeStr = [timeDateformatter stringFromDate:date];
    
    NSDateFormatter * dateformatter1 = [[NSDateFormatter alloc] init];
    
    dateformatter1.dateFormat = @"MM/dd HH:mm";
    
    str = [date formattedTime];
    if ([date isToday]) {
    }else if ([date isThisWeek]){
        str = [date weekdayStringFromDate];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy/MM/dd";
        str = [dateFormatter stringFromDate:date];
    }
    
//    if (date.isThisYear) {
//
//         str = [dateformatter1 stringFromDate:date];
//    }
//
//    if (date.isToday) {
//
//        str = [NSString stringWithFormat:@"%@ %@",@"今天",timeStr];
//    }
//
//    if ([date isYesterday]) {
//
//        str = [NSString stringWithFormat:@"%@ %@",@"昨天",timeStr];
//    }
    
    return str;
}


#pragma mark - 以时间戳格式化时间 -> yyyyMMddHHmm
+ (NSString *)getTimeStrFromTimeSince:(CGFloat)timeInterval{
    
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSString * str;
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    
    dateformatter.dateFormat = @"yyyyMMddHHmm";
    
    str = [dateformatter stringFromDate:date];
    
    return str;
}

//- (BOOL)tz_containsString:(NSString *)string {
//    if (iOS8Later) {
//        return [self containsString:string];
//    } else {
//        NSRange range = [self rangeOfString:string];
//        return range.location != NSNotFound;
//    }
//}

+ (NSString *)getAbsolutePathFromRelativePath:(NSString *)relativePath{
    NSString * str = [@"" stringByAppendingPathComponent:relativePath];
    
    return [str stringByExpandingTildeInPath];
}

+ (NSString *)getRelativePathFromAbsolutePath:(NSString *)absolutePath{
    
    NSString * str = [@"" stringByAppendingPathComponent:absolutePath];
    
    return [str stringByAbbreviatingWithTildeInPath];
}

- (BOOL)isEqualToCaseString:(NSString *)aString{
    
    BOOL result = [self caseInsensitiveCompare:aString] == NSOrderedSame;
    
    return result;
}

//字符串的所以字节
- (int)getByteNum{
    
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

//按字节截取字符串
- (NSString *)subStringByByteWithIndex:(NSInteger)index{
    
    if ([self getByteNum] <= index) {
        
        return self;
    }
    
    NSInteger sum = 0;
    
    NSString *subStr = [[NSString alloc] init];
    
    for(int i = 0; i<[self length]; i++){
        
        unichar strChar = [self characterAtIndex:i];
        
        if(strChar < 256){
            sum += 1;
        }
        else {
            sum += 2;
        }
        if (sum >= index) {
            
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    
    return subStr;
}

/********* URL转码 （url中保含“+” 不转后台不识别） ********/
+ (NSString *)TranscodingURL:(NSString *)str
{
    NSString * string = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)@"+", kCFStringEncodingUTF8));
    return string;
}

-(CGSize)getSizeOfStringWihtFont:(int)fontSize addMaxSize:(CGSize)maxSize{
    
    CGSize size=[self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size;
}

+ (CGRect)heightForString:(NSString *)str Size:(CGSize)size Font:(UIFont *)font
{
    return [NSString heightForString:str Size:size Font:font Lines:0];
}

+ (CGRect)heightForString:(NSString *)str Size:(CGSize)size Font:(UIFont *)font Lines:(NSInteger)lines
{
    if (IsStrEmpty(str))
    {
        return CGRectMake(0, 0, 0, 0);
    }
    static UILabel *lbtext;
    if (lbtext == nil)
    {
        lbtext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    else
    {
        lbtext.frame = CGRectMake(0, 0, size.width, size.height);
    }
    lbtext.font = font;
    lbtext.text = str;
    lbtext.numberOfLines = lines;
    CGRect rect = [lbtext textRectForBounds:lbtext.frame limitedToNumberOfLines:lines];
    if(rect.size.height < 0)
    {
        rect.size.height = 0;
    }
    if (rect.size.width < 0)
    {
        rect.size.width = 0;
    }
    return rect;
}

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
                          text:(NSString *)text{
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    [paragraphStyle setLineSpacing:lineSpacing];
    //#warning 此处设置NSLineBreakByTruncatingTail会导致计算文字高度方法失效
    //    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    //计算文字尺寸
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}

/**
 *  根据文字内容动态计算UILabel宽高
 *  @param maxHeight label高度度
 *  @param font  字体
 *  @param text  内容
 */
+ (CGSize)boundingRectWithHeight:(CGFloat)maxHeight
                    withTextFont:(UIFont *)font
                            text:(NSString *)text{
    
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, maxHeight);
    //段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
//    [paragraphStyle setLineSpacing:lineSpacing];
    //#warning 此处设置NSLineBreakByTruncatingTail会导致计算文字高度方法失效
    //    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    
    //计算文字尺寸
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return size;
}


- (NSString *)formatTel {
    if (IsStrEmpty(self)) return self;
    NSArray *array = @[
                       @"010",//北京
                       @"020",//广州
                       @"021",//上海
                       @"022",//天津
                       @"023",//重庆
                       @"024",//沈阳
                       @"025",//南京
                       @"027",//武汉
                       @"028",//成都
                       @"029",//西安
                       @"852",//香港
                       @"853"//澳门
                       ];
    NSMutableString* mStr = [NSMutableString stringWithString:[self stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if ([self hasPrefix:@"1"]) {
        //手机号码
        //格式 3 4 4
        if (mStr.length > 3) {
            [mStr insertString:@" " atIndex:3];
        }if (mStr.length > 8) {
            [mStr insertString:@" " atIndex:8];
        }
    }else {
        //座机号码
        BOOL has = [array containsObject:self.length > 2 ? [self substringToIndex:3] : self];
        //判断区号中是否包含特殊的
        NSInteger index1 = has ? 3 : 4;
        NSInteger index2 = has ? 8 : 9;
        if (mStr.length > 3) {
            [mStr insertString:@" " atIndex:index1];
        }if (mStr.length > 8) {
            [mStr insertString:@" " atIndex:index2];
        }
    }
    return mStr.description;
}




#pragma mark - 通过值获取计时
+ (NSString * )getTimingStringByTime:(NSInteger)time{
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",time/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(time%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",time%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;

}

+ (NSString * )getTimeStringByTime:(NSInteger)time{
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(time%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",time%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}

#pragma mark - 去掉字符串首尾空格
- (NSString *)removeTheLeadingAndTrailingSpaces {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark - 电话号码格式化 +替换为00 去除0086
+ (NSString *)formatTelNumber:(NSString *)telStr
{
    if ([telStr hasPrefix:@"+"]) {
        //+开头 替换为 00
        telStr = [telStr stringByReplacingOccurrencesOfString:@"+" withString:@"00"];
    }
    if ([telStr hasPrefix:@"0086"]) {
        //去除中国区域码
        telStr = [telStr substringFromIndex:4];
    }
    
    //剔除除数字之外的字符
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSCharacterSet *specCharacterSet = [characterSet invertedSet];
    NSArray *strArr = [telStr componentsSeparatedByCharactersInSet:specCharacterSet];
    telStr = [strArr componentsJoinedByString:@""];

    return telStr;
}


+ (NSString *)subTextString:(NSString*)str len:(NSInteger)len{
    
    if(str.length<=len) return str;
    int count=0;
    NSMutableString *sb = [NSMutableString string];

    for (int i=0; i<str.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *aStr = [str substringWithRange:range];
        count += [aStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>1?2:1;
        [sb appendString:aStr];
        if(count >= len*2) {
            return [sb copy];
        }
  }
  return str;
}

+ (NSArray*)rangeOfSubString:(NSString*)subStr inString:(NSString*)string {

    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSString*string1 = [string stringByAppendingString:subStr];
    
    NSString *temp;
    
    for(int i =0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        
        if ([temp isEqualToString:subStr]) {
            
            NSRange range = {i,subStr.length};
            
            [rangeArray addObject: [NSValue valueWithRange:range]];
            
        }
        
    }
    
    return rangeArray;

}


@end
