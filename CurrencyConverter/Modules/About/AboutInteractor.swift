//
//  AboutInteractor.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import Foundation

protocol AboutInteractorProtocol: AnyObject {
    var urlRatesSource: String { get }
    func openUrl(with urlString: String)
}

class AboutInteractor: AboutInteractorProtocol {
    weak var presenter: AboutPresenterProtocol!
    let serverService: ServerServiceProtocol = ServerService()

    required init(presenter: AboutPresenterProtocol) {
        self.presenter = presenter
    }

    var urlRatesSource: String {
        return serverService.urlRatesSource
    }

    func openUrl(with urlString: String) {
        serverService.openUrl(with: urlString)
    }
}
