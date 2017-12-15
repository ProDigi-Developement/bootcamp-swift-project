//
//  Person.swift
//  Course Project
//
//  Created by Araceli Teixeira on 15/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

class User: Person {
    public let address: String
    public let city: String
    public let state: String
    public let postcode: String
    public let country: String
    public let pictureURL: String
    public let iconURL: String
    public var picture: UIImage? = nil
    public var icon: UIImage? = nil
    
    init(_ firstName: String, _ lastName: String, _ email: String, _ address: String, _ city: String,
         _ state: String, _ postcode: String, _ country: String, _ pictureURL: String, _ iconURL: String) {
        self.address = address
        self.city = city
        self.state = state
        self.postcode = postcode
        self.country = country
        self.pictureURL = pictureURL
        self.iconURL = iconURL
        super.init(firstName: firstName, lastName: lastName, email: email)
    }
}
