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
import MBProgressHUD

class SelectCurrencyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = SelectCurrencyViewModelImpl(service: MockSelectCurrencyService())
    private let currencies = MutableProperty<[Currency]>([])
    private let errorView = Bundle.loadView(fromNib: .errorView, withType: ErrorView.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupErrorView()
        setupTableView()
        bind(viewModel)
        viewModel.fetchCurrencies()
    }
    
    func bind(_ viewModel: SelectCurrencyViewModel) {
        currencies <~ viewModel.currencies.signal
        currencies.signal.disOnMainWith(self).observeValues { [weak self] _ in
            guard let self = self else { return }
            self.errorView.isHidden = true
            self.tableView.reloadData()
        }
        
        viewModel.error.signal.skipNil().disOnMainWith(self).observeValues { (error) in
            if let error = error as? APIError {
                switch error {
                case .invalidResponse, .networkError:
                    self.errorView.isHidden = false
                }
            }
        }
        
        viewModel.hudHidden.signal.disOnMainWith(self).observeValues { [weak self] (hidden) in
            guard let self = self else { return }
            if hidden {
                MBProgressHUD.hide(for: self.view, animated: true)
            } else {
                MBProgressHUD.showAdded(to: self.view, animated: true)
            }
        }
    }
    
    func setupErrorView() {
        view.addSubview(errorView)
        errorView.pinToView(tableView)
        errorView.isHidden = true
        errorView.reloadButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self] (_) in
            guard let self = self else { return }
            self.viewModel.fetchCurrencies()
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
