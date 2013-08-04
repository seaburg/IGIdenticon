//
//  IGIdenticon.h
//  IGIdenticon
//
//  Created by Evgeniy Yurtaev on 7/20/13.
//  Copyright (c) 2013 Evgeniy Yurtaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface IGIdenticon : NSObject

+ (UIImage *)identiconWithString:(NSString *)string size:(CGFloat)size;
+ (UIImage *)identiconWithString:(NSString *)string size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor;

+ (UIImage *)identiconWithData:(NSData *)data size:(CGFloat)size;
+ (UIImage *)identiconWithData:(NSData *)data size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor;

+ (UIImage *)identiconWithUInt32:(uint32_t)number size:(CGFloat)size;
+ (UIImage *)identiconWithUInt32:(uint32_t)number size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor;

@end
