//
//  CurrencyTableViewCell.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setCurrency(_ currency: Currency) {
        nameLabel.text = currency.name
        descriptionLabel.text = currency.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = .zero
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
