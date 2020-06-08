//
//  NewsDetailsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class NewsDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    var news = Article()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
    }
}

