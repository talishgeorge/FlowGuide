//
//  BackSplash.swift
//  WeatherForecast
//
//  Created by 1276121 on 13/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import SwiftUI

struct BackSplash: View {
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color("lightPink"), Color("lightBlue")]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackSplash_Previews: PreviewProvider {
    static var previews: some View {
        BackSplash()
    }
}
