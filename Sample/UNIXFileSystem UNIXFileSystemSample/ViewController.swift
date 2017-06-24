//
//  ViewController.swift
//  UNIXFileSystem UNIXFileSystemSample
//
//  Created by Meniny on 2017-06-24.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import UNIXFileSystem

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let dir = FileSystem.document
        let folderName = "UFS_TEST_DIRECTORY \(Date())".replacingOccurrences(of: " ", with: "_")
        
        self.createDirectory(folderName, at: dir)
        print("-----------")
        self.listContents(of: dir)
    }
    
    func createDirectory(_ folderName: String, at dir: UFSDirectory) {
        let path = dir.path.appendingComponent(folderName)
        if !path.exists {
            if let _ = try? path.create(withIntermediateDirectories: true, attributes: nil) {
                print(folderName + " created")
            } else {
                print(folderName + " failed")
            }
        } else {
            print(folderName + " exists")
        }
    }
    
    func listContents(of dir: UFSDirectory) {
        if let items = try? dir.subitems() {
            for i in items {
                print(i.path.lastComponent)
                if i.isDirectory() {
                    self.listContents(of: UFSDirectory(i.path))
                }
            }
        }
    }


}

