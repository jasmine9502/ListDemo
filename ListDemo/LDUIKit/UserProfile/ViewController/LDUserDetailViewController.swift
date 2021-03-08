//
//  LDUserDetailViewController.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/6.
//

import UIKit
import WebKit

class LDUserDetailViewController: LDBaseViewController {
    
    // 外部传值
    private var webUrl:String?
    convenience init(url:String?) {
        self.init()
        self.webUrl = url
    }
    
    private var webView = WKWebView()
    private var progressView = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false;
    }
    
    //MARK:webView & progressView
    func configUI() {
        //wkwebview
        webView = WKWebView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
        //创建请求
        webView.load(URLRequest.init(url: URL.init(string: self.webUrl!)!))
        self.view.addSubview(webView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        //progressView
        progressView = UIProgressView(frame: CGRect(x: 0, y: 44-2, width: UIScreen.main.bounds.size.width, height: 2))
        progressView.trackTintColor = UIColor.white
        progressView.progressTintColor = UIColor.black
        self.navigationController?.navigationBar.addSubview(progressView)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            print(webView.estimatedProgress)
        }
    }
    
    //移除观察者
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
        self.navigationItem.title = webView.title
    }
    
    deinit {
        print("con is deinit")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        progressView.reloadInputViews()
    }
}
