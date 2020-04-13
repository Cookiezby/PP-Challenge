//
//  ErrorView.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/13.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    @IBOutlet weak var reloadButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reloadButton.layer.cornerRadius = 6
        reloadButton.layer.applySketchShadow(color: .black, alpha: 0.15, x: 0, y: 2, blur: 7, spread: 0)
    }
}
