//
//  CategoryListViewModel.swift
//  FlowGuide
//
//  Created by Talish George on 07/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//
import Foundation
import UIKit

/// Category List Model
struct CategoryListViewModel {
    
    // MARK: - Properties
    
    private(set) var categories: [Category] = []
    weak var delegate: NewsViewControllerDelegate?
    var newsService: WebService = WebService()
}

extension CategoryListViewModel {
    
    /// Return Number of Sections for UITableView
    var numberOfSections: Int {
        return self.categories.count
    }
    
    /// Return Number of Rows in Sections for UITableView
    /// - Parameter section: Int Value
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.categories[section].articles.count
    }
}

extension CategoryListViewModel {
    
    /// Return Category ViewModel
    /// - Parameter index: Int Value
    func categoryAtIndex(index: Int) -> CategoryViewModel {
        return CategoryViewModel(name: categories[index].title, articles: categories[index].articles)
    }
    
    /// Return Article For Section
    /// - Parameters:
    ///   - section: Int Value
    ///   - index: Int Value
    func articleForSectionAtIndex(section: Int, index: Int) -> ArticleViewModel {
        return categoryAtIndex(index: section).articleAtIndex(index)
    }
    
    /// Fetch News
    /// - Parameter category: String
    func fetchNews(by category: String) {
        self.newsService.getNewsData(category: category, success: { news in
            self.delegate?.loadData(vm: CategoryListViewModel(categories: news))
        }, failure: { error in
            self.delegate?.showError(error: error)
        })
    }
    
    /// Show offline data
    func showOfflineData() {
        self.delegate?.loadData(vm: CategoryListViewModel(categories: Category.loadLocalData()))
    }
}

/// Category view model
struct CategoryViewModel {
    
    // MARK: - Properties
    
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
