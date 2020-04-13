//
//  SelectCurrencyService.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol SelectCurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], APIError>) -> Void)
}

extension SelectCurrencyService {
    static func decode(data: Data) -> [Currency]? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
            guard let currencies = json["currencies"] as? [String: String] else { return nil }
            var result: [Currency] = []
            for key in currencies.keys {
                result.append(Currency(name: key, detail: currencies[key]!))
            }
            result.sort { $0.name < $1.name }
            return result
        } catch {
            print(error)
        }
        return nil
    }
}

class SelectCurrencyServiceImpl: SelectCurrencyService {
    func fetchCurrencies(completed: @escaping (Result<[Currency], APIError>) -> Void) {
        guard let url = URL(string: Constants.currenciesUrl) else { return }
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
                        
            if let currencies = SelectCurrencyServiceImpl.decode(data: data) {
                completed(.success(currencies))
            } else {
                completed(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
}
