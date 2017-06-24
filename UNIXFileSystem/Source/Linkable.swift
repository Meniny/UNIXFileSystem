//
//  UFSLinkable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSLinkable` `protocol` for an `UFSItem` that can be hard linked to a `UFSPath`.
public protocol UFSLinkable: UFSItem {
    /// Links the instance of the conforming type to the specified path, returning the link.
    func link(to path: UFSPath) throws -> UFSLinkable
}

extension UFSLinkable {
    /// Link the `UFSItem` to the specified `UFSPath`.
    ///
    /// - parameter path: The path to link to.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: the created `UFSLinkable`.
    public func link(to path: UFSPath) throws -> UFSLinkable {
        try FileManager.default.linkItem(at: self.path.url, to: path.url)
        return path.item as! UFSLinkable
    }
}
