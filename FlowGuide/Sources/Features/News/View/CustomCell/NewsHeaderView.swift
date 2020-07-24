//
//  NewsHeader.swift
//  FlowGuide
//
//  Created by TCS on 21/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import UtilitiesLib

/// News Header Class
final class NewsHeaderView: UITableViewHeaderFooterView, TableViewCellProtocol {

    @IBOutlet private weak var titleLabel: UILabel!
    
    /// UpdateUI
    /// - Parameter value: Generic Type
    func updateUI<T>(value: T) {
        contentView.backgroundColor = ThemeManager.shared.theme?.headerCellBgColor
        guard let title = value as? String else { return }
        titleLabel.text = title
    }
}
