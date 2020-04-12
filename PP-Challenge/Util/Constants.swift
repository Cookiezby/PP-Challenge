//
//  Constants.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/12.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

struct Constants {
    static let apiAccessKey: String = "fa4b404111dff672892f5d42f3767037"
    static var rateUrl: String { "http://api.currencylayer.com/live?access_key=\(apiAccessKey)" }
    static var currenciesUrl: String { "http://api.currencylayer.com/list?access_key=\(apiAccessKey)" }
}
