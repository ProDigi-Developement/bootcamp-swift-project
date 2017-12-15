//
//  ProjectController.swift
//  Course Project
//
//  Created by Alfredo Fernandes on 2017-12-14.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import SystemConfiguration
import Foundation
import UIKit

final class ProjectController {
    
    public private(set) var list: [Project]
    public static let sharedInstance = ProjectController()
    public var selectedUser: Project? = nil
    private let url: String = "https://randomuser.me/api/?results=25"
    
    private init() {
        self.list = [Project]()
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
                    onFail("Data is null.")
                }
            }
        })
        
        task.resume()
    }
    
    private func convertToUsers(withData data: Data) throws -> [Project] {
        
        var tempList = [Project]()
        
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
        if let results = json["results"] as? [[String:Any]] {
            for jsonPerson in results {
                guard let email = jsonPerson["email"] as? String,
                    let names = jsonPerson["name"] as? [String:Any],
                    let firstName = names["first"] as? String,
                    let lastName = names["last"] as? String,
                    let pictures = jsonPerson["picture"] as? [String:Any],
                    let imageLarge = pictures["large"] as? String
                    else {
                        print("Not possible to find the email and first name.")
                        break
                }
                
                tempList.append(Project(firstName: firstName, lastName: lastName, email: email, pictureUrl: imageLarge))
            }
        } else {
            print("No results tag found in response JSON.")
        }
        
        return tempList
    }
    
}
