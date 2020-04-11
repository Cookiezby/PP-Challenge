//
//  ViewController.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/08.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func currencyButtonTapped(_ sender: Any) {
        guard let vc = UIStoryboard.load(.currencyList) as? CurrencyListViewController else { return }
        present(vc, animated: true, completion: nil)
    }
}

