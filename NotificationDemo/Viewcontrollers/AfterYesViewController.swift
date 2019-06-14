//
//  AfterYesViewController.swift
//  NotificationDemo
//
//  Created by Shiva Vandana on 9/12/17.
//  Copyright © 2017 Shiva Vandana. All rights reserved.
//

import UIKit

class AfterYesViewController: UIViewController,UITextViewDelegate {
    var jobid: String?
    let dataModel = CheckEmail()
    @IBAction func submit(_ sender: Any) {
        if(message.text=="")
        {
           message.text=="nothing"
        }
        let confirmed_From="Confirmed from App";
        let encodedSubject = message.text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let encodedSubject1 = confirmed_From.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)

        dataModel.YesStatus(jobid: jobid!,confirmed_from: encodedSubject1!,job_notes:encodedSubject!)
        let alert = UIAlertController(title: "Thank you!!", message: "Your work status is recorded in our database!!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet var labelcodes: UITextView!
    @IBOutlet var message: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        labelcodes.translatesAutoresizingMaskIntoConstraints = false
        labelcodes.isScrollEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
