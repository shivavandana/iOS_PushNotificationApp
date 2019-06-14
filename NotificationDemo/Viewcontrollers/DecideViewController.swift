//
//  DecideViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 9/1/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit


import Foundation
import MessageUI


class DecideViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{

    var id: String?
     let dataModel = CheckEmail()
     var placeholderLabel : UILabel!
    let composeVC = MFMailComposeViewController()

    
     @IBOutlet var message: UITextView!
    

     @IBAction func submitmessage(_ sender: Any) {
        let messagetrim=message.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let message_withNowhitespaces = messagetrim?.replacingOccurrences(of: " ", with: "")
        if message_withNowhitespaces==""
        {
           
        }
        else
        {
            if MFMailComposeViewController.canSendMail() {
                sendEmail()
            }
            else{
                print("Mail services are not available")
                var encodedSubject = message.text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

                     dataModel.Update_Message(id: id!,msg:encodedSubject!)
                let alert = UIAlertController(title: "Thank you!!", message: "We will contact you soon!!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                     self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func messageComposeViewController(_ controller:MFMessageComposeViewController, didFinishWith result:MessageComposeResult){
        self.dismiss(animated:true,completion:nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }

   
    @IBAction func futuredatebutton(_ sender: UIButton) {
         performSegue(withIdentifier: "showfuturedates", sender: self)
    }
    @IBAction func pastdate_button(_ sender: UIButton) {
         performSegue(withIdentifier: "showpastdates", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.hideKeyboardWhenTappedAround()
         message.delegate = self

    }
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["schedule@theperformancepoint.com"])
        composeVC.setSubject("Sent from Performance Point Notifications iphone App!")
        composeVC.setMessageBody(message.text, isHTML: false)
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            let alert = UIAlertController(title: "Thank you!!", message: "We will contact you soon!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .failed:
            break
        }
         controller.dismiss(animated: true, completion: nil)
    }
    
    // Do any additional setup after loading the view
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showfuturedates"
        {
            let destvc = segue.destination as! JobDateViewController
             destvc.id = id
        }
        else if segue.identifier == "showpastdates"
        {
            let destvc = segue.destination as! PastJobsViewController
            destvc.id = id
        }
    }
    
}
extension DecideViewController: CheckEmailProtocol {
    
    func didRecieveDataAnnouncement(data:NSMutableArray)
    {
        
    }
    func didRecieveDataUpdate(data: String) {
        
    }
    func APNNotExist(data: String) {
        
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

