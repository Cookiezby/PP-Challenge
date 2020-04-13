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
    func fetchCurrencyRate()
}

protocol CurrencyRateViewModelOutput {
    var amount: MutableProperty<Double> { get }
    var error: MutableProperty<Error?> { get }
    var currencyRate: MutableProperty<CurrencyRate?> { get }
    var currentCurrency: MutableProperty<String?> { get }
}

class CurrencyRateViewModel: CurrencyRateViewModelInput, CurrencyRateViewModelOutput {
    private var service: CurrencyRateService
    var error = MutableProperty<Error?>(nil)
    var amount = MutableProperty<Double>(1)
    var currencyRate = MutableProperty<CurrencyRate?>(nil)
    var currentCurrency = MutableProperty<String?>(nil)
    
    init(service: CurrencyRateService) {
        self.service = service
    }
    
    func fetchCurrencyRate() {
        service.fetchCurrencyBaseRate { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let rate):
                self.currencyRate.swap(rate)
                self.currentCurrency.swap(rate.source)
                EnvironmentData.shared.currentCurrency = rate.source
            case .failure(let error):
                self.error.swap(error)
            }
        }
    }
    
    func updateAmount(_ amount: Double) {
        self.amount.swap(amount)
    }
}
