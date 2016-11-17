//
//  IGImageGenerator.h
//  IGIdenticon
//
//  Created by Evgeniy Yurtaev on 29/07/15.
//  Copyright (c) 2015 Evgeniy Yurtaev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IGImageProducing.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGImageGenerator : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithImageProducer:(id<IGImageProducing>)imageProducer hashFunction:(uint32_t(*)(NSData *))hashFunction NS_DESIGNATED_INITIALIZER;

- (UIImage *)imageFromUInt32:(uint32_t)number size:(CGSize)size;

- (UIImage *)imageFromData:(NSData *)data size:(CGSize)size;

- (UIImage *)imageFromString:(NSString *)string size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
