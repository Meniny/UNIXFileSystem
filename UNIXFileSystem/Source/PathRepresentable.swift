//
//  UFSPathRepresentable.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSPathRepresentable` can be adopted by anything that can be represented by a `UFSPath`.
public protocol UFSPathRepresentable {
    /// The path that is being represented by the instance of the conforming type.
    var path: UFSPath { get }
    
    /// Instantiates an instance of the conforming type from a path representation, can fail if the path is an invalid representation by the conforming type.
    init?(path: UFSPath)
}
