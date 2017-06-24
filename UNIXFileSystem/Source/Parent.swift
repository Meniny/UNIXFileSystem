//
//  UFSParent.swift
//  UNIXFileSystem
//
//  Created by Meniny on 23/02/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSParent` `protocol` for an `UFSItem` that can be a parent of another `UFSItem`.
public protocol UFSParent: UFSItem {
    /// Return the subitems for the instance of the conforming type.
    func subitems() throws -> [UFSSubitem]
    /// Return if the instance of the conforming type is empty.
    func isEmpty() throws -> Bool
    /// Return if the instance of the conforming type contains the specified subitem.
    func contains(_ subitem: UFSSubitem) throws -> Bool
}

extension UFSParent {
    /// Returns the subitems of the parent
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: All subitems contained in the parent.
    public func subitems() throws -> [UFSSubitem] {
        var items: [UFSSubitem] = []
        
        guard let lastPathComponents = FileManager.default.subpaths(atPath: path.rawValue) else {
            return items
        }
        
        for lastPathComponent in lastPathComponents {
            let itemPath = path.appendingComponent(lastPathComponent)
            
            if let item = itemPath.item as? UFSSubitem {
                items.append(item)
            }
        }
        
        return items
    }
    
    /// Returns wether the parent has 0 subitems.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A boolean to indicate if the parent is empty,
    public func isEmpty() throws -> Bool {
        return try subitems().isEmpty
    }
    
    /// Returns wether the parent contains the specified subitem.
    ///
    /// - parameter subitem: The submitem to check against.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A boolean to indicate if the parent contains the specified subitem.
    public func contains(_ subitem: UFSSubitem) throws -> Bool {
        return try subitems().contains(where: { $0.path == subitem.path })
    }
}
