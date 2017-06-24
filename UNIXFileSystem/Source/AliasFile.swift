//
//  UFSAliasFile.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSAliasFile` is a `struct` that is used to represent an alias.
public struct UFSAliasFile: UFSFile {
    /// The path of the alias file.
    public var path: UFSPath
    
    /// Creates a `UFSAliasFile` instance with the specified path.
    ///
    /// - parameter path: The path for the alias file.
    ///
    /// - returns: A new `UFSAliasFile` instance or nil if the `UFSAliasFile` does not exist at the specified path.
    public init?(path: UFSPath) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isAliasFileKey])
            
            if let isAliasFile = resourceValues.isAliasFile, isAliasFile {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `UFSAliasFile` instance with the specified path.
    ///
    /// - parameter path: The path for the alias file.
    ///
    /// - returns: A new `UFSAliasFile` instance.
    public init(_ path: UFSPath) {
        self.path = path
    }
    
    /// Returns an `UFSAliasable` destination if `path` is a valid alias, otherise throws an `Error`.
    ///
    /// - throws: a `URLError`.
    ///
    /// - returns: An `UFSAliasable`.
    public func destination() throws -> UFSAliasable {
        let destinationURL = try NSURL(resolvingAliasFileAt: self.path.url, options: []) as URL
        if let destination = UFSPath(destinationURL).item as? UFSAliasable {
            return destination
        } else {
            throw URLError(.fileDoesNotExist)
        }
    }
}
