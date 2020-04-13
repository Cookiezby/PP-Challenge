//
//  MockCurrencyRateService.swift
//  PP-ChallengeTests
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
@testable import PP_Challenge

class MockCurrencyRateService: CurrencyRateService {
    private var lastUpdatedTime: Double? = nil
    
    func fetchCurrencyBaseRate(completed: @escaping (Result<CurrencyRate, APIError>) -> Void) {
        let url = Bundle.main.url(forResource: "live", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        if let rate = decode(data: data) {
            completed(.success(rate))
        } else {
            completed(.failure(.invalidResponse))
        }
    }
}

