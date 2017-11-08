//
//  DefaultButtonCell.swift
//  Course Project
//
//  Created by Caio Dias on 2017-11-08.
//  Copyright © 2017 ProDigi. All rights reserved.
//

import UIKit

class DefaultButtonCell: UITableViewCell {
    @IBOutlet private weak var projectNameLabel: UILabel!
    
    public func fillCell(withStudent name: String) {
        self.projectNameLabel.text = name
    }
}
