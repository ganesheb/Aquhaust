//
//  GoalViewController.swift
//  WaterIntakeTracker
//
//  Created by Ganesh Ekatata Buana on 28/04/22.
//

import UIKit

class GoalViewController: UIViewController, UITextViewDelegate {

    @IBAction func tapKeypad(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var goalText: UILabel!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    @IBAction func setAge(_ sender: Any) {
        ageField.placeholder = ageField.text
        
        guard let age = ageField.placeholder else {
            return
        }

        guard let ageInt = Int(age) else {
            return
        }
       
        UserDefaults.standard.setValue(ageInt, forKey: "age")
        
        let savedAge = UserDefaults.standard.integer(forKey: "age")
        
        var savedWeight = UserDefaults.standard.integer(forKey: "weight")
        
        if savedAge < 30 {
            savedWeight *= 40
        }
        else if savedAge > 29 && savedAge < 56 {
            savedWeight *= 35
        }
        else {
            savedWeight *= 30
        }
        
        let intakeGoal = savedWeight * 1000 / 957
//        If you’re younger than 30, multiply by 40.
//        If you’re 30–55 years old, multiply by 35.
//        If you’re older than 55, multiply by 30.
        
        
        UserDefaults.standard.setValue(intakeGoal, forKey: "goal")
        
        goalText.text = (UserDefaults.standard.string(forKey: "goal") ?? "2000") + "ml"
        
    }
    
    @IBAction func setWeight(_ sender: Any) {
        weightField.placeholder = weightField.text
        
        guard let weight = weightField.placeholder else {
            return
        }

        guard let weightInt = Int(weight) else {
            return
        }
       
        UserDefaults.standard.setValue(weightInt, forKey: "weight")
        
        let savedAge = UserDefaults.standard.integer(forKey: "age")
        
        var savedWeight = UserDefaults.standard.integer(forKey: "weight")
        
        if savedAge < 30 {
            savedWeight *= 40
        }
        else if savedAge > 29 && savedAge < 56 {
            savedWeight *= 35
        }
        else {
            savedWeight *= 30
        }
        
        let intakeGoal = savedWeight * 1000 / 957
//        If you’re younger than 30, multiply by 40.
//        If you’re 30–55 years old, multiply by 35.
//        If you’re older than 55, multiply by 30.
        
        
        UserDefaults.standard.setValue(intakeGoal, forKey: "goal")
        
        goalText.text = (UserDefaults.standard.string(forKey: "goal") ?? "2000") + "ml"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        goalText.text = (UserDefaults.standard.string(forKey: "goal") ?? "2000") + "ml"
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }

}
