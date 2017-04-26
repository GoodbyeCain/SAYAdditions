//
//  UIView+Additions.m
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (CGFloat)left{
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right{
    return CGRectGetMinX(self.frame);
}

- (void)setRight:(CGFloat)right{
    if(right == self.right) {
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    if(bottom == self.bottom) {
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height{
    if(height == self.height){
        return;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX{
    return CGRectGetMidX(self.frame);
}


- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)centerY{
    return CGRectGetMidY(self.frame);
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

- (UIViewController*)say_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UINavigationController *)say_navigationController{
    return self.say_viewController.navigationController;
}

- (void)say_removeAllSubviews{
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
    }
}
@end
