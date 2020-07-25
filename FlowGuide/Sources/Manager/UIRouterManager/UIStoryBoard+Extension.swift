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
    
    // MARK: - View Controllers
    static func instantiateLoadingViewController(delegate: LoadingViewControllerDelegate) -> LoadingViewController {
        let loadingVC = main.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        loadingVC.delegate = delegate
        return loadingVC
    }
    
    static func instantiateOnBoardingViewController(delegate: OnBoardingDelegate) -> OnBoardingViewController {
        let onBoardingVC = main.instantiateViewController(withIdentifier: "OnBoardingViewController") as! OnBoardingViewController
        onBoardingVC.delegate = delegate
        return onBoardingVC
    }
}
