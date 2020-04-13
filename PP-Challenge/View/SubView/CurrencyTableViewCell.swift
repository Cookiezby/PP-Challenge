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
    @IBOutlet weak var checkMark: UIImageView!
    
    func setCurrency(_ currency: Currency) {
        checkMark.isHidden = EnvironmentData.shared.currentCurrency != currency.name
        nameLabel.text = currency.name
        descriptionLabel.text = currency.detail
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorInset = .zero
    }
}
