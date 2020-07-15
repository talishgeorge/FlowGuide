//
//  NewsDetailsViewController.swift
//  FlowGuide
//
//  Created by TCS on 21/05/20.
//  Copyright © 2020 TCS. All rights reserved.
//

import UIKit
import WebKit
import OakLib

/// News Details ViewController
final class NewsDetailsViewController: BaseViewController {
 
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var webview: WKWebView!
    var newsDetailsVM: NewsDetailsViewModel!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.show(String.Global.pleaseWait.localized)
        setupUI()
    }
}

// MARK: - Internal Methods
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

// MARK: - Delegate Methods

extension NewsDetailsViewController: WKNavigationDelegate {
    
    /// WebView Delegate
    /// - Parameters:
    ///   - webView: Start Loading
    ///   - navigation:
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    }
    
    /// WebView Delegate
    /// - Parameters:
    ///   - webView: Finish Loading
    ///   - navigation: 
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActivityIndicator.dismiss()
    }
}
