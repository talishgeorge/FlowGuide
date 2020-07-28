//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import SwiftUI

struct MidView: View {
    
    @ObservedObject var forcastViewModel: ForecastViewModel
    var body: some View {
        VStack {
            VStack {
                Text("\(forcastViewModel.currentCity), \(forcastViewModel.currentCountry)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.light)
                Text(forcastViewModel.weatherDay)
                    .foregroundColor(.white)
                    .font(.system(size:15))
                .bold()
            }
            Spacer()
        }.padding(.trailing, 200)
            .frame(width: 400)
    }
}
