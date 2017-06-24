//
//  UFSCopyableSubitem.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSCopyableSubitem` `protocol` for an `UFSItem` that adopts `UFSCopyable` and `UFSSubitem`.
public protocol UFSCopyableSubitem: UFSCopyable, UFSSubitem {
    /// Copies the instance of the conforming type into the specified parent, returning the copy.
    func copy(into parent: UFSParent) throws -> Self
}

extension UFSCopyableSubitem {
    /// Copy the `UFSItem` into the the specified `UFSParent`.
    ///
    /// - parameter parent: The parent to copy the item into.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A copy of the item.
    public func copy(into parent: UFSParent) throws -> Self {
        let copyPath = parent.path.appendingComponent(path.lastComponent)
        return try copy(to: copyPath)
    }
}
