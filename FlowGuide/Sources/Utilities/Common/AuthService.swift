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
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                let window = sceneDelegate.window {
                window.rootViewController = UIStoryboard.instantiateOnBoardingViewController()
                UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
            return .success(())
        } catch let error {
            return .failure(error)
        }
    }
}
