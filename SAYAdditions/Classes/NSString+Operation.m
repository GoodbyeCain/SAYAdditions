//
//  NSString+Operation.m
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import "NSString+Operation.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Operation)

- (BOOL)say_containsString:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSString *)say_removeAllSpace {
    NSMutableString *mString = [NSMutableString stringWithString:self];
    
    const char *UTF8String = mString.UTF8String;
    for (NSInteger i = mString.length - 1; i >= 0; i--) {
        char character = UTF8String[i];
        if (character == ' ' || character == '\n' || character == '\r') {
            [mString deleteCharactersInRange:NSMakeRange(i, 1)];
        }
    }
    
    return mString;
}

- (BOOL)say_isValid {
    if ([[self say_removeAllSpace] isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

- (BOOL)say_empty {
    if ([self isEqualToString:@""]) {
        return YES;
    } else {
        return NO;
    }
}

- (CGFloat)say_textHeightByAdjustWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGRect rect =
    [self boundingRectWithSize:size
                       options:NSStringDrawingTruncatesLastVisibleLine |
     NSStringDrawingUsesLineFragmentOrigin |
     NSStringDrawingUsesFontLeading
                    attributes:@{
                                 NSFontAttributeName : font
                                 } context:nil];
    return rect.size.height;
}

- (CGFloat)say_textWidthByAdjustheight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGRect rect =
    [self boundingRectWithSize:size
                       options:NSStringDrawingTruncatesLastVisibleLine |
     NSStringDrawingUsesLineFragmentOrigin |
     NSStringDrawingUsesFontLeading
                    attributes:@{
                                 NSFontAttributeName : font
                                 } context:nil];
    return rect.size.width;
}

- (NSString *)say_MD5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString
            stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5],
            result[6], result[7], result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

@end
