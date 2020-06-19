//
//  SDKInitializationService.swift
//  FlowGuide
//
//  Created by Talish George on 19/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import Split

class SDKInitializationService {
    
    static let shared = SDKInitializationService()
    let apiKey: String = "vog4cgfglueelkiherg7a169p09p673fsldh"
    let key: Key = Key(matchingKey: "CUSTOMER_ID")
    let config = SplitClientConfig()
    let builder = DefaultSplitFactoryBuilder()
    var featureFlag: Bool? = false
    
    func initializeSplitSDK() {
        let factory = builder.setApiKey(apiKey).setKey(key).setConfig(config).build()
        let client = factory?.client
        client?.on(event: SplitEvent.sdkReady) {
            let treatment = client?.getTreatment("News_Details_Screen")
            self.featureFlag = (treatment == "on") ? true : false
            print(self.featureFlag)
        }
        client?.on(event: SplitEvent.sdkReadyTimedOut) {
            print("SDK time out")
        }
    }
}
