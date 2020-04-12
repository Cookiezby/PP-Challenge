//
//  CurrencyRateTableViewCell.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import UIKit

class CurrencyRateTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    func setQuote(_ quote: Quote, amount: Double) {
        nameLabel.text = quote.key
        numberLabel.text = "\(Double(round(quote.value * amount * 100) / 100))"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        shadowView.layer.cornerRadius = 6
        shadowView.layer.applySketchShadow(color: .black, alpha: 0.15, x: 0, y: 1, blur: 7, spread: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
