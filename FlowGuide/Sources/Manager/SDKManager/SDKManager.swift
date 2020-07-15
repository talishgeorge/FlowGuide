//
//  SDKInitializationService.swift
//  FlowGuide
//
//  Created by TCS on 19/06/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import Split
import Firebase
import UtilitiesLib

final class SDKManager {
 
    static public let shared = SDKManager()
    let apiKey: String = SplitAPI.apiKey
    let key: Key = Key(matchingKey: SplitAPI.customerID)
    let config = SplitClientConfig()
    let builder = DefaultSplitFactoryBuilder()
    var featureFlag: Bool? = false
    
    // MARK: - internal Methods
    
    /// Initilize Split IO SDK
    func initializeSplitIOSDK() {
        let factory = builder.setApiKey(apiKey).setKey(key).setConfig(config).build()
        let client = factory?.client
        client?.on(event: SplitEvent.sdkReady) {
            let treatment = client?.getTreatment(String.News.newsDetailsFeature.localized)
            self.featureFlag = (treatment == String.News.on.localized) ? true : false
        }
        client?.on(event: SplitEvent.sdkReadyTimedOut) {
        }
    }
    
    /// Initilize Firebase SDK
    func initilizeFirebaseSDK() {
        FirebaseApp.configure()
    }
    
    /// Initilize ThemeManager
    func initilizeThemeManager() {
        ThemeManager.setup()
    }    
}
