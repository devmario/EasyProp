//
//  EasyProp.swift
//
//  Created by jangwonhee on 2016. 6. 30..
//  Copyright © 2016년 devmario. All rights reserved.
//

import Foundation

private var _associatedKey:[String:UInt8] = [:]

extension NSObject {
    private func _associatedObject(key: String, initialiser: () -> [String:AnyObject]?) -> [String:AnyObject]? {
        if _associatedKey.keys.contains(key) == false {
            _associatedKey[key] = 0
        }
        if let associated = objc_getAssociatedObject(self, &(_associatedKey[key])) {
            return associated as? [String:AnyObject]
        }
        let associated = initialiser()
        objc_setAssociatedObject(self, key, associated, .OBJC_ASSOCIATION_RETAIN)
        return associated
    }
    
    private func _associateObject(key: String, value: [String:AnyObject]?) {
        objc_setAssociatedObject(self, &(_associatedKey[key]), value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    public var prop:[String:AnyObject]? {
        get {
            return self._associatedObject(key: "prop") {
                let prop:[String:AnyObject] = [:]
                return prop
            }
        }
        
        set {
            self._associateObject(key: "prop", value: newValue)
        }
    }
}
