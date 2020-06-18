//
//  NewsDetailsViewController.swift
//  FlowGuide
//
//  Created by Vinod Radhakrishnan on 21/05/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

/// News Details ViewController
class NewsDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var webview: WKWebView!
    private var newsDetailsVM: NewsDetailsViewModel!
    var article: Article!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: view, animated: true)
        setupUI()
    }
    
    /// Update UI
    func updateUI() {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
}

private extension NewsDetailsViewController {
    
    /// Initial UI Setup
    func setupUI() {
        self.newsDetailsVM = NewsDetailsViewModel(article)
        self.navigationItem.largeTitleDisplayMode = .never
        self.title = self.newsDetailsVM.sourceName
        guard let url = self.newsDetailsVM.url,
            let newsDetailURL = URL(string: url) else {
                return
        }
        let request = URLRequest(url: newsDetailURL)
        self.webview.navigationDelegate = self
        self.webview.load(request)
    }
}

extension NewsDetailsViewController: WKNavigationDelegate {
    
    /// WebView Delegate
    /// - Parameters:
    ///   - webView: Start Loading
    ///   - navigation:
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }
    
    /// WebView Delegate
    /// - Parameters:
    ///   - webView: Finish Loading
    ///   - navigation: 
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
