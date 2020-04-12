//
//  CurrencyRateViewModel.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol CurrencyRateViewModelInput {
    func updateAmount(_ amount: Double)
    func fetchRate()
}

protocol CurrencyRateViewModelOutput {
    var amount: MutableProperty<Double> { get }
    var currencyRate: MutableProperty<CurrencyRate?> { get }
    var currentCurrency: MutableProperty<String?> { get }
}

class CurrencyRateViewModel: CurrencyRateViewModelInput, CurrencyRateViewModelOutput {
    private var service: CurrencyRateService
    var amount = MutableProperty<Double>(1)
    var currencyRate = MutableProperty<CurrencyRate?>(nil)
    var currentCurrency = MutableProperty<String?>(nil)
    
    init(service: CurrencyRateService) {
        self.service = service
        
//        DataManager.shared.currentCurrency.signal.skipNil().observeValues { [weak self] (target) in
//            guard let self = self else { return }
//            self.currentCurrency.swap(target)
//            self.service.fetchCurrencyBaseRate { (result) in
//                switch result {
//                case .success(let rate):
//                    guard let quote = rate.quoteDictionary[target] else { return }
//                    let multiple: Double = 1 / quote
//                    var quotes: [String: Double] = [:]
//                    for key in rate.quoteDictionary.keys {
//                        quotes[key] = rate.quoteDictionary[key]! * multiple
//                    }
//                    let targetRate = CurrencyRate(source: target, quotes: quotes)
//                    self.currencyRate.swap(targetRate)
//                case .failure:
//                    break
//                }
//            }
//        }
        
    }
    
    func fetchRate() {
        service.fetchCurrencyBaseRate { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let rate):
                self.currencyRate.swap(rate)
                self.currentCurrency.swap(rate.source)
            case .failure:
                break
            }
        }
    }
    
    func updateAmount(_ amount: Double) {
        self.amount.swap(amount)
    }
}
