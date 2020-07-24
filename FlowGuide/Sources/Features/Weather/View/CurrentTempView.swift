//
//  CurrentTempView.swift
//  CombinePOC
//
//  Created by Talish George on 22/07/20.
//  Copyright © 2020 1276121. All rights reserved.
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
                VStack{
                    Text(forecastViewModel.windSpeed)
                        .bold()
                        .foregroundColor(Color("secondary"))
                    Text("Wind")
                        .foregroundColor(Color("secondary"))
                }
                
                VStack{
                    Text(String((forecastViewModel.humidity)))
                        .bold()
                        .foregroundColor(Color("secondary"))
                    Text("Humidity")
                        .foregroundColor(Color("secondary"))
                }
                
                VStack{
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

//struct CurrentTempView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentTempView(forecastViewModel: <#ForecastViewModel#>)
//    }
//}
