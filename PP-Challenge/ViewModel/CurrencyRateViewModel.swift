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
}

class CurrencyRateViewModel: CurrencyRateViewModelInput, CurrencyRateViewModelOutput {
    var amount = MutableProperty<Double>(1)
    var currencyRate = MutableProperty<CurrencyRate?>(nil)
    
    func fetchRate() {
        APIService.shared.fetchUSDCurrencyRate { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let rate):
                self.currencyRate.swap(rate)
            case .failure:
                break
            }
        }
    }
    
    func updateAmount(_ amount: Double) {
        self.amount.swap(amount)
    }
}
