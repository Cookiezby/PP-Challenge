//
//  Storyboard.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case currencyList = "SelectCurrencyViewController"
}

enum ViewName: String {
    case errorView = "ErrorView"
}

extension UIStoryboard {
    class func load<T>(fromStoryboard name: StoryboardName, withType type: T.Type) -> T {
        if let vc = UIStoryboard(name: name.rawValue, bundle: nil).instantiateViewController(withIdentifier: name.rawValue) as? T {
            return vc
        }
        fatalError("Could not load storyboard with type " + String(describing: type))
   }
}

extension Bundle {
    static func loadView<T>(fromNib name: ViewName, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name.rawValue, owner: nil, options: nil)?.first as? T {
            return view
        }
        fatalError("Could not load view with type " + String(describing: type))
    }
}
