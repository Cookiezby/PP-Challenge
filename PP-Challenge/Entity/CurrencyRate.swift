//
//  Rate.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

class CurrencyRate: NSObject {
    var source: String
    private(set) var quoteDictionary: [String: Double]
    private(set) var quotes: [Quote]
    
    init(source: String, quotes: [String: Double]) {
        self.source = source
        self.quoteDictionary = quotes
        self.quotes = quotes.map{ (key, value) -> Quote in
            Quote(key: key, value: value)
        }
        
        self.quotes.sort { $0.key < $1.key }
        super.init()
    }
}

struct Quote {
    var key: String
    var value: Double
}
