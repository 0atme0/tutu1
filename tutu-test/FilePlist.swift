//
//  FilePlist.swift
//  tutu-test
//
//  Created by Andrey Ildyakov on 20.06.16.
//  Copyright © 2016 111. All rights reserved.
//



import Foundation


class FilePlist {
    var flag : AnyObject? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey("flag") as AnyObject?
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "flag")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
}