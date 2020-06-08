//
//  PresenterManager.swift
//  FlowGuide
//
//  Created by Talish George on 22/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func saveCustomDict<T>(withKey key: String, dict: [AnyHashable: Any], type: T.Type) {
        guard let dict = dict as? T else {
            print("Type mismatch")
            return
        }
        let archiver = NSKeyedArchiver.archivedData(withRootObject: dict)
        UserDefaults.standard.set(archiver, forKey: key)
    }

    static func saveCustomObject(withKey key: String, custObj: AnyObject?) {
        guard let obj = custObj else {
            return
        }
        let archiver = NSKeyedArchiver.archivedData(withRootObject: obj)
        UserDefaults.standard.set(archiver, forKey: key)
    }
    
    static func getObject<T>(withKey key: String, type: T.Type) -> T? {
        let unarchivedObject = getDefaultData(withKey: key)
        return unarchivedObject as? T
    }

    static func getDefaultData(withKey key: String) -> Any? {
        guard let data = UserDefaults.standard.object(forKey: key) else {
            return nil
        }
        guard let retrievedData = data as? Data else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: retrievedData)
    }
}
