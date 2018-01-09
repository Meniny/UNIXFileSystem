//
//  UFSFile.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/// `UFSFile` is the base `protocol` for a single file.
//public protocol UFSFile: UFSItem, UFSSubitem, UFSCopyable, UFSCopyableSubitem, UFSMoveable, UFSMoveableSubitem, UFSRenameable, UFSRemoveable, UFSTrashable, UFSLinkable, UFSSymbolicLinkable, UFSAliasable {}

public protocol UFSFile: UFSCopyableSubitem, UFSMoveableSubitem, UFSRenameable, UFSRemoveable, UFSTrashable, UFSLinkable, UFSSymbolicLinkable, UFSAliasable {}

extension UFSFile {
    /// Returns wether the contents of the specified files are equal.
    public func isContentEqual(to file: Self) -> Bool {
        return FileManager.default.contentsEqual(atPath: path.rawValue, andPath: file.path.rawValue)
    }
}
