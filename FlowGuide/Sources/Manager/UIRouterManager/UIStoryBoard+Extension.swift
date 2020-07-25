//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit

extension UIStoryboard {
    
    // MARK: - Storyboards
    private static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    private static var login: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    // MARK: - View Controllers
    static func instantiateLoadingViewController() -> LoadingViewController {
        let loadingVC = main.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        return loadingVC
    }
    
    static func instantiateOnBoardingViewController() -> OnBoardingViewController {
        let onBoardingVC = main.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        return onBoardingVC
    }
    
    static func instantiateLoginViewController() -> LoginViewController {
        let loginVC = login.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
        return loginVC
    }
}
