//
//  GitHubIdenticon.swift
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 19/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import CoreGraphics

public class GitHubIdenticon: IconGenerator {
    private let numberOfColumns = 5
    private let numberOfColumnComponents = 3

    private let numberOfRows = 5
    private let numberOfRowComponents = 5

    public init() {}

    public func icon(from number: UInt32, size: CGSize) -> CGImage {
        let context = CGContext(
            data: nil,
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )!
        context.setShouldAntialias(false)

        let color = CGColor.color(from: UInt16(number >> 16))
        context.setFillColor(color)

        let cellSize = CGSize(width: size.width / CGFloat(numberOfRows), height: size.height / CGFloat(numberOfColumns));

        for row in 0..<numberOfRowComponents {
            for col in 0..<numberOfColumnComponents {
                let offset = UInt32(row * numberOfColumns + col)
                if ((number >> offset) & 0b1) == 0 {
                    continue
                }

                var rects = [CGRect]()
                rects.append(self.rect(forRow: row, column: col, size: cellSize))

                let mirroredCol = (numberOfColumns - col - 1)
                if (mirroredCol > col) {
                    rects.append(self.rect(forRow: row, column: mirroredCol, size: cellSize))
                }
                context.fill(rects)
            }
        }
        let image = context.makeImage()!

        return image
    }

    private func rect(forRow row: Int, column: Int, size: CGSize) -> CGRect {
        return CGRect(
            x: CGFloat(column) * size.width,
            y: CGFloat(row) * size.height,
            width: size.width,
            height: size.height
        )
    }
}
