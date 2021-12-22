//
//  UITextFieldExtention.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 26.08.2021.
//

import Foundation
import UIKit
extension UITextField {
    func addDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
    }
    @objc func dismissKeyboard() {
        self.resignFirstResponder()
    }
}
