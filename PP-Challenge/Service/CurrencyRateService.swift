//
//  CurrencyRateService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol CurrencyRateService {
    func fetchCurrencyBaseRate(completed: (Result<CurrencyRate, Error>) -> Void)
}

class MockCurrencyRateService: CurrencyRateService {
    func fetchCurrencyBaseRate(completed: (Result<CurrencyRate, Error>) -> Void) {
        if let rate = DataManager.shared.baseRate {
            completed(.success(rate))
            return
        }
        
        let url = Bundle.main.url(forResource: "live", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        guard let quotes = json["quotes"] as? [String: Double] else { return }
        guard let source = json["source"] as? String else { return }
        var newQuotes: [String: Double] = [:]
        for key in quotes.keys {
            newQuotes[String(key.dropFirst(3))] = quotes[key]
        }
        let rate = CurrencyRate(source: source, quotes: newQuotes)
        DataManager.shared.currentCurrency = rate.source
        DataManager.shared.baseRate = rate
        DataManager.shared.lastUpdateTime = Date()
        
        completed(.success(rate))
    }
}
