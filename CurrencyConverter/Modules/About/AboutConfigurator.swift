//
//  AboutConfigurator.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import Foundation

protocol AboutConfiguratorProtocol {
  func configure(with viewController: AboutViewController)
}

class AboutConfigurator: AboutConfiguratorProtocol {
  func configure(with viewController: AboutViewController) {
    let presenter = AboutPresenter(view: viewController)
    let interactor = AboutInteractor(presenter: presenter)
    let router = AboutRouter(viewController: viewController)

    viewController.presenter = presenter
    presenter.interactor = interactor
    presenter.router = router
  }
}
