//
//  CurrencyService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol CurrencyService {
    func fetchCurrencies(completed: (Result<[Currency], Error>) -> Void)
}

class MockCurrencyService: CurrencyService {
    func fetchCurrencies(completed: (Result<[Currency], Error>) -> Void) {
        let url = Bundle.main.url(forResource: "list", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        let currencies = json["currencies"] as! [String: String]
        var result: [Currency] = []
        for key in currencies.keys {
            result.append(Currency(name: key, description: currencies[key]!))
        }
        result.sort { $0.name < $1.name }
        completed(.success(result))
    }
}
