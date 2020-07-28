//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//  

import SwiftUI

struct BackSplash: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color(ThemeManager.shared.theme?.viewGradientTopColor ?? UIColor.systemBlue), Color(ThemeManager.shared.theme?.viewGradientBottomColor ?? UIColor.systemBlue)]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackSplash_Previews: PreviewProvider {
    static var previews: some View {
        BackSplash()
    }
}
