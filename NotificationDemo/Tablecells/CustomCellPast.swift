//
//  CustomCellPast.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 8/31/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class CustomCellPast: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   
    
   
    @IBOutlet var jobidlabel: UILabel!
    @IBOutlet var jobStatuslabel: UILabel!
    @IBOutlet var datelabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
