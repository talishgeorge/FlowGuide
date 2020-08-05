//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit

extension UIStoryboard {
    
    // MARK: - Storyboards
    private static var main: UIStoryboard {
        return UIStoryboard(name: Constants.StoryBoardID.main, bundle: nil)
    }
    
    // MARK: - View Controllers
    static func instantiateLoadingViewController() -> LoadingViewController {
        let loadingVC = main.instantiateViewController(withIdentifier: Constants.StoryBoardID.loadingViewController) as! LoadingViewController
        return loadingVC
    }
    
    static func instantiateOnBoardingViewController() -> OnBoardingViewController {
        let onBoardingVC = main.instantiateViewController(withIdentifier: Constants.StoryBoardID.onBoardingViewController) as! OnBoardingViewController
        return onBoardingVC
    }
    
    static func instantiateTabBarController() -> UIViewController {
        main.instantiateViewController(withIdentifier: Constants.StoryBoardID.mainTabBarController)
    }
}
