//
//  UserController.swift
//  Course Project
//
//  Created by Araceli Teixeira on 15/12/17.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

final class UserController {
    private let url = "https://randomuser.me/api/?results=10&inc=name,email,location,nat,picture&nat=ca&noinfo"
    public static let sharedInstance = UserController()
    public private(set) var userList: [User]
    
    private init() {
        userList = []
    }
    
    func fetchUserList(onSuccess: @escaping SuccessScenario, onFail: @escaping FailScenario) {
        guard let urlRequest = URL(string: url) else {
            onFail("Not possible to create the URL object")
            return
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
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
                    let city = location["city"] as? String,
                    let state = location["state"] as? String,
                    let postcode = location["postcode"] as? Int,
                    let country = jsonUser["nat"] as? String,
                    let imageUrls = jsonUser["picture"] as? [String:Any],
                    let iconURL = imageUrls["thumbnail"] as? String
                else {
                    print("Not possible to find the user data.")
                    break
                }
                list.append(User(firstName, lastName, email, address, city, state, String(postcode), country, iconURL))
            }
        } else {
            print("No results tag found in response JSON.")
        }
        
        return list
    }
}
