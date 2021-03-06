//
//  UFSVolume.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSVolume` is a `struct` that is used to represent a volume.
public struct UFSVolume: UFSItem, UFSParent, UFSRenameable, UFSLinkable, UFSSymbolicLinkable {
    /// The path of the volume.
    public var path: UFSPath
    
    /// Creates a `UFSVolume` instance with the specified path.
    ///
    /// - parameter path: The path for the volume.
    ///
    /// - returns: A new `UFSVolume` instance or nil if the `UFSVolume` does not exist at the specified path.
    public init?(path: UFSPath) {
        do {
            let resourceValues = try path.url.resourceValues(forKeys: [.isVolumeKey])
            
            if let isVolume = resourceValues.isVolume, isVolume {
                self.init(path: path)
            } else {
                return nil
            }
            
        } catch _ {
            return nil
        }
    }
    
    /// Creates a `UFSVolume` instance with the specified path.
    ///
    /// - parameter path: The path for the volume.
    ///
    /// - returns: A new `UFSVolume` instance.
    public init(_ path: UFSPath) {
        self.path = path
    }
    
    /// Returns mounted volumes.
    public static var mounted: [UFSVolume] {        
        guard let volumeURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: [], options: []), volumeURLs.isEmpty == false else {
            return []
        }
        
        var volumes: [UFSVolume] = []
        
        for volumeURL in volumeURLs {
            let volume = UFSVolume(UFSPath(volumeURL))
            volumes.append(volume)
        }
        
        return volumes
    }
    
    #if os(macOS)
    /// Unmounts the volume.
    ///
    /// - parameter options: An array of `FileManager.UnmountOptions` used to unmount the volume.
    /// - parameter completionHandler: The completion handler will be executed when the operation is complete, error will be nil the volume was unmounted.
    @available(macOS 10.11, *)
    public func unmount(withOptions options: FileManager.UnmountOptions = [], completionHandler: @escaping (Error?) -> Void) {
        FileManager.default.unmountVolume(at: path.url, options: options, completionHandler: completionHandler)
    }
    #endif
    
    /// Returns if total capacity of the volume in bytes.
    public func totalCapacity() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.volumeTotalCapacityKey])
        return values.volumeTotalCapacity!
    }
    
    /// Returns if available capacity of the volume in bytes.
    public func availableCapacity() throws -> Int {
        let values = try path.url.resourceValues(forKeys: [.volumeAvailableCapacityKey])
        return values.volumeAvailableCapacity!
    }
    
    /// Returns if used capacity of the volume in bytes.
    public func usedCapacity() throws -> Int {
        let total = try totalCapacity()
        let available = try availableCapacity()
        return total - available
    }
    
    /// Returns if the volume is ejectable.
    public func isEjectable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsEjectableKey])
        return values.volumeIsEjectable!
    }
    
    /// Returns if the volume is removeable.
    public func isRemovable() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsRemovableKey])
        return values.volumeIsRemovable!
    }
    
    /// Returns if the volume is internal.
    public func isInternal() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsInternalKey])
        return values.volumeIsInternal!
    }
    
    /// Returns if the volume is local.
    public func isLocal() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsLocalKey])
        return values.volumeIsLocal!
    }
    
    /// Returns if the volume is read only.
    public func isReadOnly() throws -> Bool {
        let values = try path.url.resourceValues(forKeys: [.volumeIsReadOnlyKey])
        return values.volumeIsReadOnly!
    }
}
