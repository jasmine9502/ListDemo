//
//  LDUserModel.swift
//  ListDemo
//
//  Created by 张玥 on 2021/3/4.
//

import Foundation
import ObjectMapper
import RxDataSources

struct LDUserModel: Mappable {
    var login: String? = ""
    var score: Float? = 0
    var html_url: String? = ""
    var avatar_url: String? = ""
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        login       <- map["login"]
        score       <- map["score"]
        html_url    <- map["html_url"]
        avatar_url  <- map["avatar_url"]
    }
}


struct LDReturnData: Mappable {
    var total_count      = 0
    var items : [LDUserModel]?
    var incomplete_results    = false
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        total_count       <- map["total_count"]
        items        <- map["items"]
        incomplete_results    <- map["incomplete_results"]
    }
}


/* ============================= SectionModel =============================== */
struct LDUserSction {
    var items: [Item]
}

extension LDUserSction: SectionModelType {
    typealias Item = LDUserModel
    init(original: LDUserSction, items: [LDUserSction.Item]) {
        self = original
        self.items = items
    }
}
