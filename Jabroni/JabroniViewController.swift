//
//  JabroniViewController.swift
//  Jabroni
//
//  Created by David Mattia on 7/6/16.
//  Copyright © 2016 South Bend Code School. All rights reserved.
//

import Foundation
import UIKit

class JabroniViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userQuery = JabroniQuery(className: "Test Table")
        userQuery.getObjectInBackgroundWithId("Row2", afterCompletion: {
            jabroniObject in
            
            var user = User(fromOtherJabroniObject: jabroniObject)
            user.loadFromSnapshot()
            print(user.asJson())

            user.beginWatchingForChanges({
                newUser in
                user = User(fromOtherJabroniObject: newUser)
                print(user.asJson())
            })
        })
        
        let dealQuery = JabroniQuery(className: "Deals")
        dealQuery.getObjectInBackgroundWithId("deal1", afterCompletion: {
            jabroniObject in
            
            let deal = Deal(fromOtherJabroniObject: jabroniObject)
            deal.loadFromSnapshot()
            print(deal.asJson())
        })
    }
}