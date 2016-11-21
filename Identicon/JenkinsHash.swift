//
//  JenkinsHash.swift
//  Identicon
//
//  Created by Evgeniy Yurtaev on 21/11/2016.
//  Copyright © 2016 Evgeniy Yurtaev. All rights reserved.
//

import Foundation

func jenkinsHash(from data: Data) -> UInt32 {
    return data.withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> UInt32 in
        var hash: UInt32 = 0
        for i in 0..<data.count {
            hash = hash &+ UInt32(bytes[i])
            hash = hash &+ (hash << 10);
            hash ^= (hash >> 6);
        }
        hash = hash &+ (hash << 3);
        hash ^= (hash >> 11);
        hash = hash &+ (hash << 15);

        return hash
    }
}
