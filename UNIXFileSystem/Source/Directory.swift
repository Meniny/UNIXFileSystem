//
//  UFSDirectory.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSDirectory` is a `struct` that is used to represent a directory.
public struct UFSDirectory: UFSItem, UFSParent, UFSSubitem, UFSCopyable, UFSCopyableSubitem, UFSMoveable, UFSMoveableSubitem, UFSRenameable, UFSRemoveable, UFSTrashable, UFSSymbolicLinkable, UFSFileWrapperConvertible {
    /// The path of the directory.
    public var path: UFSPath
    
    /// Creates a `UFSDirectory` instance with the specified path.
    ///
    /// - parameter path: The path for the directory.
    ///
    /// - returns: A new `UFSDirectory` instance or nil if the `UFSDirectory` does not exist at the specified path.
    public init?(path: UFSPath) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isDirectoryKey])
            
            if let isDirectory = resourceValues.isDirectory, isDirectory {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `UFSDirectory` instance with the specified path.
    ///
    /// - parameter path: The path for the directory.
    ///
    /// - returns: A new `UFSDirectory` instance.
    public init(_ path: UFSPath) {
        self.path = path
    }
    
    /// Returns a Root `UFSDirectory`.
    public static var root: UFSDirectory {
        return UFSDirectory(UFSPath.root)
    }
    
    /// Returns a Temporary `UFSDirectory`.
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, macOS 10.12, *)
    public static var temporary: UFSDirectory {
        let url = FileManager.default.temporaryDirectory
        return UFSDirectory(UFSPath(url))
    }
    
    /// Returns the Document `UFSDirectory` in the current users home directory.
    public static var document: UFSDirectory {
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(documentUrl))
    }
    
    /// Returns the Library `UFSDirectory` in the current users home directory.
    public static var library: UFSDirectory {
        let libraryUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(libraryUrl))
    }
    
    /// Returns the Caches `UFSDirectory` in the current users home directory.
    public static var caches: UFSDirectory {
        let cachesUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(cachesUrl))
    }
    
    /// Returns the Application(s) `UFSDirectory` in the current users home directory.
    public static var application: UFSDirectory {
        let applicationUrl = FileManager.default.urls(for: .applicationDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(applicationUrl))
    }
    
    /// Returns the Application Support UFSDirectory in the current users home directory.
    public static var applicationSupport: UFSDirectory {
        let applicationSupportUrl = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(applicationSupportUrl))
    }
  
    /// Returns the Desktop `UFSDirectory` in the current users home directory.
    public static var desktop: UFSDirectory {
        let desktopUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(desktopUrl))
    }
    
    /// Returns the Downloads `UFSDirectory` in the current users home directory.
    public static var downloads: UFSDirectory {
        let downloadsUrl = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(downloadsUrl))
    }
    
    /// Returns the Movies `UFSDirectory` in the current users home directory.
    public static var movies: UFSDirectory {
        let moviesUrl = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(moviesUrl))
    }
    
    /// Returns the Music `UFSDirectory` in the current users home directory.
    public static var music: UFSDirectory {
        let musicUrl = FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(musicUrl))
    }
    
    /// Returns the Pictures `UFSDirectory` in the current users home directory.
    public static var pictures: UFSDirectory {
        let picturesUrl = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask).first!
        return UFSDirectory(UFSPath(picturesUrl))
    }
    
    /// Returns all directories where applications can be stored in the current users home directory.
    public static var applications: [UFSDirectory] {
        let applicationUrls = FileManager.default.urls(for: .allApplicationsDirectory, in: .userDomainMask)
        return applicationUrls.map( { UFSDirectory(UFSPath($0)) } )
    }
    
    /// Returns all libaries where applications can be stored in the current users home directory.
    public static var libraries: [UFSDirectory] {
        let libraryUrls = FileManager.default.urls(for: .allLibrariesDirectory, in: .userDomainMask)
        return libraryUrls.map( { UFSDirectory(UFSPath($0)) } )
    }
    
    /// Creates and returns a `UFSDirectory` at the specified path
    ///
    /// - parameter path: The path to create a directory at.
    /// - parameter withIntermediateDirectories: Passing `true` for withIntermediateDirectories will create any necessary intermediate directories.
    /// - parameter attributes: The file attributes for the new directory. You can set the owner and group numbers, file permissions, and modification date.  If you specify nil for this parameter, the directory is created according to the umask(2) macOS Developer Tools Manual Page of the process.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSDirectory` or throws an `Error`.
    @discardableResult public static func create(at path: UFSPath, withIntermediateDirectories: Bool = false, attributes: [FileAttributeKey: Any]? = nil) throws -> UFSDirectory {
        try FileManager.default.createDirectory(at: path.url, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
        return UFSDirectory(path)
    }
    
    /// Returns the container directory associated with the specified security application group identifier.
    ///
    /// - note: This function also creates the directory if it does not yet exist.
    ///
    /// - parameter groupIdentifier: the security application group identifier.
    ///
    /// - returns: A container `UFSDirectory` or nil if the container is not valid.
    public static func container(forSecurityApplicationGroupIdentifier groupIdentifier: String) -> UFSDirectory? {
        guard let containerUrl = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier) else {
            return nil
        }
        return UFSDirectory(UFSPath(containerUrl))
    }
    
    #if os(macOS)
    /// Returns the home `UFSDirectory` for the current user.
    ///
    /// - returns: A `UFSDirectory`.
    @available(macOS 10.12, *)
    public static var home: UFSDirectory {
        let url = FileManager.default.homeDirectoryForCurrentUser
        return UFSDirectory(UFSPath(url))
    }
    
    /// Returns the home `UFSDirectory` for the specified user.
    ///
    /// - parameter user: The user for the home directory.
    ///
    /// - returns: A `UFSDirectory` or nil if there is no home directory for the specified user.
    @available(macOS 10.12, *)
    public static func home(forUser user: String) -> UFSDirectory? {
        guard let url = FileManager.default.homeDirectory(forUser: user) else {
            return nil
        }
        return UFSDirectory(UFSPath(url))
    }
    #endif
    
    /// Returns the `FileManager.URLRelationship` compared to another item.
    ///
    /// - parameter item: The item to compare too.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `FileManager.URLRelationship`.
    public func relationship(to item: UFSItem) throws -> FileManager.URLRelationship {
        var urlRelationship: FileManager.URLRelationship = .other
        try FileManager.default.getRelationship(&urlRelationship, ofDirectoryAt: path.url, toItemAt: item.path.url)
        return urlRelationship
    }
}
