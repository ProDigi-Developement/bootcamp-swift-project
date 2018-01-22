//
//  TopViewTableViewCell.swift
//  Course Project
//
//  Created by Yash Patel on 2018-01-19.
//  Copyright © 2018 ProDigi. All rights reserved.
//

import UIKit

class TopViewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
