//
//  NewsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import FirebaseAuth

class NewsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var newsTableViewOutlet: UITableView!
    
    var tableViewDataSource:[TableViewProtocol] = []
    var selectedCell = IndexPath()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let headerNib = UINib.init(nibName: K.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
        newsTableViewOutlet.register(headerNib, forHeaderFooterViewReuseIdentifier: K.CellIdentifiers.newsHeaderCell)
        
        //        newsTableViewOutlet.register(UINib(nibName: K.CellIdentifiers.newsCell, bundle: nil), forCellReuseIdentifier: K.CellIdentifiers.newsCell)
        
        tableViewDataSource = NewsFeedData.newsFeeds
        
        self.title = K.NavigationTitle.home
        
        if let email = Auth.auth().currentUser?.email {
            userNameLabel.text = "Logged in - \(email)"
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is NewsDetailsViewController
        {
            let vc = segue.destination as? NewsDetailsViewController
            let section = tableViewDataSource[selectedCell.section]
            guard let value =  section.getSelectedCell(indexPath: selectedCell) as? newsInfo else {
                return
            }
            vc?.news = value
        }
    }
}
