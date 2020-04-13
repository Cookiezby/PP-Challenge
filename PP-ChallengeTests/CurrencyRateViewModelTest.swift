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
        viewModel.output.currencyRate.signal.skipNil().disOnMainWith(self).observeValues { (rate) in
            XCTAssert(rate.source == "USD")
            XCTAssert(rate.quotes.count == 168)
            XCTAssert(rate.quoteDictionary["CNY"] == 7.066023)
        }
        viewModel.input.fetchCurrencyRate()
    }
    
    func testFetchCurrencyRateFailed() {
        let viewModel: CurrencyRateViewModel = CurrencyRateViewModelImpl(service: MockFailCurrencyRateService())
        viewModel.output.error.signal.skipNil().disOnMainWith(self).observeValues { (value) in
            if let error = value as? APIError, case .invalidResponse = error {
                //pass
            } else {
                XCTFail()
            }
        }
        viewModel.fetchCurrencyRate()
    }
}
