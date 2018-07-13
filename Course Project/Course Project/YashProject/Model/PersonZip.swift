//
//  PersonZip.swift
//  Course Project
//
//  Created by Yash Patel on 2018-01-20.
//  Copyright © 2018 ProDigi. All rights reserved.
//

import Foundation

public class PersonZip {
    
    public let firstName: String
    public let lastName: String
    public let street: String
    public let city: String
    public let state: String
    public let postcode: Int
    public let email: String
    public let cell: String
    public let pictureUrl: String?
    
    
    init(firstName: String, lastName: String, street: String, city: String, state: String, postcode: Int, email: String, cell: String, pictureUrl: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.street = street
        self.city = city
        self.state = state
        self.postcode = postcode
        self.email = email
        self.cell = cell
        self.pictureUrl = pictureUrl
    }
    
    public func fullName() -> String {
        return "\(self.firstName.capitalized) \(self.lastName.capitalized)"
    }
    
}
