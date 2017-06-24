//
//  UFSMoveableSubitem.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSMoveableSubitem` `protocol` for an `UFSItem` that adopts `UFSMoveable` and `UFSSubitem`.
public protocol UFSMoveableSubitem: UFSMoveable, UFSSubitem {
    /// Moves the instance of the conforming type into the specified parent.
    mutating func move(into parent: UFSParent) throws
}

extension UFSMoveableSubitem {
    /// Move the `UFSItem` into the specified `UFSParent`.
    ///
    /// - parameter parent: The parent to move the item into.
    ///
    /// - throws: An `Error`.
    mutating public func move(into parent: UFSParent) throws {
        let movePath = parent.path.appendingComponent(path.lastComponent)
        try move(to: movePath)
    }
}
