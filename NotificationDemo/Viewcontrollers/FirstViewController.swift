//
//  FirstViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 9/15/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit
import Foundation
//import Cocoa

class FirstViewController: UIViewController {
    //var announcement: String?
     var announcement: [String] = []
     var url: [String] = []
      var link: [String] = []
    let dataModel = CheckEmail()
    var appletoken: String?
    var eachone: String?
    var countarray:Int?
    var countlink:Int?

    @IBOutlet var holidays_text: UITextView!
    
    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "showlogin", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="showlogin")
        {
            let destvc = segue.destination as! ViewController
            destvc.appletoken = appletoken
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
         dataModel.delegate = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        
        nc.addObserver(forName:Notification.Name(rawValue:"appletoken"),
                       object:nil, queue:nil,
                       using:appletokengenerator)
        DispatchQueue.main.async(execute: {
          self.dataModel.selectAnnouncement()
         })
        
    }
    
    func appletokengenerator(notification:Notification) -> Void {
        let userInfo = notification.userInfo
        appletoken  = userInfo?["appletoken"] as? String
        print("appletoken1\(String(describing: appletoken))")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
}
extension FirstViewController: CheckEmailProtocol {
    
     func didRecieveDataAnnouncement(data:NSMutableArray)
     {
        DispatchQueue.main.async(execute: {
        for location in (data as NSArray as! [Announcements]) {
            self.announcement.append(location.message!)
            self.url.append(location.url!)
            self.link.append(location.link!)
        }
            
            self.countarray = self.announcement.count
            self.holidays_text.text=""
            var string    = ""
            while(self.countarray! > 0)
            {
                string  =  string +  self.announcement[self.countarray!-1] + "\n\n"
                self.countarray!=self.countarray!-1
            }

            self.countlink = self.announcement.count
            let attributedString    = NSMutableAttributedString(string: string)
            var totalContent = ""
            
            while(self.countlink!>0)
            {
                totalContent  =  totalContent + self.announcement[self.countlink!-1] + "\n\n"
                let str = self.link[self.countlink!-1]
                let count = totalContent.count
                let linkcount = self.link[self.countlink!-1].count
                let originalstr=self.announcement[self.countlink!-1]
                let originalstrcount=self.announcement[self.countlink!-1].count
                
                var position:Int?
      
                if let range = originalstr.range(of: str) {
                    let startPos = originalstr.distance(from: originalstr.startIndex, to: range.lowerBound)
                    _ = originalstr.distance(from: originalstr.startIndex, to: range.upperBound)
                    position=count - originalstrcount + startPos - 2
                 
                }
      
                if(self.url[self.countlink!-1] != "no")
                {
                    var style = NSMutableParagraphStyle()
                    style.lineSpacing = 36 // change line spacing between paragraph like 36 or 48
                    style.minimumLineHeight = 25
                    attributedString.addAttribute(NSAttributedString.Key.link, value: NSURL(string:self.url[self.countlink!-1])!, range: NSMakeRange(position!, linkcount))
                    
                    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: NSMakeRange(position!, linkcount))
                    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(position!, linkcount))
                    attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
                }
                self.countlink!=self.countlink!-1
            }
        
            self.holidays_text.attributedText = attributedString
           
           let newAttributedString = NSMutableAttributedString(attributedString: self.holidays_text.attributedText)
            
            // Enumerate through all the font ranges
            newAttributedString.enumerateAttribute(NSAttributedString.Key.font, in: NSMakeRange(0, newAttributedString.length), options: []) { value, range, stop in
                guard let currentFont = value as? UIFont else {
                    return
                }
           
                
                let fontDescriptor = currentFont.fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.family: "Times New Roman"])
                if let newFontDescriptor = fontDescriptor.matchingFontDescriptors(withMandatoryKeys: [UIFontDescriptor.AttributeName.family]).first {
                    
                    let titleParagraphStyle = NSMutableParagraphStyle()
                    titleParagraphStyle.alignment = .center
                    titleParagraphStyle.lineSpacing = 10
                    
                    let newFont = UIFont(descriptor: newFontDescriptor, size: 22)
                    newAttributedString.addAttributes([NSAttributedString.Key.font: newFont], range: range)
                    newAttributedString.addAttributes([NSAttributedString.Key.paragraphStyle: titleParagraphStyle], range: range)
                }
            }

           self.holidays_text.attributedText = newAttributedString
        
       })
     }
    
    func didRecieveDataUpdate(data: String) {
        
    }
    
    func APNNotExist(data: String) {
    }
    
    func EmailNotExist(data:String)
    {
        
    }
    
    func didRecieveDateInfo(data:NSMutableArray)
    {
        
    }
    func DataNotExist(data:String)
    {
        announcement=["nodata"]
    }
    
    func checkingEmailExistance(email_status: String, email_id: String)
    {
    }
}
