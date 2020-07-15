//
//  NewsViewController+LoadData.swift
//  FlowGuide
//
//  Created by TCS on 09/07/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import MBProgressHUD

extension NewsViewController: NewsViewControllerDelegate {
    
    /// Show list of live news and details
    /// - Parameter vm: Category List ViewModel
    func loadData() {
        
        self.tableView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    /// ShowError
    /// - Parameter error: Error
    func showError(error: Error?) {
        guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
            self.presentAlertWithTitle(title: String.News.newsFecthError.localized, message: String.News.newsFetchErrorMessage.localized, options: String.Global.ok.localized, String.Global.cancel.localized) { (value) in
                if value == 0 {
                    self.categoryListVM.showOfflineData()
                }
            }
            return
        }
    }
}
