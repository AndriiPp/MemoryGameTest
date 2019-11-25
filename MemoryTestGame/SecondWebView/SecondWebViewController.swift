//
//  SecondWebViewController.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/25/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import UIKit
import WebKit

class SecondWebViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate, WKUIDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var secondWebView: WKWebView!
    @IBOutlet weak var loadingInficator: UIActivityIndicatorView!
    
    //MARK: - private params
    let urlString = "https://appstrack18.xyz/CX67h1bP"
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondWebView.scrollView.delegate = self
        secondWebView.navigationDelegate = self
        self.secondWebView.uiDelegate = self
        
        if let url = URL(string: self.urlString.self) {
            let request = URLRequest(url: url)
            self.secondWebView.load(request)
            print("request")
        }
    }
    
    //MARK:- Service functions
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
}
extension SecondWebViewController {
    
    //MARK: - WebView delegate
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
           if navigationAction.targetFrame == nil {
               webView.load(navigationAction.request)
           }
           return nil
       }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingInficator.startAnimating()
        secondWebView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingInficator.stopAnimating()
    }
}
