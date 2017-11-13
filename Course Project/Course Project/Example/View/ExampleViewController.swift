//
//  ExampleViewController.swift
//  Course Project
//
//  Created by Caio Dias on 2017-11-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import Foundation
import UIKit

public class ExampleViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        PersonController.sharedInstance.fetchListInfo(onSuccess: onSuccessScenario, onFail: onFailScenario)
    }
    
    // This method will be called when fetchListInfo from Controller is finished with success scenario
    private func onSuccessScenario() {
        // Call the main thread to do the next line code to avoid any thread conflict
        DispatchQueue.main.async {
            // Force reload the table view data
            self.tableView.reloadData()
        }
    }
    
    // This method will be called when fetchListInfo from Controller is finished with fail scenario
    private func onFailScenario(errorMessage: String) {
        print(errorMessage)
    }
}

extension ExampleViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.sharedInstance.list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = PersonController.sharedInstance.list[indexPath.row]
        let rawCell = Bundle.main.loadNibNamed("PersonCell", owner: PersonCell.self, options: nil)?.first
        
        guard let personCell = rawCell as? PersonCell else {
            print("Not possible convert the cell to PersonCell")
            return rawCell as! UITableViewCell
        }
        
        personCell.fillCell(withPerson: person)
        
        return personCell
    }
}

extension ExampleViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = PersonController.sharedInstance.list[indexPath.row]
        let alertController = UIAlertController(title: "Person \(person.firstName)", message: "You selected \(person.fullName())\n His/Her email is \(person.email)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler:nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
