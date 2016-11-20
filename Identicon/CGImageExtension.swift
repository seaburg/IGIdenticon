//
//  CGImageExtension.swift
//  Example
//
//  Created by Evgeniy Yurtaev on 20/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import CoreGraphics

extension CGImage {
    func scale(toWidth width: Int, height: Int) -> CGImage? {
        if (self.width == width && self.height == height) {
            return self
        }

        guard let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: 0,
            space: colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: bitmapInfo.rawValue
        ) else {
            return nil
        }
        context.draw(self, in: CGRect(x: 0, y: 0, width: width, height: height))

        return context.makeImage()
    }
}
