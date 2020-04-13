//
//  SelectCurrencyViewModelTest.swift
//  PP-ChallengeTests
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import XCTest
@testable import PP_Challenge

class SelectCurrencyViewModelTest: XCTestCase {

    func testCurrencyResponseSucceed() {
        let viewModel: SelectCurrencyViewModel = SelectCurrencyViewModelImpl(service: MockSelectCurrencyService())
        viewModel.output.currencies.signal.disOnMainWith(self).observeValues { (value) in
            XCTAssert(viewModel.currencies.value.count == 168)
        }
        viewModel.fetchCurrencies()
    }
    
    func testCurrencyResponseFaild() {
        let viewModel: SelectCurrencyViewModel = SelectCurrencyViewModelImpl(service: MockFailSelectCurrencyService())
        viewModel.output.error.signal.skipNil().disOnMainWith(self).observeValues { (value) in
            if let error = value as? APIError, case .invalidResponse = error {
                //pass
            } else {
                XCTFail()
            }
        }
        viewModel.fetchCurrencies()
    }
    
    func testSelectCurrency() throws {
        EnvironmentData.shared.currentCurrency = "USD"
        let viewModel: SelectCurrencyViewModel = SelectCurrencyViewModelImpl(service: MockSelectCurrencyService())
        viewModel.fetchCurrencies()
        viewModel.selectCurrency(viewModel.currencies.value[0])
        XCTAssert(EnvironmentData.shared.currentCurrency == viewModel.currencies.value[0].name)
    }

}
