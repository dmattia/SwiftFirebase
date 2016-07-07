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
        
        User.fromSnapshotWithId("-KM2G44QbDS4KgdBVIdy", whenLoaded: {
            user in
            print(user.asJson())
        })
    }
}