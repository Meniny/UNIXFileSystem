//
//  Moveable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `Moveable` `protocol` for an `Item` that can be moved to another `Path`.
public protocol Moveable: Item {
    /// Moves the instance of the conforming type to the specified path.
    mutating func move(to path: Path) throws
}

extension Moveable {
    /// Move the `Item` to the specified `Path`.
    ///
    /// - parameter path: The path to move the item too.
    ///
    /// - throws: An `Error`.
    mutating public func move(to path: Path) throws {
        try FileManager.default.moveItem(at: self.path.url, to: path.url)
        self.path = path
    }
}
