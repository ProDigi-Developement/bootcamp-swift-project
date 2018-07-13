//
//  PersonZipController.swift
//  Course Project
//
//  Created by Yash Patel on 2018-01-20.
//  Copyright © 2018 ProDigi. All rights reserved.
//

import Foundation

import SystemConfiguration
import Foundation
import UIKit

//typealias SuccessScenario = () -> Void
//typealias FailScenario = (String) -> Void

final class PersonZipController {
    
    public private(set) var list: [PersonZip]
    public static let sharedInstance = PersonZipController()
    public var selectedUser: PersonZip? = nil
//    private let url: String = "https://randomuser.me/api/?results=25&seed=yashh"

    private let url: String = "https://randomuser.me/api/?results=30&seed=alfredo&nat=us,ca,br"

    private init() {
        self.list = [PersonZip]()
    }
    
    func fetchListInfo(onSuccess: @escaping SuccessScenario, onFail: @escaping FailScenario) {
        
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
                    self.list = try! self.convertToUsers(withData: data)
                    onSuccess()
                } else {
                    onFail("Data is null")
                }
            }
        })
        
        task.resume()
    }
    
    private func convertToUsers(withData data: Data) throws -> [PersonZip] {
        
        var tempList = [PersonZip]()
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
        if let results = json["results"] as? [[String:Any]]{
            for jsonPerson in results {
                guard let email = jsonPerson["email"] as? String,
                    let names = jsonPerson["name"] as? [String:Any],
                    let firstName = names["first"] as? String,
                    let lastName = names["last"] as? String,
                let locations = jsonPerson["location"] as? [String: Any],
                    let street = locations["street"] as? String,
                    let city = locations["city"] as? String,
                    let state = locations["state"] as? String,
                    let postcode = locations["postcode"] as? Int,
                let cell = jsonPerson["cell"] as? String,
                let pictures = jsonPerson["picture"] as? [String: Any],
                    let imageLarge = pictures["large"] as? String
                    else {
                        print("Not possible to find the email and first name.")
                        break
                }
                
                tempList.append(PersonZip(firstName: firstName, lastName: lastName, street: street, city: city, state: state, postcode: postcode, email: email, cell: cell, pictureUrl: imageLarge))            }
        } else {
            print("No results tag found in response JSON.")
        }
        
        return tempList
    }
}
