//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import FirebaseAuth

final class Authservice {
    
    let auth = Auth.auth()
    
    /// Return isUser Loggedin as Bool
    func isUserLoggedIn() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    /// Logout User from Firebase with return type success and failure
    func logoutUser() -> Result<Void, Error> {
        do {
            try Auth.auth().signOut()
            return .success(())
        } catch let error {
            return .failure(error)
        }
    }
}
