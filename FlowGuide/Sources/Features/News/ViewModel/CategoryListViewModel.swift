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

final class CategoryListViewModel {
    weak var delegate: NewsViewControllerDelegate?
    private(set) var categories: [Category] = []
    private let newsService: WebService = WebService()
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
//        newsService.getNewsData(category: category, success: { news in
//            closureSelf.categories = news
//            closureSelf.delegate?.loadData()
//        }, failure: { error in
//            closureSelf.delegate?.showError(error: error)
//        })
        
        newsService.getNews(category: category) { result in
            var categories = [Category]()
            switch result {
            case Result.success(let response):
                print("Success\(result)")
                let category = Category(title: "General", articles: response.articles)
                categories.append(category)
                closureSelf.categories = categories
                DispatchQueue.main.async {
                    closureSelf.delegate?.loadData()
                }
            case Result.failure(let error):
                print("Failure")
            }
        }
    }
    
    /// Show offline data
    func showOfflineData() {
        self.delegate?.loadData()
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
