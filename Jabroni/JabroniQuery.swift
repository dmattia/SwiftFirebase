//
//  JabroniQuery.swift
//  Jabroni
//
//  Created by David Mattia on 7/6/16.
//  Copyright © 2016 South Bend Code School. All rights reserved.
//

import Foundation
import Firebase

class JabroniQuery {
    internal let className: String
    internal let ref: FIRDatabaseReference!
    
    init(className: String) {
        self.className = className
        self.ref = FIRDatabase.database().reference().child("-KM55GzwRJq3kiOCn-W2").child(self.className)
    }
    
    func getObjectInBackgroundWithId(id: String, afterCompletion: JabroniObject -> ()) {
        self.ref.child(id).observeSingleEventOfType(FIRDataEventType.Value, withBlock: {
            snapshot in
            
            afterCompletion(JabroniObject(ref: self.ref.child(id), withSnapshot: snapshot))
        })
    }
}