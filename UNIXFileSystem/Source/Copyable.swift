//
//  UFSCopyable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSCopyable` `protocol` for an `UFSItem` that can be a copied.
public protocol UFSCopyable: UFSItem {
    /// Copies the instance of the conforming type to the specified path, returning the copy.
    func copy(to path: UFSPath) throws -> Self
}

extension UFSCopyable {
    /// Returns a copy of the `UFSItem` at the specified `UFSPath`.
    ///
    /// - parameter path: The path to copy the item too.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A copy of the item.
    public func copy(to path: UFSPath) throws -> Self {
        try FileManager.default.copyItem(at: self.path.url, to: path.url)
        return path.item! as! Self
    }
}
