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
    private var viewModel = CurrencyTableViewModel(service: MockCurrencyListServiceImp())
    private var currencies = MutableProperty<[Currency]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        viewModel.fetchCurrencies()
    }
    
    func bindViewModel() {
        currencies <~ viewModel.currencies.signal
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencyTableViewCell.description())
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
}
