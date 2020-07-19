//
//  ThemeManager.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import Foundation
import UIKit

public let themeUpdateNotification = "ThemeUpdateNotification"

public enum ThemePath {
    
    case mainBundle
    case sandbox(Foundation.URL)
    
    public var URL: Foundation.URL? {
        switch self {
        case .mainBundle        : return nil
        case .sandbox(let path) : return path
        }
    }
    
    public func plistPath(name: String) -> String? {
        return filePath(name: name, ofType: "plist")
    }
    
    public func jsonPath(name: String) -> String? {
        return filePath(name: name, ofType: "json")
    }
    
    private func filePath(name: String, ofType type: String) -> String? {
        switch self {
        case .mainBundle:
            return Bundle.main.path(forResource: name, ofType: type)
        case .sandbox(let path):
            let name = name.hasSuffix(".\(type)") ? name : "\(name).\(type)"
            let url = path.appendingPathComponent(name)
            return url.path
        }
    }
}

public final class FBThemeManager {
    
    static public let shared = FBThemeManager()
    public var animationDuration = 0.3
    public private(set) var currentTheme: NSDictionary?
    public private(set) var currentThemeIndex: Int = 0
    public private(set) var currentThemePath: ThemePath?
    public var current = AppThemes.red
    public var before  = AppThemes.red
    public enum AppThemes: Int {
        case red
        case yello
        case night
    }
}

public extension FBThemeManager {
    
    @objc  func setTheme(index: Int) {
        currentThemeIndex = index
        NotificationCenter.default.post(name: Notification.Name(rawValue: themeUpdateNotification), object: nil)
    }
    
    func setTheme(plistName: String, path: ThemePath) {
        guard let plistPath = path.plistPath(name: plistName) else {
            print("SwiftTheme WARNING: Can't find plist '\(plistName)' at: \(path)")
            return
        }
        guard let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            print("SwiftTheme WARNING: Can't read plist '\(plistName)' at: \(plistPath)")
            return
        }
        self.setTheme(dict: plistDict, path: path)
    }
    
    func setTheme(jsonName: String, path: ThemePath) {
        guard let jsonPath = path.jsonPath(name: jsonName) else {
            print("SwiftTheme WARNING: Can't find json '\(jsonName)' at: \(path)")
            return
        }
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
                print("SwiftTheme WARNING: Can't read json '\(jsonName)' at: \(jsonPath)")
                return
        }
        self.setTheme(dict: jsonDict, path: path)
    }
    
    func setTheme(dict: NSDictionary, path: ThemePath) {
        currentTheme = dict
        currentThemePath = path
        NotificationCenter.default.post(name: Notification.Name(rawValue: themeUpdateNotification), object: nil)
    }
    
    func textColor() -> UIColor {
        let hexString = currentTheme?.value(forKeyPath: "Global.textColor") as? String ?? ""
        return UIColor.init(hexString: hexString, alpha: 1.0)
    }
    
    /// Initial NavigationBar setup
    func setup() {
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 47/255, green: 54/255, blue: 64/255, alpha: 1.0)
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font: UIFont.navigationAttributes]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key: Any], for: .normal)
    }
    
    func switchTo(_ theme: AppThemes) {
        before  = current
        current = theme
        switch theme {
        case .red   : setTheme(jsonName: "Red", path: .mainBundle)
        case .yello : setTheme(jsonName: "Yellow", path: .mainBundle)
        case .night : setTheme(jsonName: "Night", path: .mainBundle)
        }
    }
    
    func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : before)
    }
    
    func isNight() -> Bool {
        return current == .night
    }
}
