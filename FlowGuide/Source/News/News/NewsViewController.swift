//
//  NewsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableViewOutlet: UITableView!
    //    @IBOutlet private weak var newsTableViewOutlet: UITableView!
    
    var tableViewDataSource:[TableViewProtocol] = []
    var selectedCell = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let headerNib = UINib.init(nibName: K.CellIdentifiers.newsHeaderCell, bundle: Bundle.main)
                newsTableViewOutlet.register(headerNib, forHeaderFooterViewReuseIdentifier: K.CellIdentifiers.newsHeaderCell)
        newsTableViewOutlet.register(UINib(nibName: K.CellIdentifiers.newsCell, bundle: nil), forCellReuseIdentifier: K.CellIdentifiers.newsCell)
        tableViewDataSource = NewsFeedData.newsFeeds
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
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = tableViewDataSource[section]
        return section.numberOfRowsInSection()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = tableViewDataSource[indexPath.section]
        return list.getCellForRow(tableView: tableView, delegate: self, indexPath: indexPath)
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableViewDataSource[section]
        return header.getHeader(tableView: tableView, delegate: self, section: section)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath
        performSegue(withIdentifier: K.Segue.showNewsDetail, sender: self)
    }
}
