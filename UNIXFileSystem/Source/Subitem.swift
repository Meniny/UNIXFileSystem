//
//  UFSSubitem.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSSubitem` `protocol` for an `UFSItem` that can be a subitem of another `UFSItem`.
public protocol UFSSubitem: UFSItem {
    /// Returns the root volume for the instance of the conforming type.
    func rootVolume() throws -> UFSVolume
    /// Returns the parent directory for the instance of the conforming type.
    func parentDirectory() throws -> UFSDirectory?
}

extension UFSSubitem {
    /// Returns the root `UFSVolume` for an `UFSItem`.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSVolume`
    public func rootVolume() throws -> UFSVolume {
        let values = try path.url.resourceValues(forKeys: [.volumeURLKey])
        return UFSVolume(UFSPath(values.volume!))
    }
    
    /// Returns the parent `UFSDirectory` for an `UFSItem` or nil if the directory is the root directory of a volume.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSDirectory` or nil
    public func parentDirectory() throws -> UFSDirectory? {
        do {
            let values = try path.url.resourceValues(forKeys: [.parentDirectoryURLKey])
            
            guard let parentDirectoryURL = values.parentDirectory else {
                return nil
            }
            
            return UFSDirectory(path: UFSPath(parentDirectoryURL))
        } catch {
            return nil
        }
    }
}
