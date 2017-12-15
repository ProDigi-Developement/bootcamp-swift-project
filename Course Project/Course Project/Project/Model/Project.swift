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
    public let email: String
    public let pictureUrl: String?
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.pictureUrl = ""
    }
    
    init(firstName: String, lastName: String, email: String, pictureUrl: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.pictureUrl = pictureUrl
    }
    
    public func fullName() -> String {
        return "\(self.firstName.capitalized) \(self.lastName.capitalized)"
    }
    
}
