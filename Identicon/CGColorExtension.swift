//
//  CGColorExtension.swift
//  Identicon
//
//  Created by Evgeniy Yurtaev on 19/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import CoreGraphics

extension CGColor {
    static func color(from number: UInt16) -> CGColor {
        let blue = CGFloat(number & 0b11111) / 31;
        let green = CGFloat((number >> 5) & 0b11111) / 31;
        let red = CGFloat((number >> 10) & 0b11111) / 31;

        return CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [ red, green, blue, 1 ])!
    }
}
