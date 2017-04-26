//
//  UIColor+Create.h
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Create)
+ (UIColor *)say_colorWithHex:(NSInteger) hexValue;
+ (UIColor *)say_colorWithHexString:(NSString *) hexString;
@end
