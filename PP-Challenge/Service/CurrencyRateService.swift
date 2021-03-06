//
//  CurrencyRateService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol CurrencyRateService {
    func fetchCurrencyBaseRate(completed: @escaping (Result<CurrencyRate, APIError>) -> Void)
}

extension CurrencyRateService {
    static func decode(data: Data) -> CurrencyRate? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
            guard let quotes = json["quotes"] as? [String: Double] else { return nil }
            guard let source = json["source"] as? String else { return nil }
            var newQuotes: [String: Double] = [:]
            for key in quotes.keys {
                newQuotes[String(key.dropFirst(3))] = quotes[key]
            }
            let rate = CurrencyRate(source: source, quotes: newQuotes)
            return rate
        } catch {
            print(error)
        }
        return nil
    }
}

class CurrencyRateServiceImpl: CurrencyRateService {
    
    private var lastUpdatedTime: Double? = nil
    
    init() {
        lastUpdatedTime = UserDefaults.standard.value(forKey: UserDefaultsKey.baseRateLastUpdatedTime.rawValue) as? Double
    }
    
    func fetchCurrencyBaseRate(completed: @escaping (Result<CurrencyRate, APIError>) -> Void) {
        if let lastUpdatedTime = lastUpdatedTime,
            Date().timeIntervalSince1970 - lastUpdatedTime >= 30 * 60,
            let jsonStr = UserDefaults.standard.value(forKeyPath: UserDefaultsKey.baseRate.rawValue) as? String,
            let data = jsonStr.data(using: .utf8) {
            if let rate = CurrencyRateServiceImpl.decode(data: data) {
                completed(.success(rate))
                return
            }
        }
        
        guard let url = URL(string: Constants.rateUrl) else { return }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completed(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidResponse))
                return
            }
           
            if let rate = CurrencyRateServiceImpl.decode(data: data) {
                UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: UserDefaultsKey.baseRateLastUpdatedTime.rawValue)
                String(data: data, encoding: .utf8).map { UserDefaults.standard.set($0, forKey: UserDefaultsKey.baseRate.rawValue) }
                UserDefaults.standard.synchronize()
                completed(.success(rate))
            } else {
                completed(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
}
