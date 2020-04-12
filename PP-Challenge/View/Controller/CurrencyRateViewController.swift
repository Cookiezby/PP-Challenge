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

class CurrencyRateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var selectCurrencyView: UIView!
    
    private let viewModel = CurrencyRateViewModel()
    var currencyRate = MutableProperty<CurrencyRate?>(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextField()
        setupTableView()
        bind()
        viewModel.fetchRate()
    }
    
    func bind() {
        viewModel.currencyRate.signal.skipNil().observeValues { [weak self] (rate) in
            guard let self = self else { return }
            self.currencyRate.swap(rate)
            self.tableView.reloadData()
        }
        
        viewModel.amount.signal.skipRepeats().observeValues { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        
        textField.reactive.continuousTextValues.observeValues { [weak self] (value) in
            guard let self = self else { return }
            if let amount = Double(value) {
                self.viewModel.updateAmount(amount)
            }
        }
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "CurrencyRateTableViewCell", bundle: nil), forCellReuseIdentifier: CurrencyRateTableViewCell.description())
        tableView.separatorColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
    
    func setupButton() {
        selectCurrencyView.layer.cornerRadius = 4
        selectCurrencyView.layer.applySketchShadow(color: .black, alpha: 0.15, x: 0, y: 1, blur: 7, spread: 0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectCurrencyViewTapped(_:)))
        selectCurrencyView.addGestureRecognizer(tap)
    }
    
    func setupTextField() {
        textField.delegate = self
        textField.adjustsFontSizeToFitWidth = true
    }

    @objc func selectCurrencyViewTapped(_ sender: Any) {
        guard let vc = UIStoryboard.load(.currencyList) as? CurrencyTableViewController else { return }
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
            if let strs = textField.text?.split(separator: "."), strs.count == 2, let last = strs.last, last.count >= 5 {
                return false
            }
        }
        
        return true
    }
}
