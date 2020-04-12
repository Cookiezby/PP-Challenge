//
//  CurrencyListViewController.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class CurrencyTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = CurrencyTableViewModel()
    private var currencies = MutableProperty<[Currency]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        APIService.shared.fetchCurrencies { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let currencies):
                self.currencies.swap(currencies)
                self.tableView.reloadData()
                break
            case .failure:
                break
            }
        }
    }
    
    func bindViewModel() {
        currencies <~ viewModel.currencies.signal
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencyTableViewCell.description())
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CurrencyTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.description(), for: indexPath) as! CurrencyTableViewCell
        cell.setCurrency(currencies.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
}
