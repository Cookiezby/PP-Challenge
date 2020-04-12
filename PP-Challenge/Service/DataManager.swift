//
//  DataManager.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import ReactiveSwift

enum DataKey: String {
    case lastUpdatedTime
    case currencies
    case baseRate
    case currentCurrency
}

class DataManager {
    
    static let shared = DataManager()
    var currentCurrency: String? = nil
    
    init() {
//        lastUpdateTime.signal.skipNil().observeValues { (date) in
//            UserDefaults.standard.set(date, forKey: DataKey.lastUpdatedTime.rawValue)
//            UserDefaults.standard.synchronize()
//        }
//
//        currencies.signal.skip(while: {$0.count > 0}).observeValues { (currencies) in
//            UserDefaults.standard.set(currencies, forKey: DataKey.currencies.rawValue)
//            UserDefaults.standard.synchronize()
//        }
        
//        baseRate.signal.skipNil().observeValues { (rate) in
//            UserDefaults.standard.set(rate, forKey: DataKey.baseRate.rawValue)
//            UserDefaults.standard.synchronize()
//        }
//
//        currentCurrency.signal.skipNil().observeValues { (currency) in
//            UserDefaults.standard.set(currency, forKey: DataKey.currentCurrency.rawValue)
//            UserDefaults.standard.synchronize()
//        }
    }
}
