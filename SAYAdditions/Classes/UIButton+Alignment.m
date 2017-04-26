//
//  UIButton+Alignment.m
//  SAYAdditionsTest
//
//  Created by CainGoodbye on 26/04/2017.
//  Copyright © 2017 say. All rights reserved.
//

#import "UIButton+Alignment.h"
#import "UIView+Additions.h"

@implementation UIButton (Alignment)
- (void)say_alignmentToRight {
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.width, 0, self.imageView.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.width, 0, -self.titleLabel.width);
}

- (void)say_alignmentToBottom {
    CGSize imageSize = self.imageView.size;
    CGSize titleSize = [self.titleLabel.text
                        sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    CGSize selfSize = self.frame.size;
    
    CGFloat titleLeftEdge = -(selfSize.width - titleSize.width) / 1;
    CGFloat imageLeftEdge = (selfSize.width - imageSize.width) / 1;
    
    self.titleEdgeInsets =
    UIEdgeInsetsMake(imageSize.height, titleLeftEdge, 0.0, 0);
    
    
    self.imageEdgeInsets =
    UIEdgeInsetsMake(-titleSize.height, imageLeftEdge, 0.0, 0);
}

@end
