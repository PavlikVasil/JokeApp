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
        
        webView = WKWebView(frame: self.view.frame)
        webView.isUserInteractionEnabled = true
        self.view.addSubview(webView)
        
        self.webView.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadURL()
    }
    
    func loadURL(){
        let url = URL(string: "http://www.icndb.com/api/")!
        
        webView.load(URLRequest(url: url))
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
