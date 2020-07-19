//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

extension UILabel {
    @objc func updateTextAttributes(_ newAttributes: [NSAttributedString.Key: Any]) {
        guard let text = self.attributedText else { return }
        
        self.attributedText = NSAttributedString(
            attributedString: text,
            merging: newAttributes
        )
    }
}
