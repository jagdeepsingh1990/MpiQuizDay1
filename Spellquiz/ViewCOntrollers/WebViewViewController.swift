//
//  WebViewViewController.swift
//  Spellquiz
//
//  Created by Jagdeep on 02/07/18.
//  Copyright © 2018 biroke. All rights reserved.
//

import UIKit
import WebKit
import Lottie
class WebViewViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var forwardBtn: UIButton!
    
    @IBOutlet weak var Reload: UIButton!
    @IBOutlet weak var backBtn: UIButton!
   
    let animationView = LOTAnimationView(name: "flow")
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.mpi.mb.ca/en/Pages/default.aspx")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        self.webView.navigationDelegate = self
      webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        
        
        
        backBtn.isEnabled = false
        forwardBtn.isEnabled = false
        
        animationView.frame = CGRect(x: self.view.frame.size.width/2 - 60, y: self.view.frame.size.height/2 - 60, width: 120, height: 120)

       
    }

    
    @IBAction func back(_ sender: UIButton) {
        if sender.tag == 1 {
            webView.goBack()
        }else if sender.tag == 2 {
            webView.goForward()
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
   
   
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.view.addSubview(animationView)
        animationView.play()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.animationView.removeFromSuperview()
    }
}
