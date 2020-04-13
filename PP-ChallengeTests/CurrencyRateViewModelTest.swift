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
    
    func testExample() throws {
        let viewModel: CurrencyRateViewModel = CurrencyRateViewModelImpl(service: MockCurrencyRateService())
    }
}
