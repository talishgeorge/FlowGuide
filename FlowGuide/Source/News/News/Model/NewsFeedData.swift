//
//  NewsFeedData.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

struct NewsFeedData {
    static let newsFeeds: [TableViewProtocol] = [
        News.newsList(newsType: NewsType.international.rawValue, news:[(title:"Venezuela's military to escort Iranian tankers bringing petrol", description:"The Venezuelan military will escort Iranian tankers delivering much-needed petrol to the country to prevent any attempt by the US to stop them."),(title:"African countries urged to up Covid-19 testing tenfold", description:"Africa's number of virus cases is above 95,000 and could surpass 100,000 by the weekend. The continent has seen roughly the same number of new cases in the past week as the week before, and Nkengasong says that “we hope that trend continues.” While early lockdowns delayed the pandemic, he says “that doesn't mean Africa has been spared.” But he says health officials are not seeing a lot of community deaths or “massive flooding of our hospitals” because of COVID-19.")]),
        News.newsList(newsType: NewsType.sports.rawValue, news:[(title:"English Football League: Promotion and relegation to remain if seasons curtailed", description:"If the season is brought to an early conclusion, using the unweighted points-per-game system proposed by the EFL eighth-placed Wycombe Wanderers would move into the play-offs at the expense of Peterborough United - another of the sides determined to carry on playing."),(title:"The FA Cup's 50 Greatest Moments", description:"Every football fan will have their own memories of the FA Cup - the greatest knockout tournament in the world.")]),
        News.newsList(newsType: NewsType.politics.rawValue, news:[(title:"FM's covid stimulus package: Personal finance relief measures 19 May 2020, 2:15PM IST", description:"Liquidity, labour, land and law -- these were the four main areas that the government’s economic relief package focused on."),(title:"PM Modi to address the nation at 8 PM 12 May 2020, 1:00PM IST", description:"Prime Minister Narendra Modi will address the nation today at 8 pm, amid speculations about lockdown 4.0. PM Modi's address comes a day")]),
        News.newsList(newsType: NewsType.domestic.rawValue, news:[(title:"Swiggy, Zomato To Home Deliver Alcohol, Will Start With This City", description:"The top two food-delivery startups, Swiggy and Zomato, will begin delivering alcohol in some cities starting from today, as they cash in on the high demand for booze during the country's coronavirus lockdown."),(title:"72 Dead In Cyclone Amphan, Says Mamata Banerjee: 10 Points", description:"72 people have died in Bengal because of Cyclone Amphan, Chief Minister Mamata Banerjee said today after the powerful storm wrecked cities including Kolkata on Wednesday, destroying thousands of homes and uprooting trees and electric poles. The chief minister said the damage caused by Amphan is more than the coronavirus pandemic and has asked Prime Minister Narendra Modi to visit the affected districts and provide help to rebuild those areas from scratch")]),
        
        
        
    ]
}
