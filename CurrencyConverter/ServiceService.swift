//
//  ServiceService.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import Foundation
import UIKit

protocol ServerServiceProtocol: AnyObject {
    var urlRatesSource: String { get }
    func openUrl(with urlString: String)
}

class ServerService: ServerServiceProtocol {
    var urlRatesSource: String {
        return "https://api.intra.42.fr"
    }

    func openUrl(with urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
