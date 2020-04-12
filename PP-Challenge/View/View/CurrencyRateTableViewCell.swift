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
    
    func setQuote(_ quote: Quote, amount: Double) {
        nameLabel.text = quote.key
        numberLabel.text = "\(quote.value * amount)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
