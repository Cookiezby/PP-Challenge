//
//  Currency.swift
//  PP-Challenge
//
//  Created by bingyi.zhu on 2020/04/09.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

struct Currency {
    private(set) var name: String
    private(set) var detail: String
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
}
