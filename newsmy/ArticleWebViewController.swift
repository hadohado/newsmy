//
//  ArticleWebViewController.swift
//  newsmy
//
//  Created by ha tuong do on 12/12/18.
//  Copyright © 2018 alpine. All rights reserved.
//

import UIKit
import WebKit

class ArticleWebViewController: UIViewController {

    
    var article = Article()
    
    @IBOutlet weak var webView2: WKWebView!
    // @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        if let url = URL(string:
            "https://www.aljazeera.com/news/2018/12/india-ruling-hindu-nationalists-suffer-blow-state-elections-181211171925354.html" ) {
            webView2.load(URLRequest(url: url))
        }
         */
        if let url =  URL(string: article.url) {
            webView2.load(URLRequest(url: url))
        }
            // print("url = ", url, "article.url = ", article.url)
            // Thread1: error: Unexpectedly found nil while unwrapping an Optional value
            //        webView.load(URLRequest(url: url))
            // webView.load(URLRequest(url: url))
            // webView.load(URLRequest: URLRequest(url: url) )
        // }
    }

}
