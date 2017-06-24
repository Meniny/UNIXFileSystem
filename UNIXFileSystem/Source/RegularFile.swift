//
//  UFSRegularFile.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSRegularFile` is a `struct` that is used to represent a regular file i.e. not a symlink or alias.
public struct UFSRegularFile: UFSFile, UFSAliasable, UFSFileHandleConvertible, UFSFileWrapperConvertible {
    /// The path of the regular file.
    public var path: UFSPath
    
    /// Creates a `UFSRegularFile` instance with the specified path.
    ///
    /// - parameter path: The path for the regular file.
    ///
    /// - returns: A new `UFSRegularFile` instance or nil if the `UFSRegularFile` does not exist at the specified path.
    public init?(path: UFSPath) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isRegularFileKey])
            
            if let isRegularFile = resourceValues.isRegularFile, isRegularFile {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `UFSRegularFile` instance with the specified path.
    ///
    /// - parameter path: The path for the regular file.
    ///
    /// - returns: A new `UFSRegularFile` instance.
    public init(_ path: UFSPath) {
        self.path = path
    }
    
    /// Returns the contents of the file in bytes.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: The contents of the file in bytes.
    public func size() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.fileSizeKey])
        return values.fileSize!
    }
}
