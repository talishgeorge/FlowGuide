//
//  BottomScrollForeCast.swift
//  CombinePOC
//
//  Created by Talish George on 22/07/20.
//  Copyright © 2020 1276121. All rights reserved.
//

import SwiftUI

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
                        .foregroundColor(Color("gradient2")))
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
//
//struct BottomScrollForeCast_Previews: PreviewProvider {
//    static var previews: some View {
//        BottomScrollForeCast()
//    }
//}



