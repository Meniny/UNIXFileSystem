//
//  UFSRenameable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSRenameable` `protocol` for an `UFSItem` that can be renamed.
public protocol UFSRenameable: UFSItem {
    /// Renames the instance of the conforming type to the specified name.
    mutating func rename(to name: String) throws
}

extension UFSRenameable {
    /// Rename the `UFSItem` to the specified name.
    ///
    /// - parameter name: The new name of the item.
    ///
    /// - throws: An `Error`.
    mutating public func rename(to name: String) throws {
        try FileManager.default.moveItem(at: path.url, to: path.replacingLastComponent(with: name).url)
        self.path = path
    }
}
