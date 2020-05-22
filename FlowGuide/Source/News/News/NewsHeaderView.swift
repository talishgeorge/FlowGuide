//
//  NewsHeader.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class NewsHeaderView: UITableViewHeaderFooterView,TableViewCellProtocol {
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    func updateUI<T>(value: T) {
        guard let title = value as? String else { return }
        titleLabel.text = title
    }
}
