//
//  UFSItem.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSItem` is the base `protocol` for all file system items that can be represented by `UFSPath`.
public protocol UFSItem: UFSPathRepresentable, CustomStringConvertible, CustomDebugStringConvertible {
    /// The path representing the instance of the conforming type.
    var path: UFSPath { get set }
    
    /// Instantiates an instance of the conforming type from a path representation without validating the path.
    init(_ path: UFSPath)
}

public extension UFSItem /* CustomStringConvertible*/ {
    /// A textual representation of this instance, returning the represented path's `rawValue`.
    var description: String {
        return path.description
    }
}

public extension UFSItem /* CustomDebugStringConvertible */ {
    /// A textual representation of this instance.
    var debugDescription: String {
        return "\(type(of: self)) \(path.rawValue)"
    }
}

public extension UFSItem {
    
    /// Returns if the item exists.
    func exists() -> Bool {
        return path.exists
    }
    
    /// Returns if the item is a directory.
    func isDirectory() -> Bool {
        return path.isDirectory
    }
    
    /// Returns if the item's localized name.
    func localizedName() throws -> String {
        let values = try path.url.resourceValues(forKeys: [.localizedNameKey])
        return values.localizedName!
    }
    
    /// Returns if the item is readable.
    func isReadable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isReadableKey])
        return values.isReadable!
    }
    
    /// Returns if the item is writebale.
    func isWritable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isWritableKey])
        return values.isWritable!
    }
    
    /// Returns if the item is executable.
    func isExecutable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isExecutableKey])
        return values.isExecutable!
    }
    
    /// Returns if the item is hidden.
    func isHidden() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isHiddenKey])
        return values.isHidden!
    }
    
    /// Returns if the item is a package.
    func isPackage() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isPackageKey])
        return values.isPackage!
    }
    
    /// Returns if the item is a application.
    @available(iOS 9.0, tvOS 9.0, watchOS 2.0, macOS 10.11, *)
    func isApplication() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isApplicationKey])
        return values.isApplication!
    }
    
    /// Returns if the item is a alias file.
    func isAliasFile() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isAliasFileKey])
        return values.isAliasFile!
    }
    
    /// Returns if the item is a symbolic link.
    func isSymbolicLink() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.isSymbolicLinkKey])
        return values.isSymbolicLink!
    }
    
    /// Returns if the item's creation date.
    func creationDate() throws -> Date {
        let values = try path.url.resourceValues(forKeys: [.creationDateKey])
        return values.creationDate!
    }
    
    /// Returns if the item's content access date.
    func contentAccessDate() throws -> Date  {
        let values = try path.url.resourceValues(forKeys: [.contentAccessDateKey])
        return values.contentAccessDate!
    }
    
    /// Returns if the item's content modification date.
    func contentModificationDate() throws -> Date  {
        let values = try path.url.resourceValues(forKeys: [.contentModificationDateKey])
        return values.contentModificationDate!
    }
    
    /// Returns if the item's attribute modification date.
    func attributeModificationDate() throws -> Date  {
        let values = try path.url.resourceValues(forKeys: [.attributeModificationDateKey])
        return values.attributeModificationDate!
    }
    
    /// Returns files attributes for the item
    ///
    /// - note: This function does not transverse symbolic links.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: attibutes
    func attributes() throws -> [FileAttributeKey: Any]  {
        return try FileManager.default.attributesOfItem(atPath: path.rawValue)
    }
    
    /// Returns file attributes for the item
    ///
    /// - parameter attributes: The attributes to set on the item.
    ///
    /// - throws: An `Error`.
    func setAttributes(_ attributes: [FileAttributeKey: Any]) throws {
        return try FileManager.default.setAttributes(attributes, ofItemAtPath: path.rawValue)
    }
}
