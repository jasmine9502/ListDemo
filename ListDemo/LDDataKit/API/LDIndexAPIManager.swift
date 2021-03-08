//
//  LDIndexAPIManager.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/4.
//

import UIKit
import RxCocoa
import RxSwift

//protocol LDUserListProvider {
//    func getUsers(forKeyword keyword: String ,forPage page:Int) -> Observable<LDUserSction>
//}
//
//class LDIndexAPIManager: LDUserListProvider {
//    func getUsers(forKeyword keyword: String, forPage page: Int) -> Observable<LDUserSction> {
//        return Observable<LDUserSction>.create ({ observable in
//            LDNetwork.request(LDApi.getUser(keyWork: keyword, intPage: page), successCallback: { (returnData) in
//                var users: [LDUserModel2] = []
//                users = ([LDUserModel2].deserialize(from:(returnData["items"] as! NSArray))! as NSArray) as! [LDUserModel2]
//                observable.onNext(LDUserSction(items: users))
//                observable.onCompleted()
//            }) { (msg) in
//                print(msg)
//            }
//            return Disposables.create()
//        })
//    }
//    
// 
//}
