//
//  CategoryListViewModel.swift
//  FlowGuide
//
//  Created by TCS on 07/06/20.
//  Copyright © 2020 TCS. All rights reserved.
//
import Foundation
import UIKit

/// Category List Model
/// Protocol
protocol CategoryListViewModelDelegate: class {
    func categoryListViewModelDidStartRefresh(_ viewModel: CategoryListViewModel)
    func categoryListViewModel(_ viewModel: CategoryListViewModel, didFinishWithError error: Error?)
}

final class CategoryListViewModel: BaseViewModel {
    weak var delegate: CategoryListViewModelDelegate?
    private(set) var categories: [Category] = []
}

// MARK: - Internal Methods for TableView

extension CategoryListViewModel {
    
    /// Return Number of Sections for UITableView
    var numberOfSections: Int {
        categories.count
    }
    
    /// Return Number of Rows in Sections for UITableView
    /// - Parameter section: Int Value
    func numberOfRowsInSection(_ section: Int) -> Int {
        categories[section].articles.count
    }
}

// MARK: - Internal Methods

extension CategoryListViewModel {
    
    /// Return Category ViewModel
    /// - Parameter index: Int Value
    func categoryAtIndex(index: Int) -> CategoryViewModel {
        CategoryViewModel(name: categories[index].title, articles: categories[index].articles)
    }
    
    /// Return Article For Section
    /// - Parameters:
    ///   - section: Int Value
    ///   - index: Int Value
    func articleForSectionAtIndex(section: Int, index: Int) -> ArticleViewModel {
        categoryAtIndex(index: section).articleAtIndex(index)
    }
    
    /// Fetch News
    /// - Parameter category: String
    func fetchNews(by category: String) {
        let closureSelf = self
        webService.getNews(category: category) { result in
            var categories = [Category]()
            switch result {
            case Result.success(let response):
                let category = Category(title: "General", articles: response.articles)
                categories.append(category)
                closureSelf.categories = categories
                DispatchQueue.main.async {
                    closureSelf.delegate?.categoryListViewModelDidStartRefresh(self)
                }
            case Result.failure(let error):
                DispatchQueue.main.async {
                    closureSelf.delegate?.categoryListViewModel(self, didFinishWithError: error)
                }
            }
        }
    }
    
    /// Show offline data
    func showOfflineData() {
        categories = Category.loadLocalData()
        self.delegate?.categoryListViewModelDidStartRefresh(self)
    }
}

/// Category view model
struct CategoryViewModel {
    let name: String
    let articles: [Article]
}

extension CategoryViewModel {
    
    /// Return Article View Model
    /// - Parameter index:Int Value
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}
