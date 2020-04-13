//
//  SelectCurrencyViewController.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/11.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class SelectCurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = SelectCurrencyTableViewModel(service: CurrencyServiceImpl())
    private var currencies = MutableProperty<[Currency]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
        viewModel.fetchCurrencies()
    }
    
    func bindViewModel() {
        currencies <~ viewModel.currencies.signal
        currencies.signal.observe(on: UIScheduler()).observeValues { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencyTableViewCell.description())
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectCurrency(currencies.value[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
