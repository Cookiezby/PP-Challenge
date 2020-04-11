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
    case currencyList = "CurrencyTableViewController"
}

extension UIStoryboard {
   class func load(_ storyboard: StoryboardName) -> UIViewController{
      return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: storyboard.rawValue)
   }
}
