//
//  UFSMoveable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSMoveable` `protocol` for an `UFSItem` that can be moved to another `UFSPath`.
public protocol UFSMoveable: UFSItem {
    /// Moves the instance of the conforming type to the specified path.
    mutating func move(to path: UFSPath) throws
}

extension UFSMoveable {
    /// Move the `UFSItem` to the specified `UFSPath`.
    ///
    /// - parameter path: The path to move the item too.
    ///
    /// - throws: An `Error`.
    mutating public func move(to path: UFSPath) throws {
        try FileManager.default.moveItem(at: self.path.url, to: path.url)
        self.path = path
    }
}
