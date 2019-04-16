//
//  UFSPath.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// UFSPath represents a file system location on disk.
public struct UFSPath: Equatable, RawRepresentable {
    
    /// String representation of the path
    public let rawValue: String
    /// URL representation of the path
    public let url: URL
    
    /// UFSPath Separator
    public static let separator: String = "/"
    
    /// Root UFSPath
    public static var root: UFSPath {
        return UFSPath(separator)
    }

    /// Creates a `UFSPath` instance with the specified raw value.
    ///
    /// - parameter rawValue: The raw string value for the path.
    ///
    /// - returns: A new path instance.
    public init?(rawValue: String) {
        self.rawValue = rawValue
        self.url = URL(fileURLWithPath: rawValue)
    }
    
    /// Creates a `UFSPath` instance with the specified raw value.
    ///
    /// - parameter rawValue: The raw string value for the path.
    ///
    /// - returns: A new path instance.
    public init(_ rawValue: String) {
        self.rawValue = rawValue
        self.url = URL(fileURLWithPath: rawValue)
    }
    
    /// Creates a `UFSPath` instance with the specified components.
    ///
    /// - parameter components: The components for the path.
    ///
    /// - returns: A new path instance.
    public init(components: [String]) {
        let fileURL = NSURL.fileURL(withPathComponents: components)! as URL
        self.init(fileURL)
    }
    
    /// Creates a `UFSPath` instance with the specified components.
    ///
    /// - parameter url: The url for the path.
    ///
    /// - returns: A new path instance.
    public init(_ url: URL) {
        self.rawValue = url.path
        self.url = url
    }
    
    /// Returns the path extension.
    public var pathExtension: String {
        return url.pathExtension
    }
    
    /// Returns the path components.
    public var components: [String] {
        return url.pathComponents
    }
    
    /// Returns the last path component.
    public var lastComponent: String {
        return url.lastPathComponent
    }
    
    /// Returns an array of localized path components or nil if the path does not exist.
    public var componentsToDisplay: [String]? {
        return FileManager.default.componentsToDisplay(forPath: rawValue)
    }
    
    /// Returns wether the path exists.
    public var exists: Bool {
        return FileManager.default.fileExists(atPath: rawValue)
    }
    
    /// Returns wether the path is a directory.
    public var isDirectory: Bool {
        var p: ObjCBool = false
        let e = FileManager.default.fileExists(atPath: rawValue, isDirectory: &p)
        return e ? p.boolValue : e
    }
    
    /// Creates and returns a `UFSDirectory` at the specified path
    ///
    /// - parameter withIntermediateDirectories: Passing `true` for withIntermediateDirectories will create any necessary intermediate directories.
    /// - parameter attributes: The file attributes for the new directory. You can set the owner and group numbers, file permissions, and modification date.  If you specify nil for this parameter, the directory is created according to the umask(2) macOS Developer Tools Manual Page of the process.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSDirectory` or throws an `Error`.
    @discardableResult
    public func create(withIntermediateDirectories: Bool = false, attributes: [FileAttributeKey: Any]? = nil) throws -> UFSDirectory {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: withIntermediateDirectories, attributes: attributes)
        return UFSDirectory(self)
    }
    
    /// Returns UFSPath with any symlinks resolved.
    public var resolved: UFSPath {
        return UFSPath(url.resolvingSymlinksInPath())
    }
    
    /// Return a standardized UFSPath
    public var standardized: UFSPath {
        return UFSPath(url.standardizedFileURL)
    }
    
    /// Returns a UFSPath constructed by appending the given path component to self.
    ///
    /// - note: This function performs a file system operation to determine if the path component is a directory. If so, it will append a trailing `/`.
    /// - parameter component: The path component to add.
    public func appendingComponent(_ component: String) -> UFSPath {
        let url = self.url.appendingPathComponent(component)
        return UFSPath(url)
    }
    
    /// Returns a UFSPath constructed by removing the last path component of self.
    public func deletingLastComponent() -> UFSPath {
        let url = self.url.deletingLastPathComponent()
        return UFSPath(url)
    }
    
    /// Returns a UFSPath constructed by replacing the last path component of self.
    ///
    /// - parameter component: The path component to used to replace the current last path component.
    public func replacingLastComponent(with component: String) -> UFSPath {
        var pathComponents = components
        pathComponents.removeLast()
        pathComponents.append(component)
        let fileURL = NSURL.fileURL(withPathComponents: pathComponents)! as URL
        return UFSPath(fileURL)
    }
}

extension UFSPath: CustomStringConvertible {
    /// A textual representation of this instance, returning the `rawValue`.
    public var description: String {
        return rawValue
    }
}

extension UFSPath: CustomDebugStringConvertible {
    /// A textual representation of this instance, returning the `rawValue`.
    public var debugDescription: String {
        return rawValue
    }
}

extension UFSPath: ExpressibleByStringLiteral {
    /// Creates an instance initialized to the given string value.
    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
    
    /// Creates an instance initialized to the given value.
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
    
    /// Creates an instance initialized to the given value.
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self.rawValue = value
        self.url = URL(fileURLWithPath: value)
    }
}

public enum UFSResouceType {
    case regularFile
    case aliasFile
    case symbolickLink
    case directory
    case volume
    
    public var resourceKey: URLResourceKey {
        switch self {
        case .regularFile:
            return .isRegularFileKey
        case .aliasFile:
            return .isAliasFileKey
        case .symbolickLink:
            return .isSymbolicLinkKey
        case .directory:
            return .isDirectoryKey
        case .volume:
            return .isVolumeKey
        }
    }
}

public extension URLResourceValues {
    func `is`(a type: UFSResouceType) -> Bool? {
        switch type {
        case .regularFile:
            return self.isRegularFile
        case .aliasFile:
            return self.isAliasFile
        case .symbolickLink:
            return self.isSymbolicLink
        case .directory:
            return self.isDirectory
        case .volume:
            return self.isVolume
        }
    }
}

extension UFSPath {
    
    public func `is`(a type: UFSResouceType) -> Bool {
        let resourceValues = try? url.resourceValues(forKeys: [type.resourceKey])
        
        if let result = resourceValues?.is(a: type) {
            return result
        }
        return false
    }
    
    /// Returns the item located at self or nil if one does not exist.
    public var item: UFSItem? {
        if let volume = volumeItem {
            return volume
        }
        if let directory = directoryItem {
            return directory
        }
        if let symbolicLink = symbolickLinkItem {
            return symbolicLink
        }
        if let aliasFile = aliasFileItem {
            return aliasFile
        }
        if let regularFile = regularFileItem {
            return regularFile
        }
        return nil
    }
    
    public var isRegularFilePath: Bool {
        return self.is(a: .regularFile)
    }
    
    /// Returns the item located at self or nil if one does not exist.
    public var regularFileItem: UFSRegularFile? {
        if self.isRegularFilePath {
            return UFSRegularFile(self)
        }
        return nil
    }
    
    public var isSymbolickLinkPath: Bool {
        return self.is(a: .symbolickLink)
    }
    
    /// Returns the item located at self or nil if one does not exist.
    public var symbolickLinkItem: UFSSymbolicLink? {
        if self.isSymbolickLinkPath {
            return UFSSymbolicLink(self)
        }
        return nil
    }
    
    public var isAliasFilePath: Bool {
        return self.is(a: .aliasFile)
    }
    
    /// Returns the item located at self or nil if one does not exist.
    public var aliasFileItem: UFSAliasFile? {
        if self.isAliasFilePath {
            return UFSAliasFile(self)
        }
        return nil
    }
    
    public var isDirectoryPath: Bool {
        return self.is(a: .directory)
    }
    
    /// Returns the item located at self or nil if one does not exist.
    public var directoryItem: UFSDirectory? {
        if self.isDirectoryPath {
            return UFSDirectory(self)
        }
        return nil
    }
    
    public var isVolumePath: Bool {
        return self.is(a: .volume)
    }
    
    /// Returns the item located at self or nil if one does not exist.
    public var volumeItem: UFSVolume? {
        if self.isVolumePath {
            return UFSVolume(self)
        }
        return nil
    }
}

extension UFSPath: Hashable {
    /// Return the hash value of the raw value.
    public var hashValue: Int {
        return rawValue.hashValue
    }
}

/// Returns if the specified paths are equal according to there standardized paths.
public func ==(lhs: UFSPath, rhs: UFSPath) -> Bool {
    return lhs.url.standardizedFileURL == rhs.url.standardizedFileURL
}
