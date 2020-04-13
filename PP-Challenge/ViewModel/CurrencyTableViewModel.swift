//
//  CurrencyListViewModel.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol CurrencyTableViewModelInput {
    func fetchCurrencies()
    func selectCurrency(_ currency: Currency)
}

protocol CurrencyTableViewModelOutput {
    var currencies: MutableProperty<[Currency]> { get }
}

class CurrencyTableViewModel: CurrencyTableViewModelOutput, CurrencyTableViewModelInput {
    private var service: CurrencyService
    var currencies: MutableProperty<[Currency]>

    init(service: CurrencyService) {
        self.service = service
        self.currencies = MutableProperty([])
    }
    
    func fetchCurrencies() {
        service.fetchCurrencies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let currencies):
                self.currencies.swap(currencies)
            case .failure:
                break
            }
        }
    }
    
    func selectCurrency(_ currency: Currency) {
        guard EnvironmentData.shared.currentCurrency != currency.name else { return }
        EnvironmentData.shared.currentCurrency = currency.name
        NotificationCenter.default.post(name: .currencyChanged, object: nil)
    }
}
