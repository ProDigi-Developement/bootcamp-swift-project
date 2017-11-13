//
//  PersonController.swift
//  Course Project
//
//  Created by Caio Dias on 2017-11-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation

import SystemConfiguration
import Foundation

typealias SuccessScenario = () -> Void
typealias FailScenario = (String) -> Void

final class PersonController {
    public private(set) var list: [Person]
    public static let sharedInstance = PersonController()
    public var selectedUser: Person? = nil
    private let url: String = "https://randomuser.me/api/?results=25"
    
    private init() {
        self.list = [Person]()
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
    
    private func convertToUsers(withData data: Data) throws -> [Person] {
        var tempList = [Person]()
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
        if let results = json["results"] as? [[String:Any]]{
            for jsonPerson in results {
                guard let email = jsonPerson["email"] as? String,
                let names = jsonPerson["name"] as? [String:Any],
                let firstName = names["first"] as? String,
                let lastName = names["last"] as? String
                else {
                    print("Not possible to find the email and first name.")
                    break
                }
                
                tempList.append(Person(firstName: firstName, lastName: lastName, email: email))
            }
        } else {
            print("No results tag found in response JSON.")
        }
        
        return tempList
    }
}
