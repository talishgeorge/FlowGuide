//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import Foundation

extension String {
    public func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
         NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
}

extension String {
    enum Global: String, Localizable {
        case cancel
        case ok
        var tableName: String {
             "Localizable"
        }
    }
}
