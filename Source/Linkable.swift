//
//  Linkable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `Linkable` `protocol` for an `Item` that can be hard linked to a `Path`.
public protocol Linkable: Item {
    /// Links the instance of the conforming type to the specified path, returning the link.
    func link(to path: Path) throws -> Linkable
}

extension Linkable {
    /// Link the `Item` to the specified `Path`.
    ///
    /// - parameter path: The path to link too.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: the created `Linkable`.
    public func link(to path: Path) throws -> Linkable {
        try FileManager.default.linkItem(at: self.path.url, to: path.url)
        return path.item as! Linkable
    }
}
