//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import SwiftUI
import UtilitiesLib

struct BottomScrollForeCast: View {
    
    @ObservedObject var forecastViewModel: ForecastViewModel
    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                Text(String(Helper().timeConverter(timeStamp: forecastViewModel.date, isDay: true)))
                    .foregroundColor(Color("icons"))
            }.offset(y: -75)
            HStack {
                Image(systemName: Helper().showWeatherIcon(item: forecastViewModel.weatherForCast.weather?.first?.main ?? ""))
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color("secondary"))
                    .background(RoundedRectangle(cornerRadius: 60)
                        .frame(width: 90, height: 80)
                        .foregroundColor(Color(ThemeManager.shared.theme?.viewGradientTopColor ?? UIColor.systemBlue)))
                    .padding(.all, 20)
                    .offset(x: -20)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(forecastViewModel.tempMax)
                            .foregroundColor(.gray)
                        Image(systemName: "arrow.down")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                    HStack {
                        Text(forecastViewModel.tempMax)
                            .foregroundColor(.gray)
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                    Text("Hum: \(forecastViewModel.humidity)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Text("Win: \(forecastViewModel.windSpeed)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                Spacer()
            }
        }.frame(width: 220, height: 200)
            .background(Color.white)
            .cornerRadius(30)
            .padding(.leading, 15)
    }
}
