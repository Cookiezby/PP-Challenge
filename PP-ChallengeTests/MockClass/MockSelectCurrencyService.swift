//
//  MockSelectCurrencyService.swift
//  PP-ChallengeTests
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
@testable import PP_Challenge

class MockSelectCurrencyService: SelectCurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], APIError>) -> Void) {
        let url = Bundle.main.url(forResource: "list", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        if let currencies = decode(data: data) {
            completed(.success(currencies))
        } else {
            completed(.failure(.invalidResponse))
        }
    }
}

class MockFailCurrencyService: SelectCurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], APIError>) -> Void) {
        completed(.failure(.invalidResponse))
    }
}
