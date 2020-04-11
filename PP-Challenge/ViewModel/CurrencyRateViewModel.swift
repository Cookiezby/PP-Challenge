//
//  CurrencyRateViewModel.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

protocol CurrencyRateViewModelInput {
    func fetchRate()
}

protocol CurrencyRateViewModelOutput {
    
}

class CurrencyRateViewModel: CurrencyRateViewModelInput, CurrencyRateViewModelOutput {
    func fetchRate() {
        
    }
}
