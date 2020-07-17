//
//  NewsViewController+LoadData.swift
//  FlowGuide
//
//  Created by TCS on 09/07/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation
import OakLib

extension NewsViewController: CategoryListViewModelDelegate {
    
    func service(_ viewModel: CategoryListViewModel, didFinishWithError error: Error?) {
        guard let errorDescription = error?.localizedDescription, !errorDescription.isEmpty else {
            return
        }
        self.presentAlertWithTitle(title: String.News.newsFecthError.localized, message: String.News.newsFetchErrorMessage.localized, options: String.Global.ok.localized, String.Global.cancel.localized) { (value) in
            if value == 0 {
                self.categoryListVM.showOfflineData()
            }
        }
    }
    
    func serviceStartUpdating(_ viewModel: CategoryListViewModel) {
        self.tableView.reloadData()
        ActivityIndicator.dismiss()
    }
}
