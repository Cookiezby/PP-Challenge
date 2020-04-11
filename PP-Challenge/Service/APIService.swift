//
//  APIService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

class APIService {
    var lastUpdateTime: Double?
    var currencies: [Currency] = []
    var usdRate: CurrencyRate?

    func fetchUSDCurrencyRate(completed: (Result<CurrencyRate, Error>) -> Void) {
        let url = Bundle.main.url(forResource: "live", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        guard let quotes = json["quotes"] as? [String: Double] else { return }
        guard let source = json["source"] as? String else { return }
        let rate = CurrencyRate(source: source, quotes: quotes)
        completed(.success(rate))
    }
    
    func fetchCurrencies(completed: (Result<[Currency], Error>) -> Void) {
        let url = Bundle.main.url(forResource: "list", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        let currencies = json["currencies"] as! [String: String]
        var result: [Currency] = []
        for key in currencies.keys {
            result.append(Currency(name: key, description: currencies[key]!))
        }
        completed(.success(result))
    }
}
