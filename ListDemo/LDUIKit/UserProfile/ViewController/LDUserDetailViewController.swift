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
    
    var webview = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建wkwebview
        let webView = WKWebView(frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height))
        //创建请求
        webView.load(URLRequest.init(url: URL.init(string: self.webUrl!)!))
        //添加wkwebview
        self.view.addSubview(webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false;
    }

}
