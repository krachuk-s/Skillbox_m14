//
//  UserData.swift
//  Skillbox_m14
//
//  Created by Kravchuk Sergey on 31.10.2019.
//  Copyright © 2019 Kravchuk Sergey. All rights reserved.
//

import Foundation

struct UserData {
    var name: String
    var familyName: String
    
    static var current: UserData? {
        get {
            if let name = UserDefaults.standard.string(forKey: nameKey),
                let familyName = UserDefaults.standard.string(forKey: familyNameKey) {
                return UserData(name: name, familyName: familyName)
            } else {
                return nil
            }
        }
        set {
            UserDefaults.standard.set(newValue?.name, forKey: nameKey)
            UserDefaults.standard.set(newValue?.familyName, forKey: familyNameKey)
        }
    }
    
    static let nameKey = "UserData.name"
    static let familyNameKey = "UserData.familyName"
    
}
