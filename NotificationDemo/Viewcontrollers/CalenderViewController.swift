//
//  CalenderViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 6/28/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController {
    
    let dataModel = CheckEmail()
    var jobid: String?
    var flag: Int?=0
    var components: NSDateComponents = NSDateComponents()
    let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let currentDate: Date = Date()
    
    let formatter = DateFormatter()
    
    
    @IBOutlet var calendertext: UITextField!
    @IBOutlet var datecontroller: UIDatePicker!
    
    @IBAction func cancelfunc(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destvc = segue.destination as! ViewController
    }
    
    @IBAction func mydatepicker(_ sender: UIDatePicker) {
        let weekDay = Calendar.current.component(.weekday, from: datecontroller.date)
        print("day is:\(weekDay)")
        if(weekDay==1)
        {
        flag=1
            let alert = UIAlertController(title: "Sorry", message: "Jobs cannot be scheduled on Sunday!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        else if(weekDay==7)
        {
            flag=1
            let alert = UIAlertController(title: "Sorry", message: "Jobs cannot be scheduled on Saturday!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            flag=0
        }
     calendertext.text = formatter.string(from:datecontroller.date)
    }
    
    
    
    @IBAction func UpdateButton(_ sender: UIButton) {
        if(flag==0)
        {
        let confirmed_From="Moved from App";
        let encodedSubject1 = confirmed_From.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        calendertext.text = formatter.string(from: datecontroller.date)
        dataModel.Update_scheduledate(jobid: jobid!,schedule_date: calendertext.text!,confirmed_from: encodedSubject1!)
            
            let alert = UIAlertController(title: "Thank you!!", message: "The date you have chosen is updated in our database!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        else{
            
            let alert = UIAlertController(title: "Sorry!!", message: "Please select the tentative date on the weekday!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "YYYY-MM-dd"
        dataModel.delegate = self
        components.day = +2
        let minDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        datecontroller.minimumDate = minDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension CalenderViewController: CheckEmailProtocol {
    
    func APNNotExist(data: String) {
    }
    
    func didRecieveDataAnnouncement(data:NSMutableArray)
    {
    
    }
    func EmailNotExist(data: String) {
      
    }

    func didRecieveDataUpdate(data: String) {
        
    }
    func didRecieveDateInfo(data:NSMutableArray)
    {
        
    }
    func DataNotExist(data:String)
    {
        
    }
}

