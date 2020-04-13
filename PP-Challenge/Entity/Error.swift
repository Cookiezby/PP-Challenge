//
//  Error.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation

enum APIError: Error {
    case networkError(Error)
    case invalidResponse
}
