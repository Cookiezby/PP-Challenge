//
//  Rate.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

struct CurrencyRate {
    var source: String
    var quotes: [String: Double]
    
    init(source: String, quotes: [String: Double]) {
        self.source = source
        self.quotes = quotes
    }
    
    func getRate(target: String) -> Double {
        return quotes[target]!
    }
}
