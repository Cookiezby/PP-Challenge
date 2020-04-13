//
//  ReactiveSwift+Ext.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import ReactiveSwift

extension Signal {
    func disOnMainWith(_ object: NSObject) -> Signal<Value, Error> {
        return self.take(during: object.reactive.lifetime).observe(on: UIScheduler())
    }
}
