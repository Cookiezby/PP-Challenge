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
    var hudHidden: MutableProperty<Bool> { get }
}

protocol CurrencyRateViewModel: CurrencyRateViewModelInput & CurrencyRateViewModelOutput {
    var input: CurrencyRateViewModelInput { get }
    var output: CurrencyRateViewModelOutput { get }
}

class CurrencyRateViewModelImpl: CurrencyRateViewModel {
    private var service: CurrencyRateService
    
    var input: CurrencyRateViewModelInput { self }
    var output: CurrencyRateViewModelOutput { self }
    
    var error = MutableProperty<Error?>(nil)
    var amount = MutableProperty<Double>(1)
    var baseRate = MutableProperty<CurrencyRate?>(nil)
    var currencyRate = MutableProperty<CurrencyRate?>(nil)
    var hudHidden = MutableProperty<Bool>(false)
    
    init(service: CurrencyRateService) {
        self.service = service
        addNotificationObservation()
    }
    
    func addNotificationObservation() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrencyRate), name: .currencyChanged, object: nil)
    }
    
    func fetchCurrencyRate() {
        hudHidden.swap(false)
        service.fetchCurrencyBaseRate { [weak self] (result) in
            guard let self = self else { return }
            self.hudHidden.swap(true)
            switch result {
            case .success(let rate):
                self.baseRate.swap(rate)
                self.currencyRate.swap(rate)
                EnvironmentData.shared.currentCurrency = rate.source
            case .failure(let error):
                self.error.swap(error)
            }
        }
    }
    
    func updateAmount(_ amount: Double) {
        self.amount.swap(amount)
    }
    
    @objc func updateCurrencyRate() {
        guard let baseRate = self.baseRate.value else { return }
        guard let target = EnvironmentData.shared.currentCurrency else { return }
        guard let quote = baseRate.quoteDictionary[target] else { return }
        let multiple: Double = 1 / quote
        var quotes: [String: Double] = [:]
        for key in baseRate.quoteDictionary.keys {
            quotes[key] = baseRate.quoteDictionary[key]! * multiple
        }
        let targetRate = CurrencyRate(source: target, quotes: quotes)
        currencyRate.swap(targetRate)
    }
}
