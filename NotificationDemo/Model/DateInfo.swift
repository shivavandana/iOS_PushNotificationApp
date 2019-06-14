//
//  DateInfo.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 8/7/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import Foundation
class DateInfo: NSObject {
    var date: String?
    var jobid:String?
    var status: String?
    var subdivision: String?
    var lot: String?
    var jobtype: String?
    
    override init() {
        
    }
  
    init(date:String,jobid: String, status: String)
    {
        self.date=date
        self.jobid=jobid
        self.status=status
    }
    init(date:String,status: String, subdivision: String,lot: String,jobtype: String  )
    {
        self.date=date
        self.status=status
        self.subdivision=subdivision
        self.lot=lot
        self.jobtype=jobtype
        
    }
}


