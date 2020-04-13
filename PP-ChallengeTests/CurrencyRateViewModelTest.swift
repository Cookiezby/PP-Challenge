//
//  CurrencyRateViewModelTest.swift
//  PP-ChallengeTests
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import XCTest
@testable import PP_Challenge

class CurrencyRateViewModelTest: XCTestCase {
    
    func testChangeAmount() throws {
        let viewModel: CurrencyRateViewModel = CurrencyRateViewModelImpl(service: MockCurrencyRateService())
        viewModel.output.amount.signal.disOnMainWith(self).observeValues { (value) in
            XCTAssert(value == 100.5)
        }
        viewModel.input.updateAmount(100.5)
    }
    
    func testFetchCurrencyRate() throws {
        let viewModel: CurrencyRateViewModel = CurrencyRateViewModelImpl(service: MockCurrencyRateService())
        viewModel.currencyRate.signal.skipNil().disOnMainWith(self).observeValues { (rate) in
            XCTAssert(rate.source == "USD")
            XCTAssert(rate.quotes.count == 168)
            
        }
        viewModel.input.fetchCurrencyRate()
    }
}
