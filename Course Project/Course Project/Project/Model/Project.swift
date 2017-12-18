//
//  Project.swift
//  Course Project
//
//  Created by Alfredo Fernandes on 2017-12-14.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation
import UIKit

public class Project {
    
    public let firstName: String
    public let lastName: String
    public let street: String
    public let city: String
    public let state: String
    public let postcode: Int
    public let email: String
    public let cell: String
    public let pictureUrl: String?
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.street = ""
        self.city = ""
        self.state = ""
        self.postcode = 0
        self.email = email
        self.cell = ""
        self.pictureUrl = ""
    }
    
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
    
    public func cityState() -> String {
        return "\(self.city.uppercased()), \(self.state.uppercased())"
    }
    
}
