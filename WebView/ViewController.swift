//
//  ViewController.swift
//  WebView
//
//  Created by Faical Sawadogo1212 on 2/5/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,
    WKNavigationDelegate,
    WKUIDelegate
{
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // The buttons are initially disabled
        backButton.isEnabled    = true
        forwardButton.isEnabled = false
        
        // the view controller should be the web view's delegate
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let urlString = "https://www.bmcc.edu"
        //let urlString = "https://www.google.com"
        
        // Loading the web view
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        webView.goBack()
    }
    
    @IBAction func forward(_ sender: UIButton) {
        webView.goForward()
    }
    
    @IBAction func refresh(_ sender: UIButton) {
        webView.reload()
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        // Enable/disable the buttons
        backButton.isEnabled    = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }

    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        let dest = navigationAction.request.url
        print(">>> \(String(describing: dest?.absoluteString))")
        
        // Stay in WebKit if url contains kent
        if dest?.absoluteString.range(of: "bmcc") == nil {
            decisionHandler(WKNavigationActionPolicy.cancel)
            
            // this line open the link in the system browser
            UIApplication.shared.open(dest!, options: [:],
                                      completionHandler: {success in print("Success: \(success)")})
        }
        else {
            decisionHandler(WKNavigationActionPolicy.allow)
        }
    }
}
