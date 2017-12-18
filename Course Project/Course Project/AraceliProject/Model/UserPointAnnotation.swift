//
//  UserPointAnnotation.swift
//  Course Project
//
//  Created by Araceli Teixeira on 17/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit
import MapKit

class UserPointAnnotation: MKPointAnnotation {
    public let user: User
    
    init(_ user: User) {
        self.user = user
        super.init()
    }
}
