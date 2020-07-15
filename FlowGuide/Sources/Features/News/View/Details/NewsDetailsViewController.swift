//
//  NewsDetailsViewController.swift
//  FlowGuide
//
//  Created by TCS on 21/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

/// News Details ViewController
final class NewsDetailsViewController: BaseViewController {
 
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var webview: WKWebView!
    var newsDetailsVM: NewsDetailsViewModel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: view, animated: true)
        setupUI()
    }
    
    /// Update UI with Values
    func updateUI() {
        titleLabel.text = newsDetailsVM.article.title
        descriptionLabel.text = newsDetailsVM.article.description
    }
}

private extension NewsDetailsViewController {
    
    /// Initial UI Setup
    func setupUI() {
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
