//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

extension UITextField {
    @objc func updatePlaceholderAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let placeholder = self.attributedPlaceholder else { return }
        let newString = NSAttributedString(attributedString: placeholder,
                                           merging: newAttributes)
        self.attributedPlaceholder = newString
    }
}
