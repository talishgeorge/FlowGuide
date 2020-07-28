//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit

extension UIStoryboard {
    
    // MARK: - Storyboards
    private static var main: UIStoryboard {
        return UIStoryboard(name: AppConstants.StoryBoardID.main, bundle: nil)
    }
    
    // MARK: - View Controllers
    static func instantiateLoadingViewController() -> LoadingViewController {
        let loadingVC = main.instantiateViewController(withIdentifier: AppConstants.StoryBoardID.loadingViewController) as! LoadingViewController
        return loadingVC
    }
    
    static func instantiateOnBoardingViewController() -> OnBoardingViewController {
        let onBoardingVC = main.instantiateViewController(withIdentifier: AppConstants.StoryBoardID.onBoardingViewController) as! OnBoardingViewController
        return onBoardingVC
    }
    
    static func instantiateTabBarController() -> UIViewController {
        main.instantiateViewController(withIdentifier: AppConstants.StoryBoardID.mainTabBarController)
    }
}
