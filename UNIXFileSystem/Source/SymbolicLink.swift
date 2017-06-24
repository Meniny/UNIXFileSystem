//
//  UFSSymbolicLink.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSSymbolicLink` is a `struct` that is used to represent a symbolic link.
public struct UFSSymbolicLink: UFSFile, UFSFileWrapperConvertible {
    /// The path of the symbolic link.
    public var path: UFSPath
    
    /// Creates a `UFSSymbolicLink` instance with the specified path.
    ///
    /// - parameter path: The path for the symbolic link.
    ///
    /// - returns: A new `UFSSymbolicLink` instance or nil if the `UFSSymbolicLink` does not exist at the specified path.
    public init?(path: UFSPath) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isSymbolicLinkKey])
            
            if let isSymbolicLink = resourceValues.isSymbolicLink, isSymbolicLink {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `UFSSymbolicLink` instance with the specified path.
    ///
    /// - parameter path: The path for the symbolic link.
    ///
    /// - returns: A new `UFSSymbolicLink` instance.
    public init(_ path: UFSPath) {
        self.path = path
    }
    
    /// Returns a `UFSSymbolicLinkable` destination if `path` is a valid symbolic link, otherise throws an `Error`.
    ///
    /// - throws: An `URLError`.
    ///
    /// - returns: A `UFSSymbolicLinkable`.
    public func destination() throws -> UFSSymbolicLinkable {
        let destinationURL = try FileManager.default.destinationOfSymbolicLink(atPath: path.rawValue)
        if let destination = UFSPath(destinationURL).item as? UFSSymbolicLinkable {
            return destination
        } else {
            throw URLError(.fileDoesNotExist)
        }
    }
}
