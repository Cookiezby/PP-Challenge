//
//  Rate.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

struct CurrencyRate {
    let source: String
    let quoteDictionary: [String: Double]
    let quotes: [Quote]
    
    init(source: String, quotes: [String: Double]) {
        self.source = source
        self.quoteDictionary = quotes
        var quoteList = quotes.map{ Quote(key: $0, value: $1) }
        quoteList.sort { $0.key < $1.key }
        self.quotes = quoteList
    }
}

struct Quote {
    let key: String
    let value: Double

    init(key: String, value: Double) {
        self.key = key
        self.value = value
    }
}
