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
        
        User.fromSnapshotWithId("-KM2Qa7SEhvoJ32TLyS6", whenLoaded: {
            user in
            print("when loaded")
            print(user.asJson())
        }, whenChildChanged: {
            user in
            print("child changed")
            print(user.asJson())
        })
    }
}