//
//  Currency.swift
//  PP-Challenge
//
//  Created by bingyi.zhu on 2020/04/09.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

class Currency: NSObject {
    var name: String
    var detail: String
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
        super.init()
    }
}
