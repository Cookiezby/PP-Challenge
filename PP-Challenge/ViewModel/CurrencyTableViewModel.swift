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
    
    var currencies: MutableProperty<[Currency]>

    init() {
        self.currencies = MutableProperty([])
    }
    
    func fetchCurrencies() {
        
    }
    
    func selectCurrency(_ currency: Currency) {
    }
}
