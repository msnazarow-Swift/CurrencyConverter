//
//  Convertion.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 02.09.2021.
//

import Foundation

class Convertion: Codable {
  let date: String
  let base: String
  let rates: [String:String]
}
