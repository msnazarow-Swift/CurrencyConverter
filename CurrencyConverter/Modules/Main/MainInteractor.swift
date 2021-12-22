//
//  MainInteractor.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 23.08.2021.
//

import UIKit

protocol MainInteractorProtocol: class {
  func getCurrencies(complition: @escaping (Result<[Currency], Error>) -> Void)
}
// swiftlint:disable implicitly_unwrapped_optional
class MainInteractor: MainInteractorProtocol {
  weak var presenter: MainPresenterProtocol!

  init(presenter: MainPresenterProtocol) {
    self.presenter = presenter
  }

  func getImages() {
  }
  func getCurrencies(complition: @escaping (Result<[Currency], Error>) -> Void) {
    NetworkManager.shared.getCurrencies(compition: complition)
  }
}
