//
//  MidView.swift
//  WeatherForecast
//
//  Created by Talish George on 22/07/20.
//  Copyright © 2020 1276121. All rights reserved.
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
            .frame(width:400)
    }
}

struct MidView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
