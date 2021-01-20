//
//  WebViewController.swift
//  JokeApp
//
//  Created by Павел on 20.01.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        
        let url = URL(string: "http://www.icndb.com/api/")!
        webView = WKWebView(frame: self.view.frame)
        webView.isUserInteractionEnabled = true
        self.view.addSubview(webView)
        webView.load(URLRequest(url: url))
        
        self.webView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true
    }

    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
