//
//  PersonCell.swift
//  Course Project
//
//  Created by Caio Dias on 2017-11-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    
    public func fillCell(withPerson person: Person) {
        self.nameLabel.text = person.fullName()
    }
}

