//
//  UNIXFileSystem.swift
//  UNIXFileSystem
//
//  Created by Meniny on 2016-06-24.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// UNIX File System Framework
public struct UNIXFileSystem {
    
}

// MARK: - Typealias
public typealias UFS = UNIXFileSystem
public typealias FileSystem = UNIXFileSystem

// MARK: - Values
public extension UNIXFileSystem {
    
    public static var root: UFSDirectory {
        return UFSDirectory.root
    }
    
    /// Returns a Temporary `UFSDirectory`.
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, macOS 10.12, *)
    public static var temporary: UFSDirectory {
        return UFSDirectory.temporary
    }
    
    /// Returns the Document `UFSDirectory` in the current users home directory.
    public static var document: UFSDirectory {
        return UFSDirectory.document
    }
    
    /// Returns the Library `UFSDirectory` in the current users home directory.
    public static var library: UFSDirectory {
        return UFSDirectory.library
    }
    
    /// Returns the Caches `UFSDirectory` in the current users home directory.
    public static var caches: UFSDirectory {
        return UFSDirectory.caches
    }
    
    /// Returns the Application(s) `UFSDirectory` in the current users home directory.
    public static var application: UFSDirectory {
        return UFSDirectory.application
    }
    
    /// Returns the Application Support UFSDirectory in the current users home directory.
    public static var applicationSupport: UFSDirectory {
        return UFSDirectory.applicationSupport
    }
    
    /// Returns the Desktop `UFSDirectory` in the current users home directory.
    public static var desktop: UFSDirectory {
        return UFSDirectory.desktop
    }
    
    /// Returns the Downloads `UFSDirectory` in the current users home directory.
    public static var downloads: UFSDirectory {
        return UFSDirectory.downloads
    }
    
    /// Returns the Movies `UFSDirectory` in the current users home directory.
    public static var movies: UFSDirectory {
        return UFSDirectory.movies
    }
    
    /// Returns the Music `UFSDirectory` in the current users home directory.
    public static var music: UFSDirectory {
        return UFSDirectory.music
    }
    
    /// Returns the Pictures `UFSDirectory` in the current users home directory.
    public static var pictures: UFSDirectory {
        return UFSDirectory.pictures
    }
    
    /// Returns all directories where applications can be stored in the current users home directory.
    public static var applications: [UFSDirectory] {
        return UFSDirectory.applications
    }
    
    /// Returns all libaries where applications can be stored in the current users home directory.
    public static var libraries: [UFSDirectory] {
        return UFSDirectory.libraries
    }
}

// MARK: - Creation
public extension UNIXFileSystem {
    
    /// Creates and returns a `UFSDirectory` at the specified path
    ///
    /// - parameter folder: A folder name
    /// - parameter directory: Parent directory
    /// - parameter withIntermediateDirectories: Passing `true` for withIntermediateDirectories will create any necessary intermediate directories.
    /// - parameter attributes: The file attributes for the new directory. You can set the owner and group numbers, file permissions, and modification date.  If you specify nil for this parameter, the directory is created according to the umask(2) macOS Developer Tools Manual Page of the process.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSDirectory` or throws an `Error`.
    @discardableResult
    public static func create(folder: String, in directory: UFSDirectory, withIntermediateDirectories: Bool = false, attributes: [String: Any]? = nil) throws -> UFSDirectory {
        return try UNIXFileSystem.create(folder: folder, at: directory.path, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
    }
    
    /// Creates and returns a `UFSDirectory` at the specified path
    ///
    /// - parameter folder: A folder name
    /// - parameter path: The parent path
    /// - parameter withIntermediateDirectories: Passing `true` for withIntermediateDirectories will create any necessary intermediate directories.
    /// - parameter attributes: The file attributes for the new directory. You can set the owner and group numbers, file permissions, and modification date.  If you specify nil for this parameter, the directory is created according to the umask(2) macOS Developer Tools Manual Page of the process.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSDirectory` or throws an `Error`.
    @discardableResult
    public static func create(folder: String, at path: UFSPath, withIntermediateDirectories: Bool = false, attributes: [String: Any]? = nil) throws -> UFSDirectory {
        if path.exists && path.isDirectory {
            return UFSDirectory(path)
        }
        return try path.create(withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
    }
}

// MARK: - Rename
public extension UNIXFileSystem {

    public static func rename<T: UFSRenameable>(item: inout T, to name: String) throws {
        try item.rename(to: name)
    }
}

// MARK: - Remove
public extension UNIXFileSystem {
    
    public static func remove<T: UFSRemoveable>(item: T) throws {
        try item.remove()
    }
}

// MARK: - Move
public extension UNIXFileSystem {
    
    public static func move<T: UFSMoveable>(item: inout T, to path: UFSPath) throws {
        try item.move(to: path)
    }
    
    public static func move<T: UFSMoveableSubitem>(item: inout T, into parent: UFSParent) throws {
        try item.move(into: parent)
    }
}

// MARK: - Copy
public extension UNIXFileSystem {
    
    @discardableResult
    public static func copy<T: UFSCopyable>(item: T, to path: UFSPath) throws -> T {
        return try item.copy(to: path)
    }
    
    @discardableResult
    public static func copy<T: UFSCopyableSubitem>(item: T, into parent: UFSParent) throws -> T {
        return try item.copy(into: parent)
    }
}

// MARK: - Link
public extension UNIXFileSystem {
    /// Link to the specified `UFSPath`.
    ///
    /// - parameter file: The file.
    /// - parameter path: The path to link to.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: the created `UFSLinkable`.
    public static func link<T: UFSLinkable>(item: T, to path: UFSPath) throws -> UFSLinkable {
        return try item.link(to: path)
    }
    
    /// Returns a `UFSSymbolicLink` created at the specified `UFSPath`.
    ///
    /// - parameter item: The item.
    /// - parameter path: The path to create thw symbolic link at.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: The created `UFSSymbolicLink`.
    public static func symbolicLink<T: UFSSymbolicLinkable>(item: T, to path: UFSPath) throws -> UFSSymbolicLink {
        return try item.symbolicLink(to: path)
    }
}

// MARK: - Trash
public extension UNIXFileSystem {
    #if os(macOS)
    /// Trash the `UFSDirectory`.
    @available(macOS 10.10, *)
    public static func trash<T: UFSTrashable>(item: inout T) throws {
        try item.trash()
    }
    #endif
}
