//
//  IGIdenticon.m
//  IGIdenticon
//
//  Created by Evgeniy Yurtaev on 7/20/13.
//  Copyright (c) 2013 Evgeniy Yurtaev. All rights reserved.
//

#import "IGIdenticon.h"
#import <CoreGraphics/CGBase.h>
#import <CommonCrypto/CommonDigest.h>

@implementation IGIdenticon

+ (UIImage *)identiconWithString:(NSString *)string size:(CGFloat)size
{
	return [IGIdenticon identiconWithString:string size:size backgroundColor:nil];
}

+ (UIImage *)identiconWithString:(NSString *)string size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor
{
	NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
	
	return [IGIdenticon identiconWithData:data size:size backgroundColor:backgroundColor];
}

+ (UIImage *)identiconWithData:(NSData *)data size:(CGFloat)size
{
	return [IGIdenticon identiconWithData:data size:size backgroundColor:nil];
}

+ (UIImage *)identiconWithData:(NSData *)data size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor
{
	uint32_t hash32 = [IGIdenticon hashWithData:data];
	
	return [IGIdenticon identiconWithUInt32:hash32 size:size backgroundColor:backgroundColor];
}

+ (UIImage *)identiconWithUInt32:(uint32_t)number size:(CGFloat)size
{
	return [IGIdenticon identiconWithUInt32:number size:size backgroundColor:nil];
}

+ (UIImage *)identiconWithUInt32:(uint32_t)number size:(CGFloat)size backgroundColor:(UIColor *)backgroundColor
{
	if (size <= 0) {
		return [UIImage new];
	}
	
	if (backgroundColor == nil) {
		backgroundColor = [UIColor whiteColor];
	}
	
	NSInteger middleCellType = [[[IGIdenticon centerCellTypes] objectAtIndex:(number & 3)] integerValue];
	BOOL middleIsInvert = ((number >> 2) & 1) != 0;
	
	NSInteger cornerCellType = (number >> 3) & 15;
	BOOL cornerIsInvert = ((number >> 7) & 1) != 0;
	BOOL cornerTurn = (number >> 8) & 3;
	
	NSInteger sideCellType = (number >> 10) & 15;
	BOOL sideIsInvert = ((number >> 14) & 1) != 0;
	BOOL sideTurn = (number >> 15) & 3;
	
	NSInteger blue = (number >> 16) & 31;
	NSInteger green = (number >> 21) & 31;
	NSInteger red = (number >> 27) & 31;
	UIColor *foregroundColor = [UIColor colorWithRed:(red * 8) / 255.0f green:(green * 8) / 255.0f blue:(blue * 8) / 255.0f alpha:1];
	
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(size, size), NO, [[UIScreen mainScreen] scale]);
	CGContextRef imageContext = UIGraphicsGetCurrentContext();
	
	NSUInteger cellSize = (NSUInteger)(size + 0.5f) / 4;
	
	// middle cell
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize, cellSize) size:cellSize cellType:middleCellType turn:0 isInvert:middleIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize, cellSize * 2) size:cellSize cellType:middleCellType turn:0 isInvert:middleIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 2, cellSize * 2) size:cellSize cellType:middleCellType turn:0 isInvert:middleIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 2, cellSize) size:cellSize cellType:middleCellType turn:0 isInvert:middleIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	
	// side patchs, starting from top and moving clock-wise
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize, 0) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 3, cellSize) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 2, cellSize * 3) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(0, cellSize * 2) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(0, cellSize) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 2, 0) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 3, cellSize * 2) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize, cellSize * 3) size:cellSize cellType:sideCellType turn:sideTurn++ isInvert:sideIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	
	// corner patchs, starting from top left and moving clock-wise
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(0, 0) size:cellSize cellType:cornerCellType turn:cornerTurn++ isInvert:cornerIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 3, 0) size:cellSize cellType:cornerCellType turn:cornerTurn++ isInvert:cornerIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(cellSize * 3, cellSize * 3) size:cellSize cellType:cornerCellType turn:cornerTurn++ isInvert:cornerIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	[IGIdenticon renderIdenticonCellOnContext:imageContext position:CGPointMake(0, cellSize * 3) size:cellSize cellType:cornerCellType turn:cornerTurn++ isInvert:cornerIsInvert foregroundColor:foregroundColor backgroundColor:backgroundColor];
	
	UIImage *identicon = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return identicon;
}

#pragma mark - Private methods

+ (uint32_t)hashWithData:(NSData *)data
{
	const char *bytesArray = [data bytes];
	unsigned char hashBuffer[CC_MD4_DIGEST_LENGTH];
	CC_MD4(bytesArray, data.length, hashBuffer);
	
	uint32_t hash32 = 0;
	hash32 |= (uint32_t)hashBuffer[0];
	hash32 |= ((uint32_t)hashBuffer[1]) << 8u;
	hash32 |= ((uint32_t)hashBuffer[2]) << 16u;
	hash32 |= ((uint32_t)hashBuffer[3]) << 24u;
	
	return hash32;
}

+ (NSArray *)cellTypes
{
	NSArray *cellTypes = @[
      @[@0, @4, @24, @20],
	  @[@0, @4, @20],
	  @[@2, @24, @20],
	  @[@0, @2, @20, @22],
	  @[@2, @14, @22, @10],
	  @[@0, @14, @24, @22],
	  @[@2, @24, @22, @13, @11, @22, @2],
	  @[@0, @14, @22],
	  @[@6, @8, @18, @16],
	  @[@4, @20, @10, @12, @2],
	  @[@0, @2, @12, @10],
	  @[@10, @14, @22],
	  @[@20, @12, @24],	  
	  @[@10, @2, @12],	  
	  @[@0, @2, @10],
	  @[@0, @4, @24, @20]
	];
	
	return cellTypes;
}

+ (NSArray *)centerCellTypes
{
	return @[@0, @4, @8, @15];
}

+ (void)renderIdenticonCellOnContext:(CGContextRef)context position:(CGPoint)position size:(CGFloat)size cellType:(NSInteger)cellType turn:(NSInteger)turn isInvert:(BOOL)isInvert foregroundColor:(UIColor *)foregroundColor backgroundColor:(UIColor *)backgroundColor
{
	NSArray *cellTypes = [IGIdenticon cellTypes];
	
	cellType = cellType % cellTypes.count;
	turn = turn % 4;
	if (cellType == 15) {
		isInvert = !isInvert;
	}
	
	NSArray *vertices = [cellTypes objectAtIndex:cellType];
	CGFloat offset = size / 2.0f;
	CGFloat scale = size / 4.0f;
	
	CGContextSaveGState(context);
	
	// paint background
	UIColor *fillColor = isInvert ? foregroundColor : backgroundColor;
	CGContextSetFillColorWithColor(context, fillColor.CGColor);
	CGContextFillRect(context, CGRectMake(position.x, position.y, size, size));
	
	// build patch path
	CGContextTranslateCTM(context, position.x + offset, position.y + offset);
	CGContextRotateCTM(context, turn * M_PI / 2);

	CGMutablePathRef path = CGPathCreateMutable();
	
	CGPoint vertice;
	vertice.x = [[vertices objectAtIndex:0] integerValue] % 5 * scale - offset;
	vertice.y = (NSInteger)([[vertices objectAtIndex:0] integerValue] / 5) * scale - offset;
	CGPathMoveToPoint(path, NULL, vertice.x, vertice.y);

	for (NSNumber *verticleNumber in vertices) {
		vertice.x = ([verticleNumber integerValue] % 5) * scale - offset;
		vertice.y = ([verticleNumber integerValue] / 5) * scale - offset;
		CGPathAddLineToPoint(path, NULL, vertice.x, vertice.y);
	}
	CGPathCloseSubpath(path);
	
	CGContextAddPath(context, path);
	
	fillColor = isInvert ? backgroundColor : foregroundColor;

	if ([fillColor isEqual:[UIColor clearColor]]) {
		CGContextSetBlendMode(context, kCGBlendModeClear);
	} else {
		CGContextSetFillColorWithColor(context, fillColor.CGColor);
	}
	CGContextDrawPath(context, kCGPathFill);
	
	CGPathRelease(path);
	
	CGContextRestoreGState(context);
}

@end
