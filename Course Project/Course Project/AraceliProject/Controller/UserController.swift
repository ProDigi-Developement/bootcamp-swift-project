//
//  UserController.swift
//  Course Project
//
//  Created by Araceli Teixeira on 15/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

class UserController {
    private let url = "https://randomuser.me/api/?results=20&inc=name,email,location,nat,picture&nat=ca&noinfo"
    public private(set) var userList: [User]
    
    init() {
        userList = []
    }
    
    func fetchUserList(onSuccess: @escaping SuccessScenario, onFail: @escaping FailScenario) {
        guard let urlRequest = URL(string: url) else {
            onFail("Not possible to create the URL object")
            return
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error = error {
                onFail(error.localizedDescription)
            } else {
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                    else {
                        onFail("Error on fetch.")
                        return
                }
                
                if let data = data {
                    self.userList = try! self.convertToUsers(withData: data)
                    onSuccess()
                } else {
                    onFail("Data is null")
                }
            }
        })
        
        task.resume()
    }
    
    private func convertToUsers(withData data: Data) throws -> [User] {
        var list: [User] = []
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
        if let results = json["results"] as? [[String:Any]] {
            for jsonUser in results {
                guard let names = jsonUser["name"] as? [String:Any],
                    let firstName = names["first"] as? String,
                    let lastName = names["last"] as? String,
                    let email = jsonUser["email"] as? String,
                    let location = jsonUser["location"] as? [String:Any],
                    let address = location["street"] as? String,
                    let city = location[""] as? String,
                    let state = location[""] as? String,
                    let postcode = location["postcode"] as? String,
                    let country = jsonUser["nat"] as? String,
                    let imageUrls = jsonUser["picture"] as? [String:Any],
                    let pictureURL = imageUrls["large"] as? String,
                    let iconURL = imageUrls["thumbnail"] as? String
                else {
                    print("Not possible to find the user data.")
                    break
                }
                list.append(User(firstName, lastName, email, address, city, state, postcode, country, pictureURL, iconURL))
            }
        } else {
            print("No results tag found in response JSON.")
        }
        
        return list
    }
}
