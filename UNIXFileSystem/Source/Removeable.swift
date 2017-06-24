//
//  UFSRemoveable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSRenameable` `protocol` for an `UFSItem` that can be removed.
public protocol UFSRemoveable: UFSItem {
    /// Removes the instance of the conforming type.
    func remove() throws
}

extension UFSRemoveable {
    /// Remove the `UFSItem`.
    ///
    /// - note: This function removes the item instantly.
    ///
    /// - throws: An `Error`.
    public func remove() throws {
        try FileManager.default.removeItem(at: path.url)
    }
}
