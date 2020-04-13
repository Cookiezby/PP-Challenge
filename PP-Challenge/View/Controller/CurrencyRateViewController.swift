//
//  ViewController.swift
//  PP-Challenge
//
//  Created by 朱冰一 on 2020/04/08.
//  Copyright © 2020 朱冰一. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import MBProgressHUD

class CurrencyRateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var selectCurrencyView: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    private let viewModel = CurrencyRateViewModelImpl(service: MockCurrencyRateService())
    private var errorView = Bundle.loadView(fromNib: .errorView, withType: ErrorView.self)
    private var currencyRate = MutableProperty<CurrencyRate?>(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupErrorView()
        setupSelectCurrencyButton()
        setupTextField()
        setupTableView()
        bind(viewModel)
        viewModel.fetchCurrencyRate()
    }
        
    func bind(_ viewModel: CurrencyRateViewModel) {
        currencyRate <~ viewModel.currencyRate.signal.skipNil().disOnMainWith(self)
        
        currencyRate.signal.skipNil().disOnMainWith(self).observeValues { [weak self] (rate) in
            guard let self = self else { return }
            self.currencyLabel.text = rate.source
            self.errorView.isHidden = true
            self.tableView.reloadData()
        }
        
        viewModel.amount.signal.skipRepeats().disOnMainWith(self).observeValues { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        textField.reactive.continuousTextValues.observeValues { (value) in
            let amount = Double(value) ?? 0
            viewModel.updateAmount(amount)
        }
        
        viewModel.error.signal.skipNil().disOnMainWith(self).observeValues { [weak self] (error) in
            guard let self = self else { return }
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
        errorView.pinToView(view)
        errorView.isHidden = true
        errorView.reloadButton.reactive.controlEvents(.touchUpInside).observe(on: UIScheduler()).observeValues { [weak self] (_) in
            guard let self = self else { return }
            self.viewModel.fetchCurrencyRate()
        }
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CurrencyRateTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencyRateTableViewCell.description())
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    func setupSelectCurrencyButton() {
        selectCurrencyView.layer.cornerRadius = 4
        selectCurrencyView.layer.applySketchShadow(color: .black, alpha: 0.15, x: 0, y: 1, blur: 7, spread: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyButtonTapped(_:)))
        selectCurrencyView.addGestureRecognizer(tap)
    }
    
    func setupTextField() {
        textField.delegate = self
        textField.adjustsFontSizeToFitWidth = true
    }

    @objc func selectCurrencyButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.load(fromStoryboard: .currencyList, withType: SelectCurrencyViewController.self)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension CurrencyRateViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyRate.value?.quotes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateTableViewCell.description(), for: indexPath) as! CurrencyRateTableViewCell
        if let quote = currencyRate.value?.quotes[indexPath.row] {
            cell.setQuote(quote, amount: viewModel.amount.value)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textField.resignFirstResponder()
    }
}

extension CurrencyRateViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        
        if (textField.text == nil || textField.text?.count == 0) && string == "." {
            return false
        }
        
        var dotCount = 0
        let charArray = Array(textField.text ?? "")
        charArray.forEach { (c) in
            if c == "." {
                dotCount += 1
            }
        }
        if dotCount == 1 && string == "." {
            return false
        }
        
        if dotCount == 1 {
            if let strs = textField.text?.split(separator: "."), strs.count == 2, let last = strs.last, last.count >= 2 {
                return false
            }
        }
        
        return true
    }
}
