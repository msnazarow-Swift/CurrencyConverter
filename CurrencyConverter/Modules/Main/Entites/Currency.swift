//
//  Currency.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 28.08.2021.
//

import UIKit

struct Currency: Codable {
  let currencyCode: String
  let currencyName: String
  let icon: String
  let status: String
  let availableInHistoricalDataFrom: String
  let availableInHistoricalDataTill: String
  let countryCode: String
  let countryName: String
}
