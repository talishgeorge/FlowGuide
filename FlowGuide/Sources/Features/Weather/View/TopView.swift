//
//  TopView.swift
//  WeatherForecast
//
//  Created by 1276121 on 19/12/2019.
//  Copyright © 2019 1276121. All rights reserved.
//

import SwiftUI

let UIWidth = UIScreen.main.bounds.width

struct TopView: View {
    @State var showField: Bool = false
    @ObservedObject var forcastViewModel: ForecastViewModel
    init(showField: Bool, forcastViewModel: ForecastViewModel) {
        self.forcastViewModel = forcastViewModel
        self.showField = showField
    }
    var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                TextField("Enter City Name", text: self.$forcastViewModel.cityName) {
                    self.forcastViewModel.searchCity()
                }.padding(.all, 10)
                    .frame(width: UIWidth - 50, height: 50)
                    .background(Color("lightBlue"))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .offset(x: self.showField ? 0 : (-UIWidth / 2 - 190), y: 10)
                    .animation(.spring())
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .offset(x: self.showField ? (UIWidth - 90) : -20, y: 10)
                    .animation(.spring())
                    .onTapGesture {
                        self.showField.toggle()
                }
            }.onAppear(perform: fetch)
        }
    }
    
    private func fetch() {
        forcastViewModel.searchCity()
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        BackSplash()
    }
}
