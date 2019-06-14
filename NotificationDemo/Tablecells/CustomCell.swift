//
//  CustomCell.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 8/7/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var datelabel: UILabel!
    @IBOutlet var jobidlabel: UILabel!
    @IBOutlet var jobStatuslabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
