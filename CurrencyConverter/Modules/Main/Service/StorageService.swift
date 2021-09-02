//
//  StorageService.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 02.09.2021.
//
import  Foundation

protocol StorageServiceProtocol: AnyObject {
    func savedInputValue() -> Double?
    func saveInputValue(with value: Double?)
    func savedInputCurrency() -> String?
    func saveInputCurrency(with currency: String)
    func savedOutputCurrency() -> String?
    func saveOutputCurrency(with currency: String)
}

class StorageService: StorageServiceProtocol {
  private let inputMoneyKey = "MC.inputMoneyKey"
  private let outputMoneyKey = "MC.outputMoneyKey"
  private let inputMoneyAmountKey = "MC.inputMoneyAmountKey"
  static let shared = StorageService()
  func savedInputValue() -> Double? {
   return UserDefaults.standard.double(forKey: inputMoneyAmountKey)
  }

  func saveInputValue(with value: Double?) {
    UserDefaults.standard.setValue(value, forKey: inputMoneyAmountKey)
  }

  func savedInputCurrency() -> String? {
    return UserDefaults.standard.string(forKey: inputMoneyKey)
  }

  func saveInputCurrency(with currency: String) {
    UserDefaults.standard.setValue(currency, forKey: inputMoneyKey)
  }

  func savedOutputCurrency() -> String? {
    return UserDefaults.standard.string(forKey: outputMoneyKey)
  }

  func saveOutputCurrency(with currency: String) {
    UserDefaults.standard.setValue(currency, forKey: outputMoneyKey)
  }


}
