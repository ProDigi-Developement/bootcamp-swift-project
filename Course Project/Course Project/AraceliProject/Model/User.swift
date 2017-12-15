//
//  Person.swift
//  Course Project
//
//  Created by Araceli Teixeira on 15/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

class User: Person {
    public var address: String
    public var city: String
    public var state: String
    public var postcode: String
    public var country: String
    public var pictureURL: String
    public var picture: UIImage
    
    init(_ firstName: String, _ lastName: String, _ email: String, _ address: String, _ city: String,
         _ state: String, _ postcode: String, _ country: String, _ pictureURL: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.city = city
        self.state = state
        self.postcode = postcode
        self.country = country
        self.pictureURL = pictureURL
    }
}
