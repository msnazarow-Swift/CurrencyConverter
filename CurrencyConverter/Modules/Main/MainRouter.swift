//
//  MainRouter.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 23.08.2021.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    func openAboutView()
}

class MainRouter: MainRouterProtocol {
    weak var viewController: MainViewController!

    init(viewController: MainViewController) {
        self.viewController = viewController
    }

    func openAboutView() {
        let aboutView = AboutViewController()
        aboutView.configurator = AboutConfigurator()
        viewController.navigationController?.pushViewController(aboutView, animated: true)
    }
}
