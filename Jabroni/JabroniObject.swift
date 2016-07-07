//
//  JabroniObject.swift
//  Jabroni
//
//  Created by David Mattia on 7/6/16.
//  Copyright © 2016 South Bend Code School. All rights reserved.
//

import Foundation
import Firebase

class JabroniObject : NSObject {

    internal let ref: FIRDatabaseReference!
    internal let snapshot: FIRDataSnapshot!
    internal var whenChildChanged: JabroniObject -> () = {_ in
        print("Child Added")
    }
    
    init(fromOtherJabroniObject: JabroniObject) {
        self.ref = fromOtherJabroniObject.ref
        self.snapshot = fromOtherJabroniObject.snapshot
    }
    
    init(ref: FIRDatabaseReference, withSnapshot: FIRDataSnapshot) {
        self.ref = ref
        self.snapshot = withSnapshot
    }
    
    func loadFromSnapshot() {
        for child in self.snapshot.children {
            let keyName = child.key!
            
            if (respondsToSelector(NSSelectorFromString(keyName))) {
                setValue(child.value, forKey: keyName)
            }
        }
    }
    
    func beginWatchingForChanges(onChange: JabroniObject -> ()) {
        self.ref.observeSingleEventOfType(FIRDataEventType.Value, withBlock: {
            snapshot in
            self.loadFromSnapshot()
            onChange(self)
        })
    }
    
    func propertyNames() -> [String] {
        var names: [String] = []
        var count: UInt32 = 0
        let properties = class_copyPropertyList(classForCoder, &count)
        for i in 0 ..< Int(count) {
            let property: objc_property_t = properties[i]
            let name: String = String.fromCString(property_getName(property))!
            names.append(name)
        }
        free(properties)
        return names
    }
    
    func asJson() -> NSDictionary {
        var json:Dictionary<String, AnyObject> = [:]
        
        for name in propertyNames() {
            if let value: AnyObject = valueForKey(name) {
                json[name] = value
            }
        }
        
        return json
    }
}