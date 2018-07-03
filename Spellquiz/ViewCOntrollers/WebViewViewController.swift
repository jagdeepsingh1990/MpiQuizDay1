//
//  WebViewViewController.swift
//  Spellquiz
//
//  Created by Jagdeep on 02/07/18.
//  Copyright © 2018 biroke. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var forwardBtn: UIBarButtonItem!
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var backBtn: UIBarButtonItem!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.mpi.mb.ca/en/Pages/default.aspx")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        self.webView.navigationDelegate = self
       backBtn.isEnabled = false
        forwardBtn.isEnabled = false
        
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
    }

    
    @IBAction func back(_ sender: UIBarButtonItem) {
        if sender.tag == 1 {
            webView.canGoBack
        }else if sender.tag == 2 {
            webView.canGoForward
        }else {
            let  request = NSURLRequest(url: webView.url!)
            webView.load(request as URLRequest)
            
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            backBtn.isEnabled = webView.canGoBack
            forwardBtn.isEnabled = webView.canGoForward
        }
    }
   
}
