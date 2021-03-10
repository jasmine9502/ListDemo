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

class LDUserListViewController: LDBaseViewController, UIScrollViewDelegate, UISearchBarDelegate {
    
    //MARK:声明
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userListTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    let viewModel = LDUserViewModel()
    
    let dataSource = RxTableViewSectionedReloadDataSource<LDUserSction>(configureCell: {dataSource, tableview, indexPath, item in
        let cell = tableview.dequeueReusableCell(for: indexPath) as LDUserCell
        cell.model = item
        return cell
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //注册cell
        self.userListTableView?.register(UINib.init(nibName: "LDUserCell", bundle: Bundle.main), forCellReuseIdentifier: "LDUserCell")
        configSearchUI()
        bindView()
        // 加载数据
        self.userListTableView.mj_header!.beginRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true;
    }
    
    //MARK:searchbar
    func configSearchUI() {
        self.userSearchBar.delegate = self
        guard let searchField = self.userSearchBar.value(forKey: "searchField") as? UITextField else {
            return
        }
        searchField.layer.cornerRadius = 18
        searchField.layer.masksToBounds = true
        self.userSearchBar.layer.borderWidth = 1
        self.userSearchBar.layer.borderColor = configborderColor().cgColor
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.userSearchBar.resignFirstResponder()
    }
}

extension LDUserListViewController {
    //MARK:数据绑定
    fileprivate func bindView() {
        // 设置代理
        self.userListTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        // 输入输出
        let vmInput = LDUserViewModel.LDUserInput(keywordTrigger:userSearchBar.rx.text.orEmpty.asDriver())
        let vmOutput = viewModel.transform(input: vmInput)
        
        vmOutput.sections.asDriver().drive(self.userListTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        // tableview状态
        vmOutput.refreshStatus.asObservable().subscribe(onNext: {[weak self] status in
            switch status {
            case .beingHeaderRefresh:
                self?.userListTableView.mj_header!.beginRefreshing()
            case .endHeaderRefresh:
                self?.userListTableView.mj_header!.endRefreshing()
            case .beingFooterRefresh:
                self?.userListTableView.mj_footer!.beginRefreshing()
            case .endFooterRefresh:
                self?.userListTableView.mj_footer!.endRefreshing()
            case .noMoreData:
                self?.userListTableView.mj_footer!.endRefreshingWithNoMoreData()
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        //根据状态获取数据
        self.userListTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            vmOutput.requestCommond.onNext(true)
        })
        self.userListTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            vmOutput.requestCommond.onNext(false)
        })
        
        //列表点击事件
        self.userListTableView.rx.itemSelected.bind { [weak self] (indexPath) in
            let vc = LDUserDetailViewController(url: self!.dataSource[indexPath].html_url)
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}


