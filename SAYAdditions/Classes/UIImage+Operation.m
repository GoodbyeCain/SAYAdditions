//
//  UIImage+Operation.m
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import "UIImage+Operation.h"
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

static inline CGFloat degreesToRadians(CGFloat degrees){ return degrees * M_PI / 180; };
static inline CGFloat radiansToDegrees(CGFloat radians) { return radians * 180 / M_PI; };

@implementation UIImage (Operation)

#pragma mark -
#pragma mark Private Method
+ (NSString *)picName:(NSString *)name type:(NSString *)type {
    return [NSString stringWithFormat:@"%@.%@", name, type];
}

+ (NSString *)picPath:(NSString *)name type:(NSString *)type {
    return [[NSBundle mainBundle] pathForResource:name ofType:type];
}

#pragma mark -
#pragma mark Public Method
+ (UIImage *)say_pngImageWithName:(NSString *)name {
    return [self say_imageWithName:name type:@"png"];
}

+ (UIImage *)say_imageWithName:(NSString *)str type:(NSString *)type {
    NSString *path = [self picPath:str type:type];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)say_fitImageWithName:(NSString *)name {
    if (CGRectGetHeight([UIScreen mainScreen].bounds) >= 568) {
        name = [name stringByAppendingString:@"-568@2x"];
    } else {
        name = [name stringByAppendingString:@"@2x"];
    }
    
    NSString *path = [UIImage picPath:name type:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)say_imageWithColor:(UIColor *)color  {
    CGSize contextSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContext(contextSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, contextSize.width, contextSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)say_imageRotatedWithDegrees:(CGFloat)degrees {
    CGSize rotatedSize = CGSizeMake(self.size.width, self.size.height);
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap,
                       CGRectMake(-self.size.width / 2, -self.size.height / 2,
                                  self.size.width, self.size.height),
                       [self CGImage]);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)say_imageApplyingAlpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)say_imageBoxBlurWithLevel:(float)level {
    if (level < 0 || level > 1) {
        level = 0.5;
    }
    
    int kernelSize = (int)(level * 100);
    kernelSize = kernelSize - (kernelSize % 2) + 1;
    CGImageRef imageRef = self.CGImage;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(imageRef);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    void *pixelBuffer =
    malloc(CGImageGetBytesPerRow(imageRef) * CGImageGetHeight(imageRef));
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    outBuffer.width = inBuffer.width = CGImageGetWidth(imageRef);
    outBuffer.height = inBuffer.height = CGImageGetHeight(imageRef);
    outBuffer.rowBytes = inBuffer.rowBytes = CGImageGetBytesPerRow(imageRef);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    outBuffer.data = pixelBuffer;
    
    error =
    vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, kernelSize,
                               kernelSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"vImageBoxConvolve_ARGB8888 Error:%zd", error);
        CFRelease(inBitmapData);
        return self;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes,
                                             colorSpace, CGImageGetBitmapInfo(self.CGImage));
    CGImageRef resultCGImage = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:resultCGImage];
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CFRelease(resultCGImage);
    CGContextRelease(ctx);
    CFRelease(colorSpace);
    
    return returnImage;
}

- (UIImage *)say_imageWithRoundBounds {
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    float min = height > width ? width : height;
    CGRect squareRect =
    CGRectMake((width - min) / 2, (height - min) / 2, min, min);
    
    UIGraphicsBeginImageContext(squareRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, min, min));
    CGContextClip(context);
    [self drawInRect:CGRectMake(0, 0, min, min)];
    UIImage *squareImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return squareImage;
}

- (UIImage *)say_corpEllipseImage {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

- (UIImage *)say_corpSquareImage {
    float min =
    self.size.height > self.size.width ? self.size.width : self.size.height;
    CGRect rect = CGRectMake((self.size.width - min) / 2,
                             (self.size.height - min) / 2, min, min);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:CGRectMake(-rect.origin.x, -rect.origin.y, self.size.width,
                                self.size.height)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

- (UIImage *)say_clipImageWithSize:(CGSize)targetSize {
    CGSize originSize = self.size;
    CGFloat widthDelta = originSize.width / targetSize.width;
    CGFloat heightDelta = originSize.height / targetSize.height;
    
    CGSize ctxSize;
    if (widthDelta > heightDelta) {
        ctxSize.width = originSize.width / originSize.height * targetSize.height;
        ctxSize.height = targetSize.height;
    } else {
        ctxSize.width = targetSize.width;
        ctxSize.height = originSize.height / originSize.width * targetSize.width;
    }
    
    UIGraphicsBeginImageContext(targetSize);
    [self drawInRect:CGRectMake((targetSize.width - ctxSize.width) / 2,
                                (targetSize.height - ctxSize.height) / 2,
                                ctxSize.width, ctxSize.height)];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return targetImage;
}

@end
