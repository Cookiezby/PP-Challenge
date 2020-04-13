//
//  SelectCurrencyListViewModel.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol SelectCurrencyViewModelInput {
    func fetchCurrencies()
    func selectCurrency(_ currency: Currency)
}

protocol SelectCurrencyViewModelOutput {
    var error: MutableProperty<Error?> { get }
    var currencies: MutableProperty<[Currency]> { get }
}

protocol SelectCurrencyViewModel: SelectCurrencyViewModelOutput & SelectCurrencyViewModelInput {}

class SelectCurrencyViewModelImpl: SelectCurrencyViewModel {
    private var service: SelectCurrencyService
    var currencies: MutableProperty<[Currency]>
    var error = MutableProperty<Error?>(nil)

    init(service: SelectCurrencyService) {
        self.service = service
        self.currencies = MutableProperty([])
    }
    
    func fetchCurrencies() {
        service.fetchCurrencies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let currencies):
                self.currencies.swap(currencies)
            case .failure(let error):
                self.error.swap(error)
            }
        }
    }
    
    func selectCurrency(_ currency: Currency) {
        guard EnvironmentData.shared.currentCurrency != currency.name else { return }
        EnvironmentData.shared.currentCurrency = currency.name
        NotificationCenter.default.post(name: .currencyChanged, object: nil)
    }
}
