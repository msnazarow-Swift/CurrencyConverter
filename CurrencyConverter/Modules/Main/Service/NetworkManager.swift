//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 01.09.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    func getCurrencies(compition: @escaping (Result<[Currency], Error>) -> Void) {
        guard let url = URL(string: "https://api.currencyfreaks.com/supported-currencies") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let dataString = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                if let error = error {
                    print(String(describing: error))
                    compition(.failure(error))
                }
                return
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let currencies = try jsonDecoder.decode([Currency].self, from: dataString)
                compition(.success(currencies))
            } catch let DecodingError.dataCorrupted(context) {
                print("data corrupted:", context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func getImagesFromCurrencies(currencies: [Currency], complition: @escaping (_ row: Int, _ data: Data) -> Void) {
        currencies.enumerated().forEach { index, currency in
            if let url = URL(string: (currency.icon)) {
                let imageTask = URLSession.shared.dataTask(with: url) {data, _, _ in
                    if let data = data {
                        complition(index, data)
                    } else {
                        print("Error")
                    }
                }
                imageTask.resume()
            }
        }
    }

    func getConvertion(
        from inputmoneyCode: String?,
        to outputmoneyCode: String?,
        complition: @escaping (Result<Convertion, Error>) -> Void
    ) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.currencyfreaks.com"
        components.path = "/latest"
        components.queryItems = [
            URLQueryItem(name: "apikey", value: "c45795e1dc0148a5a3593813316c1222"),
            URLQueryItem(name: "symbols", value: outputmoneyCode)
        ]
        guard let url = components.url else {
            print("URL error")
            return
        }
        let convertionTask = URLSession.shared.dataTask(with: url) {data, _, error in
            if let data = data {
                do {
                    let convert = try JSONDecoder().decode(Convertion.self, from: data)
                    complition(.success(convert))
                } catch {
                    complition(.failure(error))
                }
            }
        }
        convertionTask.resume()
    }
}
