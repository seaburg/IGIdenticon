//
//  IGGitHubIdenticon.m
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 06.05.14.
//  Copyright (c) 2014 Evgeniy Yurtaev. All rights reserved.
//

#import "IGGitHubIdenticon.h"
#import <CoreGraphics/CGBase.h>

@implementation IGGitHubIdenticon

+ (UIImage *)identiconWithUInt32:(uint32_t)number size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor
{
    if (size <= 0) {
        return [UIImage new];
    }

    NSInteger blue = (number >> 16) & 31;
    NSInteger green = (number >> 21) & 31;
    NSInteger red = (number >> 27) & 31;

    UIColor *foregroundColor = [UIColor colorWithRed:(red * 8) / 255.0f green:(green * 8) / 255.0f blue:(blue * 8) / 255.0f alpha:1];

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, NO);

    if (backgroundColor) {
        [backgroundColor setFill];
        CGContextFillRect(context, CGRectMake(0, 0, size, size));
    }

    [foregroundColor setFill];
    CGFloat cellSize = (size) / 5.0;
    for (NSUInteger i = 0; i < 15; ++i) {
        if ((number >> i) & 0x1u) {
            NSUInteger drawPositionX = i % 3;
            NSUInteger drawPositionY = i / 3;
            
            CGContextFillRect(context, CGRectMake(drawPositionX * cellSize, drawPositionY * cellSize, cellSize, cellSize));
            if (drawPositionX != 4 - drawPositionX) {
                CGContextFillRect(context, CGRectMake((4 - drawPositionX) * cellSize, drawPositionY * cellSize, cellSize, cellSize));
            }
        }
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
