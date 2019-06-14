//
//  YesNoViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 6/28/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class YesNoViewController: UIViewController{
    
    public var userInfo: NSDictionary = [:]
    var jobid1: String?
    var jobtype1: String?
    var subdiv1: String?
    var lot1: String?
    
    let dataModel = CheckEmail()
  
    @IBOutlet var notificationtext: UITextView!
  
    @IBAction func yesButton(_ sender: UIButton) {
        print(jobid1)
        performSegue(withIdentifier: "showyes", sender: self)
    }
 
    @IBAction func cancelbutt(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
       // performSegue(withIdentifier: "signupidentifier", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "signupidentifier"
         {
            let destvc = segue.destination as! ViewController
         }
         else if segue.identifier == "showcalender"
         {
            let destvc = segue.destination as! CalenderViewController
            destvc.jobid = jobid1
         }
        else if segue.identifier == "showyes"
        {
            let destvc = segue.destination as! AfterYesViewController
            destvc.jobid = jobid1
        }
    }
    
    @IBAction func noButton(_ sender: UIButton) {
        performSegue(withIdentifier: "showcalender", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.delegate = self
        print("In YesNoActivity Viewdidload")
        let nc = NotificationCenter.default
        nc.addObserver(forName:Notification.Name(rawValue:"YesNoActivity"),
                       object:nil, queue:nil,
                       using:catchNotification)
    }
    
    func catchNotification(notification:Notification) -> Void {
        let userInfo = notification.userInfo
        if let aps = userInfo?["aps"] as? NSDictionary {
        }
        if let jobid = userInfo?["jobid"] as? NSString {
            jobid1 = jobid as String
            print("in YesNo viewcontroller\(jobid)")
        }
        if let jobtype = userInfo?["jobtype"] as? NSString {
            print("in YesNo viewcontroller\(jobtype)")
            jobtype1 = jobtype as String
        }
        if let subdiv = userInfo?["subdiv"] as? NSString {
            subdiv1 = subdiv as String
            print("in YesNo viewcontroller\(subdiv)")
        }
        if let lot = userInfo?["lot"] as? NSString {
            lot1 = lot as String
            print("in YesNo viewcontroller\(lot)")
        }
        if(jobtype1=="")
        {
            jobtype1="not specified"
        }
        if(subdiv1=="")
        {
            subdiv1="not specified"
        }
        if(lot1=="")
        {
            lot1="not specified"
        }
        notificationtext.text="Hi Builder\n\nYou have '"+jobtype1!.trimmingCharacters(in: .whitespacesAndNewlines)+"' at lot '"+lot1!.trimmingCharacters(in: .whitespacesAndNewlines)+"' in '"+subdiv1!.trimmingCharacters(in: .whitespacesAndNewlines)+"'"
        print(notificationtext.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidAppear(_ animated: Bool) {

    }
    override func viewWillDisappear(_ animated: Bool) {
       _ = navigationController?.popToRootViewController(animated: true)
    }
}

extension YesNoViewController: CheckEmailProtocol {
    func didRecieveDataAnnouncement(data:NSMutableArray)
    {
       
    }
    func APNNotExist(data: String) {
        
    }
    func didRecieveDataUpdate(data: String) {

    }
    func EmailNotExist(data: String) {
        
    }
    func didRecieveDateInfo(data:NSMutableArray)
    {
        
    }
    func DataNotExist(data:String)
    {
        
    }
    
}
