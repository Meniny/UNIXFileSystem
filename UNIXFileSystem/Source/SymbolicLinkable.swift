//
//  UFSSymbolicLinkable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSSymbolicLinkable` `protocol` for an `UFSItem` that can be symbolic linked to a `UFSPath`.
public protocol UFSSymbolicLinkable: UFSItem {
    /// Symbolic links the instance of the conforming type to the specified path, returning the symbolic link.
    func symbolicLink(to path: UFSPath) throws -> UFSSymbolicLink
}

extension UFSSymbolicLinkable {
    /// Returns a `UFSSymbolicLink` created at the specified `UFSPath`.
    ///
    /// - parameter path: The path to create thw symbolic link at.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: The created `UFSSymbolicLink`.
    public func symbolicLink(to path: UFSPath) throws -> UFSSymbolicLink {
        try FileManager.default.createSymbolicLink(at: self.path.url, withDestinationURL: path.url)
        return UFSSymbolicLink(path)
    }
}
