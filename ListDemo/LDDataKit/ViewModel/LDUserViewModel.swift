//
//  LDUserViewModel.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import RxDataSources

enum LDRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class LDUserViewModel: NSObject {
    typealias Input = LDUserInput
    typealias Output = LDUserOutput
    
    private lazy var disposeBag = DisposeBag()
    // 存放着解析完成的模型数组
    var models = Variable<[LDUserModel]>([])
    // 记录当前的索引值
    var index: Int = 1
    // 记录搜索关键词
    var searchKeyword = BehaviorRelay(value: "")
}

extension LDUserViewModel: LDUserViewModelType {
    struct LDUserInput {
        //搜索词变化
        let keywordTrigger: Driver<String>
    }
    
    struct LDUserOutput {
        // tableView的sections数据
        let sections: Driver<[LDUserSction]>
        // 加载数据
        let requestCommond = PublishSubject<Bool>()
        // tableview
        let refreshStatus = Variable<LDRefreshStatus>(.none)
    }
    
    func transform(input: LDUserViewModel.LDUserInput) -> LDUserViewModel.LDUserOutput {
        let sections = models.asObservable().map { (models) -> [LDUserSction] in
            // 当models的值被改变时会调用
            return [LDUserSction(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        let elements = BehaviorRelay<[LDUserSction]>(value: [])
        let output = LDUserOutput(sections: sections)
        
        
        input.keywordTrigger.skip(1).throttle(DispatchTimeInterval.milliseconds(300)).distinctUntilChanged().asObservable().bind(to: searchKeyword).disposed(by: disposeBag)
        
        
        Observable.combineLatest(searchKeyword, output.requestCommond.asObservable())
            .map({ [self] (keyword, isReloadData) -> [LDUserSction] in
                var elements: [LDUserSction] = []
                var searchKeyword = keyword
                if (keyword == "") {
                    searchKeyword = "swift"
                }
                self.index = isReloadData ? 1 : self.index+1
                ApiProvider.rx.request(.getUser(keyWork:searchKeyword, intPage: self.index))
                    .asObservable()
                    .mapObject(LDReturnData.self)
                    .subscribe({ [weak self] (event:Event) in
                        switch event {
                        case let .next(response):
                            var users: [LDUserModel] = []
                            if ((response.items) != nil) {
                                users = response.items!
                                self?.models.value = isReloadData ? users : (self?.models.value ?? []) + users
                                //elements = isReloadData ? users : (self?.models.value ?? []) + users
                            } else {
                                showTipStr(info: "加载失败")
                            }
                        case let .error(error):
                            showTipStr(info: error.localizedDescription)
                        case .completed:
                            output.refreshStatus.value = isReloadData ? .endHeaderRefresh : .endFooterRefresh
                        }
                    }).disposed(by: disposeBag)
                return elements
            }).bind(to: elements).disposed(by: disposeBag)
        return output
    }
}
