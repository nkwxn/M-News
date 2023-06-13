//
//  NewsWebViewController.swift
//  M-News
//
//  Created by Nicholas Kwan on 13/06/23.
//

import UIKit
import WebKit

final class NewsWebViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    private lazy var progBar: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: self.topbarHeight, width: self.view.frame.width, height: 50))
        progressView.progress = 0.0
        progressView.tintColor = UIColor.systemBlue
        return progressView
    }()
    
    var urlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        view.addSubview(webView)
        webView.addObserver(self, forKeyPath: "estimateProgress", options: NSKeyValueObservingOptions.new, context: nil)
        webView.addSubview(progBar)
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimateProgress" {
            self.progBar.alpha = 1.0
            progBar.setProgress(Float(webView.estimatedProgress), animated: true)
            if self.webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseInOut) {
                    self.progBar.alpha = 0.0
                } completion: { finished in
                    self.progBar.progress = 0
                }
            }
        }
    }
}
