//
//  IconGenerator.swift
//  IGIdenticonExample
//
//  Created by Evgeniy Yurtaev on 19/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import CoreGraphics
#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

public protocol IconGenerator {
    func icon(from number: UInt32, size: CGSize) -> CGImage
}

#if os(iOS) || os(watchOS) || os(tvOS)
public extension IconGenerator {
    func icon(from number: UInt32, size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        let cgImage: CGImage = icon(from: number, size: scaledSize)

        return UIImage(cgImage: cgImage, scale: scale, orientation: UIImageOrientation.up)
    }
}
#endif

#if os(macOS)
public extension IconGenerator {
    func icon(from number: UInt32, size: CGSize, scale: CGFloat) -> NSImage {
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        let cgImage: CGImage = icon(from: number, size: scaledSize)

        return NSImage(cgImage: cgImage, size: size)
    }
}
#endif
