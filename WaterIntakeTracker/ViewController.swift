//
//  ViewController.swift
//  WaterIntakeTracker
//
//  Created by Ganesh Ekatata Buana on 27/04/22.
//

import UIKit

extension UserDefaults {

    static let defaults = UserDefaults.standard

    static var lastAccessDate: Date? {
        get {
            return defaults.object(forKey: "lastAccessDate") as? Date
        }
        set {
            guard let newValue = newValue else { return }
            guard let lastAccessDate = lastAccessDate else {
                defaults.set(newValue, forKey: "lastAccessDate")
                return
            }
            if !Calendar.current.isDateInToday(lastAccessDate) {
                UserDefaults.standard.removeObject(forKey: "totalDrinkVolume")
            }
            defaults.set(newValue, forKey: "lastAccessDate")
        }
    }
}

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var volumeDrink: UITextField!
    
    @IBOutlet weak var dailyVolume: UILabel!
    
    @IBOutlet weak var dailyPercentage: UILabel!
    
    @IBOutlet weak var percentageBar: UIProgressView!
    
    @IBOutlet weak var goalStatus: UILabel!
    
    @IBAction func tapKeypad(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func drinkWater(_ sender: Any) {
        guard let volume = volumeDrink.text else {
            return
        }

        guard let volumeInt = Int(volume) else {
            return
        }
       
        var totalVolume = UserDefaults.standard.integer(forKey: "totalDrinkVolume")
        
        totalVolume += volumeInt
        
        UserDefaults.standard.setValue(totalVolume, forKey: "totalDrinkVolume")
        
       setDailyVolume()
        setPercentage()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        UserDefaults.lastAccessDate = Date()
        
        setDailyVolume()
        setPercentage()
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
    
    public func setDailyVolume(){
        dailyVolume.text = (UserDefaults.standard.string(forKey: "totalDrinkVolume") ?? "0") + " / " + (UserDefaults.standard.string(forKey: "goal") ?? "2000") + " ml"
    }
    
    public func setPercentage(){
        let totalVolume = UserDefaults.standard.string(forKey: "totalDrinkVolume") ?? "0"
        let dailyGoal = UserDefaults.standard.string(forKey: "goal") ?? "2000"
        guard let intTotalVolume = Int(totalVolume) else { return }
        guard let intDailyGoal = Int(dailyGoal) else { return  }
        
        var percentage = Int((Float(intTotalVolume)/Float(intDailyGoal))*100)
        
        if percentage > 100 {
            percentage = 100
        }
        
        if(intTotalVolume < intDailyGoal){
            let amountToGoal = intDailyGoal - intTotalVolume
            goalStatus.text = "You are " + String(amountToGoal) + " ml away from your goal."
            goalStatus.textColor = UIColor(red: 205/255, green: 48/255, blue: 39/255, alpha: 1.0)
        }
        else if(intTotalVolume > intDailyGoal){
            let amountAheadGoal = intTotalVolume - intDailyGoal
            goalStatus.text = "You are " + String(amountAheadGoal) + " ml ahead of your goal."
            goalStatus.textColor = UIColor(red: 32/255, green: 125/255, blue: 55/255, alpha: 1.0)
        }
        else{
            goalStatus.text = "You have reached your goal."
            goalStatus.textColor = UIColor(red: 32/255, green: 125/255, blue: 55/255, alpha: 1.0)
        }
        
        dailyPercentage.text = String(percentage) + "%"
        let floatPercentage = Float(percentage) / 100
        percentageBar.setProgress(floatPercentage, animated: true)
        
        if floatPercentage < 0.1 {
            percentageBar.tintColor = UIColor(red: 205/255, green: 50/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.2 {
            percentageBar.tintColor = UIColor(red: 205/255, green: 80/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.3 {
            percentageBar.tintColor = UIColor(red: 205/255, green: 110/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.4 {
            percentageBar.tintColor = UIColor(red: 205/255, green: 140/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.5 {
            percentageBar.tintColor = UIColor(red: 205/255, green: 170/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.6 {
            percentageBar.tintColor = UIColor(red: 197/255, green: 205/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.7 {
            percentageBar.tintColor = UIColor(red: 177/255, green: 205/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.8 {
            percentageBar.tintColor = UIColor(red: 155/255, green: 205/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.9 {
            percentageBar.tintColor = UIColor(red: 89/255, green: 205/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage < 0.99 {
            percentageBar.tintColor = UIColor(red: 116/255, green: 205/255, blue: 39/255, alpha: 1.0)
        }
        else if floatPercentage == 1 {
            percentageBar.tintColor = UIColor(red: 67/255, green: 121/255, blue: 245/255, alpha: 1.0)
        }
        
    }
    
    
}

