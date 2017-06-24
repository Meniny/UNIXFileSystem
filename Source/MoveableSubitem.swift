//
//  MoveableSubitem.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `MoveableSubitem` `protocol` for an `Item` that adopts `Moveable` and `Subitem`.
public protocol MoveableSubitem: Moveable, Subitem {
    /// Moves the instance of the conforming type into the specified parent.
    mutating func move(into parent: Parent) throws
}

extension MoveableSubitem {
    /// Move the `Item` into the specified `Parent`.
    ///
    /// - parameter parent: The parent to move the item into.
    ///
    /// - throws: An `Error`.
    mutating public func move(into parent: Parent) throws {
        let movePath = parent.path.appendingComponent(path.lastComponent)
        try move(to: movePath)
    }
}
