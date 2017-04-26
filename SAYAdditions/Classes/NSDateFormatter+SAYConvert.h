//
//  NSDateFormatter+SAYConvert.h
//  SAYAdditions
//
//  Created by CainGoodbye on 25/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SAYDateType) {
    SAYDateTypeMinute,
    SAYDateTypeHour,
    SAYDateTypeDay,
    SAYDateTypeTime,
    SAYDateTypeDate,
    SAYDateTypeYear,
    SAYDateTypeMonth,
    SAYDateTypeNormal,
};

@interface NSDateFormatter (SAYConvert)

- (NSString *)say_dateStringWithTimestamp:(double)timestamp
                               inTimeZone:(float)origin
                              outTimeZone:(float)target
                                  outType:(SAYDateType)type;
- (NSString *)say_pekDateStringWithTimestamp:(double)timestamp
                                  inTimeZone:(float)origin
                                     outType:(SAYDateType)type;
- (NSString *)say_mobileDateStringWithTimestamp:(double)timestamp
                                        outType:(SAYDateType)type;

@end
