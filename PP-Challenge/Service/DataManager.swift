//
//  DataManager.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import ReactiveSwift

class DataManager {
    
    static let shared = DataManager()
    var lastUpdateTime = MutableProperty<Date?>(nil)
    var currencies = MutableProperty<[Currency]>([])
    
    /// free plan can only request use rate, so we use usd rate to calculate other currency's rate
    var baseRate = MutableProperty<CurrencyRate?>(nil)
    
    init() {
        
    }
    
    func restoreFromUserDefaults() {
        
    }
    
    func saveToUserDefaults() {
        
    }
}
