//
//  WebViewVC.swift
//  SmpelsUIKit
//
//  Created by Tal Spektor on 26/01/2021.
//  Copyright © 2021 Tal Spektor. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, BaseVC {
    var topTitle: String {
        return "\(WebViewVC.self)"
    }
    
    let webview: WKWebView = {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        let configutation = WKWebViewConfiguration()
        configutation.preferences = prefs
        let webview = WKWebView(frame: .zero, configuration: configutation)
        return webview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webview)
        
        guard let url = URL(string: "https://iosacademy.io") else {
            return
        }
        webview.load(URLRequest(url: url))
        webview.customUserAgent = "iPad/Chrome"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.webview.evaluateJavaScript("document.body.innerHTML") { (result, errror) in
                guard let html = result as? String, errror == nil else {
                    return
                }
                print(html)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }
}
