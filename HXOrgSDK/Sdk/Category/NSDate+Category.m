/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"

//#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)

#define DATE_COMPONENTS (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]


@implementation NSDate (Category)

/*距离当前的时间间隔描述*/
- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
	if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
	} else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
	} else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
	} else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text4", @""), timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text5", @"")];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text6", @""), timeInterval / 31536000];
    }
}
+ (BOOL) isEqualWithDateStr:(NSString *)dateStr Date:(NSDate *)date{
    
    NSDateFormatter * formatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    formatter.timeZone = [NSTimeZone systemTimeZone];
    
    NSDateFormatter * formatter1 = [NSDateFormatter defaultDateFormatter];
    
    formatter.timeZone = [NSTimeZone systemTimeZone];
    
    NSDate * strDate = [formatter1 dateFromString:dateStr];
    
    NSString * firstDateStr = [formatter stringFromDate:strDate];
    
    NSString * lastDateStr = [formatter stringFromDate:date];
    
    
    return [firstDateStr isEqualToString:lastDateStr];

}

//获取当前月的第一天 和最后一天日期
- (NSArray *)getMonthFirstAndLastDayWith:(NSDate *)date{

    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:date];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstString, lastString];
}


/** zlx **/
- (NSString *)getDateStringDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:GTMzone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
        //return @"今天";
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
//        [dateFormatter setDateFormat:@"ah:mm"];
//        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:self]];
        return @"昨天";
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
//        [dateFormatter setDateFormat:@"EEEE ah:mm"];
//        return [dateFormatter stringFromDate:self];
        return [self weekdayStringFromDate];
    } else {//以前
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        return [dateFormatter stringFromDate:self];
    }
}


- (NSString*)weekdayStringFromDate{
    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], GetSysStr(@"Sunday"), GetSysStr(@"Monday"), GetSysStr(@"Tuesday"), GetSysStr(@"Wednesday"), GetSysStr(@"Thursday"), GetSysStr(@"Friday"), GetSysStr(@"Saturday"), nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
     NSTimeZone* timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    
//    return [weekdays objectAtIndex:theComponents.weekday];
    
    return @"";
}

/*精确到分钟的日期描述*/
- (NSString *)minuteDescription
{
    NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    
	NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
	NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    if ([theDay isEqualToString:currentDay]) {//当天
		[dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
	} else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @'"'), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) {//间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else {//以前
		[dateFormatter setDateFormat:@"yyyy/MM/dd ah:mm"];
        return [dateFormatter stringFromDate:self];
	}
}


//- (NSString *)getChatTimeTitle
//{
//    if () {
//        
//    }
//
//
//}
/*标准时间日期描述*/
-(NSString *)formattedTime{
//    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
//    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
//    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    
    NSDate *dateNow = [NSDate date];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:dateNow.day];
    [components setMonth:dateNow.month];
    [components setYear:dateNow.year];
            
            
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger goalInterval = [zone secondsFromGMTForDate: date];
//    NSDate *date1 = [date  dateByAddingTimeInterval: goalInterval];
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { //24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"HH:mm"];
        }else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text8", @"")];
        }else {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy/MM/dd HH:mm"];
        }
    }else {
        if (hour >= 0 && hour <= 6) {
            //凌晨
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text9", @"")];
        }else if (hour > 6 && hour <=11 ) {
            //上午
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text10", @"")];
        }else if (hour > 11 && hour <= 17) {
            //下午
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text11", @"")];
        }else if (hour > 17 && hour <= 24) {
            //晚上
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text12", @"")];
        }else if (hour < 0 && hour >= -24){
            //昨天
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:NSLocalizedString(@"NSDateCategory.text13", @"")];
        }else if(hour < -24 && hour > - (24 *7)){
            
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"EEEE HH:mm"];
            
        }else  {
            dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy/MM/dd HH:mm"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

/*格式化日期描述*/
- (NSString *)formattedDateDescription
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	NSString *theDay = [dateFormatter stringFromDate:self];//日期的年月日
	NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];//当前年月日
    
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return NSLocalizedString(@"NSDateCategory.text1", @"");
	} else if (timeInterval < 3600) {//1小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text2", @""), timeInterval / 60];
	} else if (timeInterval < 21600) {//6小时内
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text3", @""), timeInterval / 3600];
	} else if ([theDay isEqualToString:currentDay]) {//当天
		[dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text14", @""), [dateFormatter stringFromDate:self]];
	} else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) {//昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(@"NSDateCategory.text7", @""), [dateFormatter stringFromDate:self]];
    } else {//以前
		[dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
        return [dateFormatter stringFromDate:self];
	}
}

- (double)timeIntervalSince1970InMilliSecond {
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)formattedTimeFromTimeInterval:(long long)time{
    return [[NSDate dateWithTimeIntervalInMilliSecondSince1970:time] formattedTime];
}

#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
	return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

#pragma mark Comparing Dates

#pragma mark 判断间隔在多少分钟之内
- (BOOL) isIntervalWithMinute:(NSUInteger)minute Date:(NSDate *)date
{
    NSTimeInterval timeInterval = [self timeIntervalSinceDate:date];
    int a = (abs((int)timeInterval/60));
    if (a <= minute) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) &&
			(components1.day == components2.day));
}

- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.weekOfMonth != components2.weekOfMonth) return NO;
	
	// Must have a time interval under 1 week. Thanks @aclark
	return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL) isThisYear
{
    // Thanks, baspellis
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
	
	return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
	return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
	NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}




+ (NSDate *)getDateFromString:(NSString *)str{
    
    //字符串转化为日期的时候 如不设置 时区 时间会少8小时
    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:GTMzone];
    NSDate *bdate = [dateFormatter dateFromString:str];
    
    return bdate;
}

+ (NSDate *)getDateUseNullZoneFromString:(NSString *)str{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *bdate = [dateFormatter dateFromString:str];
    
    return bdate;
}

+ (NSDate *)getCustomDateFrom:(NSString *)dateFrom String:(NSString *)str
{
    
    //字符串转化为日期的时候 如不设置 时区 时间会少8小时
//    NSTimeZone* GTMzone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFrom];
//    [dateFormatter setTimeZone:GTMzone];
    NSDate *bdate = [dateFormatter dateFromString:str];
    
    return bdate;
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:newDate];
	return components.hour;
}

- (NSInteger) hour
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger) minute
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger) seconds
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger) day
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger) month
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger) week
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekOfMonth;
}

- (NSInteger) weekday
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger) year
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.year;
}



@end
