//
//  JobDateViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 8/7/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class JobDateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let dataModel = CheckEmail()
    
    var info:NSMutableArray?
    var locations:NSMutableArray?
    var id: String?
    var info_status: String="nodata"
    var dateArray: [String] = []
    var jobidArray: [String] = []
    var job_StatusArray: [String] = []
    var tempdate:Date?
    var tempdateString:String?
    
   // var refresher:UIRefreshControl!
    var refresher:UIRefreshControl!
    
   
    @IBAction func backbutton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         dataModel.delegate = self
         tableView.delegate = self
         tableView.dataSource = self
        
        
      refresher = UIRefreshControl()
      refresher.attributedTitle=NSAttributedString(string:"Pull to refresh")
        refresher.addTarget(self, action:"refresh", for:UIControl.Event.valueChanged)
      tableView.addSubview(refresher)
   
      
    }
    func refresh(sender:AnyObject) {
        self.statusprint(info: info!)
        refresher.endRefreshing()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        dataModel.selectdates(id: id!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.datelabel.text = dateArray[indexPath.row]
        cell.jobidlabel.text = jobidArray[indexPath.row]
        cell.jobStatuslabel.text = job_StatusArray[indexPath.row]
        return cell;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateArray.count;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "toDetailView", sender: nil)
        })
    }
    
    func statusprint(info:NSMutableArray)
    {
        dateArray = []
        jobidArray = []
        job_StatusArray = []
        
        for location in (info as NSArray as! [DateInfo]) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            tempdate = dateFormatter.date(from: location.date!)
            dateFormatter.dateFormat = "MM-dd-yyyy"
            tempdateString = dateFormatter.string(from:tempdate!)
     
           
            self.dateArray.append(tempdateString!)
            self.jobidArray.append(location.jobid!)
            self.job_StatusArray.append(location.status!)
        }
        refresher.endRefreshing()
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "toDetailView"{
       if let indexPath = tableView.indexPathForSelectedRow
       {
        let destVC = segue.destination as! DetailsController
        destVC.job_id = jobidArray[indexPath.row]
        destVC.date_fromcontroller = dateArray[indexPath.row]
       }
     }
    }
   }
    
extension JobDateViewController: CheckEmailProtocol {
    
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
        statusprint(info: info!)
    }
    func refresh(){
        DispatchQueue.main.async() { () -> Void in
            dump(self.dateArray)
            dump(self.jobidArray)
            dump(self.job_StatusArray)
            self.tableView.reloadData()
            self.refresher.endRefreshing()
            if(self.dateArray.count == 0)
            {
                let alert = UIAlertController(title: "Empty", message: "No jobs on your schedule!!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.refresher.endRefreshing()
            }
        }
        self.refresher.endRefreshing()
    }
    func DataNotExist(data:String)
    {
          info_status="nodata"
    }
    
}

