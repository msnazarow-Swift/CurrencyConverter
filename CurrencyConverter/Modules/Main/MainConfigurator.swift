//
//  MainConfigurator.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 23.08.2021.
//

import Foundation
protocol MainConfiguratorProtocol {
  func configure(with viewController: MainViewController)
}

class MainConfigurator: MainConfiguratorProtocol {
  func configure(with viewController: MainViewController) {
    let router = MainRouter(viewController: viewController)
    let presenter = MainPresenter(view: viewController, router: router)
    let interactor = MainInteractor(presenter: presenter)
    viewController.presenter = presenter
    presenter.interactor = interactor
    presenter.router = router
    viewController.mainView.currencyView.presenter = presenter
    presenter.currencyPickerView = viewController.mainView.currencyView
  }
}
