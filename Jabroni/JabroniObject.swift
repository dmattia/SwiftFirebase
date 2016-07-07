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
    
    internal var whenLoaded: JabroniObject -> () = {_ in
        print("Loaded JabroniObject")
    }
    internal var whenChildChanged: JabroniObject -> () = {_ in
        print("Child Added")
    }
    
    required override init() {
        
    }
    
    required init(snapshotId: String,
                  whenLoaded: JabroniObject -> (),
                  whenChildChanged: JabroniObject -> ()) {
        self.whenLoaded = whenLoaded
        self.whenChildChanged = whenChildChanged
        super.init()
        
        let ref = FIRDatabase.database().reference().child(snapshotId).child("Test Table/Row1")
        ref.observeSingleEventOfType(FIRDataEventType.Value, withBlock: {
            snapshot in
            self.loadFromSnapshot(snapshot)
            self.whenLoaded(self)
        })
        ref.observeEventType(.ChildChanged, withBlock: {
            snapshot in
            if (self.respondsToSelector(NSSelectorFromString(snapshot.key))) {
                self.setValue(snapshot.value!, forKey: snapshot.key)
            }
            self.whenChildChanged(self)
        })
    }
    
    class func fromSnapshotWithId(snapshotId: String,
                                  whenLoaded: JabroniObject -> (),
                                  whenChildChanged: JabroniObject -> ()) -> Self {
        let object = self.init(snapshotId: snapshotId,
                               whenLoaded: whenLoaded,
                               whenChildChanged: whenChildChanged)
        
        return object
    }
    
    func loadFromSnapshot(snapshot: FIRDataSnapshot) {
        for child in snapshot.children {
            let keyName = child.key!
            
            if (respondsToSelector(NSSelectorFromString(keyName))) {
                setValue(child.value, forKey: keyName)
            }
        }
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