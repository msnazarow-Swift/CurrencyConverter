//
//  AboutRouter.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import Foundation

protocol AboutRouterProtocol: class {
    func closeCurrentViewController()
}

class AboutRouter: AboutRouterProtocol {
    
    weak var viewController: AboutViewController!
    
    init(viewController: AboutViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.navigationController?.popViewController(animated: true)
    }
}
