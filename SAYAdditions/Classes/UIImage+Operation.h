//
//  UIImage+Operation.h
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Operation)

+ (UIImage *)say_pngImageWithName:(NSString *)name;
+ (UIImage *)say_imageWithName:(NSString *)name type:(NSString *)type;
+ (UIImage *)say_fitImageWithName:(NSString *)name;
+ (UIImage *)say_imageWithColor:(UIColor *)color;

- (UIImage *)say_imageRotatedWithDegrees:(CGFloat)degrees;
- (UIImage *)say_imageApplyingAlpha:(CGFloat)alpha;
- (UIImage *)say_imageBoxBlurWithLevel:(float)level;
- (UIImage *)say_imageWithRoundBounds;
- (UIImage *)say_corpEllipseImage;
- (UIImage *)say_corpSquareImage;
- (UIImage *)say_clipImageWithSize:(CGSize)targetSize;

@end
