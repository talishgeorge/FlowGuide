//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import SwiftUI
import Combine
import UtilitiesLib

struct ContentView: View {
    
    @ObservedObject var forcastViewModel: ForecastViewModel
    @State var showAlert = false
    @State var showView = false
    init(forcastViewModel: ForecastViewModel) {
        self.forcastViewModel = forcastViewModel
    }
    var body: some View {
        ZStack {
            BackSplash()
            VStack {
                TopView(showField: self.showView, forcastViewModel: self.forcastViewModel)
                MidView(forcastViewModel: self.forcastViewModel)
            }
            VStack(alignment: .center, spacing: 8) {
                Image(systemName: Helper().showWeatherIcon(item: forcastViewModel.weatherForCast.weather?.first?.main ?? ""))
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.white)
                CurrentTempView(forecastViewModel: forcastViewModel)
                Text("7 Day Weather Forecast")
                    .foregroundColor(.white)
                    .bold()
                    .padding(.all, 20)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0 ..< 7) { _ in
                            BottomScrollForeCast(forecastViewModel: self.forcastViewModel)
                        }
                    }
                }
            }
        }
    }
}
