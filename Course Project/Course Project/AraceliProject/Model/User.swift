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
    
    public func fullAddress() -> String {
        let separator = ", "
        return address + separator + city + separator + state + separator + country
    }
}

extension User {
    
    public var picture: UIImage? {
        return loadImage(imageUrl: pictureURL)
    }
    public var icon: UIImage? {
        return loadImage(imageUrl: iconURL)
    }

    private func loadImage(imageUrl: String) -> UIImage? {
        guard let url = URL(string: imageUrl) else {
            print("Error: Not possible to create the URL object")
            return nil
        }
        var image: UIImage?
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        (session.dataTask(with: url) { (data, response, error) in
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
                    image = UIImage(data: data)
                } else {
                    print("Error: Data is null")
                }
            }
        }).resume()
        
        return image
    }
    
    
}
