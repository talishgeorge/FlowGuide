//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import UIKit

final class LoginCoordinator: Coordinator {
    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let loginVC = UIStoryboard.instantiateLoginViewController()
        navController.setViewControllers([loginVC], animated: true)
    }
}
