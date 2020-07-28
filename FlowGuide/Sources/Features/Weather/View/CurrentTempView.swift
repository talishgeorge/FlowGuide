//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import SwiftUI

struct CurrentTempView: View {
    @ObservedObject var forecastViewModel: ForecastViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(forecastViewModel.temperature)
                    .font(.system(size:40))
                    .foregroundColor(.white)
                    .bold()
                
                Text(forecastViewModel.weatherDescription)
                    .foregroundColor(.white)
            }
            
            HStack(spacing: 6) {
                VStack {
                    Text(forecastViewModel.windSpeed)
                        .bold()
                        .foregroundColor(Color("secondary"))
                    Text("Wind")
                        .foregroundColor(Color("secondary"))
                }
                
                VStack {
                    Text(String((forecastViewModel.humidity)))
                        .bold()
                        .foregroundColor(Color("secondary"))
                    Text("Humidity")
                        .foregroundColor(Color("secondary"))
                }
                
                VStack {
                    Text(String(forecastViewModel.tempMax))
                        .bold()
                        .foregroundColor(Color("secondary"))
                    Text("Max")
                        .foregroundColor(Color("secondary"))
                }
            }
            
        }
    }
}
