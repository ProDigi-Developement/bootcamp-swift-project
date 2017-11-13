//
//  Person.swift
//  Course Project
//
//  Created by Caio Dias on 2017-11-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation

public class Person {
    public let firstName: String
    public let lastName: String
    public let email: String
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    public func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}
