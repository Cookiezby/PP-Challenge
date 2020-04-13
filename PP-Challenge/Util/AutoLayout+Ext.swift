//
//  AutoLayout+Ext.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func pinToView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
