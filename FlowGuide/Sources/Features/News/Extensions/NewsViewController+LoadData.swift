//
//  NewsViewController+LoadData.swift
//  FlowGuide
//
//  Created by Talish George on 09/07/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation
import MBProgressHUD

extension NewsViewController: NewsViewControllerDelegate {
    
    /// Show list of live news and details
    /// - Parameter vm: Category List ViewModel
    func loadData(vm: CategoryListViewModel) {
        self.categoryListVM = vm
        self.tableView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    /// ShowError
    /// - Parameter error: Error
    func showError(error: Error?) {
        guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
            self.presentAlertWithTitle(title: NewsLocalization.newsFecthError.localized, message: NewsLocalization.newsFetchErrorMessage.localized, options: NewsLocalization.ok.localized, NewsLocalization.cancel.localized) { (value) in
                if value == 0 {
                    self.categoryListVM.showOfflineData()
                }
            }
            return
        }
    }
}
