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
    private(set) var quoteDictionary: [String: Double]
    private(set) var quotes: [Quote]
    
    init(source: String, quotes: [String: Double]) {
        self.source = source
        self.quoteDictionary = quotes
        self.quotes = quotes.map{ (key, value) -> Quote in
            Quote(key: key, value: value)
        }
    }
}

struct Quote {
    var key: String
    var value: Double
}
