//
//  ViewController.swift
//  Course Project
//
//  Created by Caio Dias on 2017-11-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    private let projects: [String] = ["ProDigi", "Araceli Teixeira"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentName = self.projects[indexPath.row]
        let rawCell = Bundle.main.loadNibNamed("DefaultButtonCell", owner: DefaultButtonCell.self, options: nil)?.first
        
        guard let buttonCell = rawCell as? DefaultButtonCell else {
            print("Not possible convert the cell to DefaultButtonCell")
            return rawCell as! UITableViewCell
        }
        
        buttonCell.fillCell(withStudent: studentName)
        
        return buttonCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segueId: String = ""
        
        switch indexPath.row {
        case 0:
            segueId = "showProDigiScreen"
        case 1:
            segueId = "showAraceliTeixeiraScreen"
        default:
            print("No specific action.")
        }
        
        if !segueId.isEmpty {
            self.performSegue(withIdentifier: segueId, sender: self)
        }
    }
}
