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
    
    func updateUI() {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
    }
}

private extension NewsDetailsViewController {
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
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
