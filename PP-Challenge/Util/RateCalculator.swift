//
//  RateCalculator.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

class CurrencyRateCalculator {
    static func calculate(target: String, completed: (Result<CurrencyRate, Error>) -> Void) {
//        MockCurrencyRateService().fetchCurrencyBaseRate { (result) in
//            switch result {
//            case .success(let usdRate):
//                guard let quote = usdRate.quoteDictionary[target] else { return }
//                let multiple: Double = 1 / quote
//                var quotes: [String: Double] = [:]
//                for key in usdRate.quoteDictionary.keys {
//                    quotes[key] = usdRate.quoteDictionary[key]! * multiple
//                }
//                let targetRate = CurrencyRate(source: target, quotes: quotes)
//                completed(.success(targetRate))
//            case .failure:
//                break
//            }
//        }
    }
}
