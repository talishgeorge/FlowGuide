//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation
import UIKit
import Combine

class BaseCoordinator {
    
    init(navController: UINavigationController, window: UIWindow) {
        self.navController = navController
        self.window = window
    }
    
    let navController: UINavigationController
    let window: UIWindow
    var childCoordinators: [Coordinator] = []
    var subscriptions = Set<AnyCancellable>()
}
