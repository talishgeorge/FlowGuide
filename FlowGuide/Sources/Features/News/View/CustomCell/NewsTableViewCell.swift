//
//  NewsTableViewCell.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

/// News TableView Cell
class NewsTableViewCell: UITableViewCell, TableViewCellProtocol {
    
     // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var headlineImageView: UIImageView!
    
   // MARK: - Initilization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Update Cell UI Elements
    /// - Parameter vm: Generic Type
    func updateUI<T>(value vm: T) {
        guard let news = vm as? ArticleViewModel else { return }
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        news.image { (img) in
            self.headlineImageView.image = img
        }
    }
}
