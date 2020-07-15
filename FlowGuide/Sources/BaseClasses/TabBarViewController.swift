//
//  TabBarViewController.swift
//  FlowGuide
//
//  Created by TCS on 01/07/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       configureUI()
    }
    func configureUI() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontType.avenirNextCondensed.rawValue, size: CGFloat(FontSize.tabBarFontSize.rawValue)) ?? UIFont.systemFont(ofSize: CGFloat(FontSize.tabBarFontSize.rawValue), weight: UIFont.Weight.light)], for: .normal)
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightText
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
