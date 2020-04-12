//
//  CurrencyService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol CurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], Error>) -> Void)
}

class MockCurrencyService: CurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], Error>) -> Void) {
        let url = Bundle.main.url(forResource: "list", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        let currencies = json["currencies"] as! [String: String]
        var result: [Currency] = []
        for key in currencies.keys {
            result.append(Currency(name: key, detail: currencies[key]!))
        }
        result.sort { $0.name < $1.name }
        completed(.success(result))
    }
}

class CurrencyServiceImpl: CurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], Error>) -> Void) {
        guard let url = URL(string: Constants.currenciesUrl) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                completed(.failure(error))
            }
            let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
            let currencies = json["currencies"] as! [String: String]
            var result: [Currency] = []
            for key in currencies.keys {
                result.append(Currency(name: key, detail: currencies[key]!))
            }
            result.sort { $0.name < $1.name }
            completed(.success(result))
        }
        task.resume()
    }
}
