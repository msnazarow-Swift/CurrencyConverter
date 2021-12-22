//
//  MainPresenter.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 23.08.2021.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func openAboutView()
    func changeInputMoney()
    func changeOutputMoney()
    func currencyPickerViewCancelButtonClicked()
    func currencyPickerViewApplyButtonClicked(selectedRow: Int)
    func setCurrencies(currencies: [Currency])
    func setArraySize(_ size: Int)
    func setAmount(with amount: Double)
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol!
    var interactor: MainInteractorProtocol!
    weak var currencyPickerView: CurrencyPickerViewProtocol!
    var router: MainRouterProtocol!

    let inputCurrencyPickerViewTitle = "Choose input currency"
    let outputCurrencyPickerViewTitle = "Choose output currency"
    var amount: Double?

    init(view: MainViewProtocol, router: MainRouterProtocol) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
        if let title = StorageService.shared.savedInputCurrency() {
            view.setInputMoneyTitle(value: title)
        }
        if let title = StorageService.shared.savedOutputCurrency() {
            view.setOutputMoneyTitle(value: title)
        }
        if let number = StorageService.shared.savedInputValue() {
            let title = String(number)
            view.setMoneyInputAmount(value: title)
        }
        interactor.getCurrencies { result in
            switch result {
            case .success(let currencies):
                self.setCurrencies(currencies: currencies)
                self.setArraySize(currencies.count)
                NetworkManager.shared.getImagesFromCurrencies(currencies: currencies) { row, data in
                    self.view.setImageForRow(row: row, data: data)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        setNewConvertedMoney()
    }

    func openAboutView() {
        router.openAboutView()
    }

    func changeInputMoney() {
        return // TODO: - free api limit only for USD
        let code = StorageService.shared.savedInputCurrency()
        let index = self.currencyPickerView.currencies?.firstIndex { currency -> Bool in
            currency.currencyCode == code
        } ?? 0
        DispatchQueue.main.async {
            self.currencyPickerView.setRowAt(row: index)
        }
        self.currencyPickerView.reload()
        self.currencyPickerView.title = inputCurrencyPickerViewTitle
        self.currencyPickerView.mode = .input
        self.view.showPickerView()
    }

    func changeOutputMoney() {
        DispatchQueue.main.async {
            let index = self.currencyPickerView.currencies?.firstIndex { currency -> Bool in
                currency.currencyCode == StorageService.shared.savedOutputCurrency()
            } ?? 0
            self.currencyPickerView.setRowAt(row: index)
        }
        self.currencyPickerView.reload()
        self.currencyPickerView.mode = .output
        self.currencyPickerView.title = outputCurrencyPickerViewTitle
        self.view.showPickerView()
    }

    func currencyPickerViewCancelButtonClicked() {
        view.hidePickerView()
    }

    func currencyPickerViewApplyButtonClicked(selectedRow: Int) {
        view.hidePickerView()
        if let code = currencyPickerView.currencies?[selectedRow].currencyCode {
            switch currencyPickerView.mode {
            case .input:
                view.setInputMoneyTitle(value: code)
                StorageService.shared.saveInputCurrency(with: code)
            case .output:
                view.setOutputMoneyTitle(value: code)
                StorageService.shared.saveOutputCurrency(with: code)
            }
            setNewConvertedMoney()
        }
    }

    func setNewConvertedMoney() {
        guard
            let input = StorageService.shared.savedInputCurrency(),
            let output = StorageService.shared.savedOutputCurrency(),
            let amount = StorageService.shared.savedInputValue() else { return }
        NetworkManager.shared.getConvertion(from: input, to: output ) { result in
            switch result {
            case .success(let convertion):
                if let value = convertion.rates[output], let rate = Double(value) {
                    DispatchQueue.main.async {
                        self.view.setMoneyOutputAmountLabel(value: String(rate * amount))
                        self.view.setInfoLabel(value: "1 \(input) = \(rate) \(output)")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func setCurrencies(currencies: [Currency]) {
        self.currencyPickerView.currencies = currencies
    }

    func setArraySize(_ size: Int) {
        currencyPickerView.setArraySize(size)
    }

    func setInitialCurrency(countryCode: String) {
        DispatchQueue.main.async {
            let index = self.currencyPickerView.currencies?.firstIndex { currency -> Bool in
                currency.countryCode == countryCode
            } ?? 0
            self.currencyPickerView.setRowAt(row: index)
            self.currencyPickerView.reload()
        }
    }

    func setAmount(with amount: Double) {
        self.amount = amount
        StorageService.shared.saveInputValue(with: amount)
        setNewConvertedMoney()
    }
}
