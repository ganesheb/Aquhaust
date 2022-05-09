//
//  ResetVariable.swift
//  WaterIntakeTracker
//
//  Created by Ganesh Ekatata Buana on 29/04/22.
//

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
                print("remove Persistent Domain")
                UserDefaults.reset()
            }
            defaults.set(newValue, forKey: "lastAccessDate")
        }
    }
}
