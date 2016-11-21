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
    func icon(from data: Data, size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage {
        let hash = jenkinsHash(from: data)
        let image = icon(from: hash, size: size, scale: scale)

        return image
    }
    func icon(from string: String, size: CGSize, scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        guard let data = string.data(using: String.Encoding.utf8) else {
            return nil
        }
        let image = icon(from: data, size: size, scale: scale)

        return image
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
    func icon(from data: Data, size: CGSize, scale: CGFloat) -> NSImage {
        let hash = jenkinsHash(from: data)
        let image = icon(from: hash, size: size, scale: scale)

        return image
    }
    func icon(from string: String, size: CGSize, scale: CGFloat) -> NSImage? {
        guard let data = string.data(using: String.Encoding.utf8) else {
            return nil
        }
        let image = icon(from: data, size: size, scale: scale)

        return image
    }
}
#endif
