//
//  NSString+Operation.h
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;
@import UIKit;

@interface NSString (Operation)

- (BOOL)say_containsString:(NSString *)string;
- (NSString *)say_removeAllSpace;
- (BOOL)say_isValid;
- (BOOL)say_empty;
- (CGFloat)say_textHeightByAdjustWidth:(CGFloat)width font:(UIFont *)font;
- (CGFloat)say_textWidthByAdjustheight:(CGFloat) height font:(UIFont *) font;

- (NSString *)say_MD5String;
@end
