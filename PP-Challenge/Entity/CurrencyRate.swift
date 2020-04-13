//
//  Rate.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

struct CurrencyRate {
    private(set) var source: String
    private(set) var quoteDictionary: [String: Double]
    private(set) var quotes: [Quote]
    
    init(source: String, quotes: [String: Double]) {
        self.source = source
        self.quoteDictionary = quotes
        self.quotes = quotes.map{ Quote(key: $0, value: $1) }
        self.quotes.sort { $0.key < $1.key }
    }
}

struct Quote {
    private(set) var key: String
    private(set) var value: Double

    init(key: String, value: Double) {
        self.key = key
        self.value = value
    }
}
