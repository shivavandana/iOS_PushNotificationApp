//
//  DetailsController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 8/9/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    let dataModel = CheckEmail()
    
    var info:NSMutableArray?
    var info_status: String="nodata"
    @IBOutlet var lot: UILabel!
    @IBOutlet var subdivision: UILabel!
    @IBOutlet var jobtype: UILabel!
    @IBOutlet var Schedule_date: UILabel!
    var date_fromcontroller: String?
    var job_id: String?
    
    @IBAction func yesbutton(_ sender: Any) {
        performSegue(withIdentifier: "showyess", sender: self)
    }
    @IBAction func futurejob_NotReady(_ sender: Any) {
         performSegue(withIdentifier: "showcalenderfuture", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showcalenderfuture"
        {
            let destvc = segue.destination as! CalenderViewController
            destvc.jobid = job_id
        }
        else if segue.identifier == "showyess"
        {
            let destvc = segue.destination as! AfterYesViewController
            destvc.jobid = job_id
        }
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        dataModel.delegate = self
        Schedule_date.text = date_fromcontroller
        //dataModel.selectdetails(job_id: job_id!)
    }
  
    @IBAction func cancelbutton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        dataModel.selectdetails(job_id: job_id!)
    }
    
    func statusprint(info:NSMutableArray)
    {
        for location in (info as NSArray as! [DateInfo]) {
            lot.text = location.lot
            subdivision.text = location.subdivision
            jobtype.text = location.jobtype
          //  Schedule_date.text = location.date
        }
    }
}
extension DetailsController: CheckEmailProtocol {
    func didRecieveDataAnnouncement(data:NSMutableArray)
    {
       
    }
    func APNNotExist(data: String) {
        
    }
    func didRecieveDataUpdate(data: String) {
        
    }
    func EmailNotExist(data:String)
    {
        
    }
    func didRecieveDateInfo(data:NSMutableArray)
    {
        info_status="data"
        info=data
        print("infoooo\(info)")
        DispatchQueue.main.async(execute: {
             self.statusprint(info: self.info!)
        })
    }
    
    func DataNotExist(data:String)
    {
        info_status="nodata"
    }
    
}
