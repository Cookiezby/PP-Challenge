//
//  ViewController.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/08.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import UIKit


class CurrencyRateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    private let viewModel = CurrencyRateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchRate()
    }
    
    func setupTableView() {
         tableView.register(UINib(nibName: "CurrencyRateTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencyRateTableViewCell.description())
    }

    @IBAction func currencyButtonTapped(_ sender: Any) {
        guard let vc = UIStoryboard.load(.currencyList) as? CurrencyTableViewController else { return }
        let navi = UINavigationController(rootViewController: vc)
        present(navi, animated: true, completion: nil)
    }
}

extension CurrencyRateViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateTableViewCell.description(), for: indexPath) as! CurrencyRateTableViewCell
        return cell
    }
}
