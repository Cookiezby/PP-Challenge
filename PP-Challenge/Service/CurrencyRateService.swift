//
//  CurrencyRateService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol CurrencyRateService {
    func fetchCurrencyBaseRate(completed: @escaping (Result<CurrencyRate, Error>) -> Void)
}

class MockCurrencyRateService: CurrencyRateService {
    func fetchCurrencyBaseRate(completed: @escaping (Result<CurrencyRate, Error>) -> Void) {
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
        completed(.success(rate))
    }
}

class CurrencyRateServiceImpl: CurrencyRateService {
    
    func fetchCurrencyBaseRate(completed: @escaping (Result<CurrencyRate, Error>) -> Void) {
        guard let url = URL(string: Constants.rateUrl) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            if let error = error {
                completed(.failure(error))
            }
            let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
            guard let quotes = json["quotes"] as? [String: Double] else { return }
            guard let source = json["source"] as? String else { return }
            var newQuotes: [String: Double] = [:]
            for key in quotes.keys {
                newQuotes[String(key.dropFirst(3))] = quotes[key]
            }
            let rate = CurrencyRate(source: source, quotes: newQuotes)
            completed(.success(rate))
        }
        task.resume()
    }
    
}
