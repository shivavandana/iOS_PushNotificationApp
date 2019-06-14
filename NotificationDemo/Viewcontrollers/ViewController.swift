//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 6/21/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseCore

class ViewController: UIViewController, UITextFieldDelegate,BEMCheckBoxDelegate{
    @IBOutlet var image: UIImageView!
    
    let dataModel = CheckEmail()
    var feedItems = [EmailModel]()
    var email_status: String="noemail"
    var  apn_status: String="noapn"
    var flag: Int?=2
    var email_id: String?
    var appletoken: String?
    var selectedLocation : EmailModel = EmailModel()
    
    @IBOutlet var textViewterms: UITextView!
    @IBOutlet var signupbutton: UIButton!
    @IBOutlet var builderemail: UITextField!
    
    @IBOutlet var checkbox: BEMCheckBox!
    
    func didTap(_ checkBox: BEMCheckBox) {
        if checkBox.on
        {
            signupbutton.isEnabled = true
        }
        else
        {
            signupbutton.isEnabled = false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.hideKeyboardWhenTappedAround()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkbox.setOn(false, animated: true)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupbutton.isEnabled=false
        dataModel.delegate = self
        checkbox.delegate=self
        self.hideKeyboardWhenTappedAround()
        
        textViewterms.translatesAutoresizingMaskIntoConstraints = false
        textViewterms.isScrollEnabled = false
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func SignUp(_ sender: UIButton) {
    let token=InstanceID.instanceID().token()
        print("FCM token: \(token ?? "")")
        
        if ConnectionCheck.isConnectedToNetwork() {
            print("Connected")
        if builderemail.text==""
        {
            let alert = UIAlertController(title: "Sorry", message: "Enter the email registered with us", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            let emailtrim=builderemail.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            let email_withNowhitespaces = emailtrim?.replacingOccurrences(of: " ", with: "")
            dataModel.findEmail(email: email_withNowhitespaces!)
            
        }
    }
    else{
            let alert = UIAlertController(title: "Internet not active", message: "Please check your Internet is turned on!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
        }
    }

    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }
}
extension ViewController: CheckEmailProtocol {
    
    func didRecieveDataAnnouncement(data:NSMutableArray)
    {
       
    }
    
    func didRecieveDataUpdate(data: String) {
        email_status="email"
        email_id=data
        dataModel.findNewCustomer(email_id: email_id!)
        checkingEmailExistance(email_status: email_status, email_id: email_id!)
    }
  
    func EmailNotExist(data:String)
    {
        email_status="noemail"
        checkingEmailExistance(email_status: email_status, email_id: "emailid")
    }
    
    func didRecieveDateInfo(data:NSMutableArray)
    {
        
    }
    func DataNotExist(data:String)
    {
        
    }
    func APNNotExist(data: String) {
        apn_status="noapn"
    }
    
    func statusprint(flag: Int, email_id: String)
    {
        if(flag==0)
        {
            let alert = UIAlertController(title: "Sorry", message: "This email is not registered with us!! Please enter valid email", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        if(flag==1)
        {
            
            let alert = UIAlertController(title: "Thank you", message: "You can view your jobs now!!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                self.performSegue(withIdentifier: "showDecideView", sender: self)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="showDecideView")
        {
        let destvc = segue.destination as! DecideViewController
        destvc.id = email_id
        }
    }
    
    
    func checkingEmailExistance(email_status: String, email_id: String)
    {
        print("email status1 \(email_status)")
        if email_status == "noemail"
        {
            print("entered to check email")
            flag=0
            statusprint(flag: flag!, email_id: "noid")
        }
        else
        {
            print("email id\(email_id)")
 
            if email_id != nil && appletoken != nil
            {
                print("entered succeeded")
                dataModel.insertItems(id: email_id,token: appletoken!)
                print("succeeded")
                flag=1
                statusprint(flag: flag!, email_id: email_id)
            }
        }
    }
}

