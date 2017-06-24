//
//  UFSTrashable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSTrashable` `protocol` for an `UFSItem` that can be trashed on macOS.
@available(macOS 10.10, *)
public protocol UFSTrashable: UFSItem {
    #if os(macOS)
    /// Trashes the instance of the conforming type.
    mutating func trash() throws
    #endif
}

@available(macOS 10.10, *)
extension UFSTrashable {
    #if os(macOS)
    /// Trash the `UFSItem`.
    mutating public func trash() throws {
        var resultingURL: NSURL?
        try FileManager.default.trashItem(at: path.url, resultingItemURL: &resultingURL)
        self.path = UFSPath(resultingURL! as URL)
    }
    #endif
}
