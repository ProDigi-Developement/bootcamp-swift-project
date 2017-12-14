//
//  Project.swift
//  Course Project
//
//  Created by Alfredo Fernandes on 2017-12-14.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation

public class Project {
    
    public let firstName: String
    public let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = ""
        self.lastName = ""
    }
    
    public func fullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}
