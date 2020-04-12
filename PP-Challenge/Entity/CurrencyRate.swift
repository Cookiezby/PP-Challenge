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
    
    enum Key: String {
        case sources
        case quoteDictionary
        case quotes
    }
    
    init(source: String, quotes: [String: Double]) {
        self.source = source
        self.quoteDictionary = quotes
        self.quotes = quotes.map{ (key, value) -> Quote in
            Quote(key: key, value: value)
        }
        
        self.quotes.sort { $0.key < $1.key }
    }
}

struct Quote {
    var key: String
    var value: Double
    
    enum Key: String {
        case key
        case value
    }
    
    init(key: String, value: Double) {
        self.key = key
        self.value = value
    }
}
