//
//  LDBaseViewController.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/7.
//

import UIKit

class LDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //自定义返回按钮
        let backButton = UIBarButtonItem.init(image: UIImage.init(named: "back_arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(back))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }

}
