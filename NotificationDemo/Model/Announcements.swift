//
//  Announcements.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 9/18/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import Foundation

class Announcements: NSObject {
    var message: String?
    var url: String?
    var link: String?
  //  var start:Int?
  //  var end:Int?
    
    override init() {
        
    }
    init(message: String,url:String,link:String)
    {
        self.message=message
        self.url=url
        self.link=link
      //  self.start=start
       // self.end=end
    }
    
}
