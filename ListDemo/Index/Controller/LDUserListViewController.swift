//
//  LDUserListViewController.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/5.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh
import Kingfisher

class LDUserListViewController: LDBaseViewController, UIScrollViewDelegate {

    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true;
    }

}



