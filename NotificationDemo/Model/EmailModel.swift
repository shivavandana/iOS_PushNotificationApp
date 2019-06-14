//
//  EmailModel.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 6/23/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class EmailModel: NSObject {
    var email: String?
    var name:String?
    
    override init() {
       
    }
    init(email: String)
    {
        self.email=email
        
    }
    
    init(name:String,email: String)
    {
        self.name=name
        self.email=email
    }

}
