//
//  UFSFileWrapperConvertible.swift
//  UNIXFileSystem
//
//  Created by Meniny on 02/11/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

public typealias UFSFileWrapper = FileWrapper

/// `UFSFileWrapperConvertible` `protocol` for an `UFSItem` that can be converted into a `UFSFileWrapper`.
public protocol UFSFileWrapperConvertible: UFSItem {
    /// Returns a file wrapper instantiated with the instance of the conforming type.
    func fileWrapper() throws -> UFSFileWrapper
}

extension UFSFileWrapperConvertible {
    /// Returns a `UFSFileWrapper` for the `UFSItem`.
    ///
    /// - throws: An `Error`.
    ///
    /// - returns: A `UFSFileWrapper`.
    public func fileWrapper() throws -> UFSFileWrapper {
        return try UFSFileWrapper(url: path.url, options: [])
    }
}
