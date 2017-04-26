//
//  NSDateFormatter+SAYConvert.m
//  SAYAdditions
//
//  Created by CainGoodbye on 25/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import "NSDateFormatter+SAYConvert.h"

@implementation NSDateFormatter (SAYConvert)

- (void)dateFormatterForType:(SAYDateType)type atTimeZone:(float)timeZone {
    self.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:timeZone * 3600];
    switch (type) {
        case SAYDateTypeMinute:
            self.dateFormat = @"mm";
            break;
        case SAYDateTypeHour:
            self.dateFormat = @"HH";
            break;
        case SAYDateTypeDay:
            self.dateFormat = @"d";
            break;
        case SAYDateTypeTime:
            self.dateFormat = @"HH:mm";
            break;
        case SAYDateTypeDate:
            self.dateFormat = @"yyyy-MM-dd";
            break;
        case SAYDateTypeNormal:
            self.dateFormat = @"yyyy-MM-dd HH:mm";
            break;
        case SAYDateTypeYear:
            self.dateFormat = @"yyyy";
            break;
        case SAYDateTypeMonth:
            self.dateFormat = @"MM";
            break;
    }
}

- (NSString *)say_dateStringWithTimestamp:(double)timestamp
                               inTimeZone:(float)origin
                              outTimeZone:(float)target
                                  outType:(SAYDateType)type {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp - origin * 3600];
    [self dateFormatterForType:type atTimeZone:target];
    return [self stringFromDate:date];
}

- (NSString *)say_pekDateStringWithTimestamp:(double)timestamp
                                  inTimeZone:(float)origin
                                     outType:(SAYDateType)type {
    return [self say_dateStringWithTimestamp:timestamp
                                  inTimeZone:origin
                                 outTimeZone:8
                                     outType:type];
}

- (NSString *)say_mobileDateStringWithTimestamp:(double)timestamp
                                        outType:(SAYDateType)type {
    return [self say_dateStringWithTimestamp:timestamp
                                  inTimeZone:0
                                 outTimeZone:0
                                     outType:type];
}

@end
