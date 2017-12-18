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
    public let iconURL: String
    public var icon: UIImage?
    
    init(_ firstName: String, _ lastName: String, _ email: String, _ address: String, _ city: String,
         _ state: String, _ postcode: String, _ country: String, _ iconURL: String) {
        self.address = address
        self.city = city
        self.state = state
        self.postcode = postcode
        self.country = country
        self.iconURL = iconURL
        
        super.init(firstName: firstName, lastName: lastName, email: email)
        
        loadImage()
    }
    
    public func fullAddress() -> String {
        let separator = ", "
        return address + separator + country
    }
}

extension User {
    private func loadImage() {
        guard let iconURL = URL(string: iconURL) else {
            print("Error: Not possible to create the URL object")
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        (session.dataTask(with: iconURL) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                    else {
                        print("Error: Error on fetch.")
                        return
                }
                
                if let data = data {
                    self.icon = UIImage(data: data)
                } else {
                    print("Error: Data is null")
                }
            }
        }).resume()
    }
}
