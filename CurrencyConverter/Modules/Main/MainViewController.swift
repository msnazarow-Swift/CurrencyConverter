//
//  MainViewController.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 23.08.2021.
//

import UIKit

protocol MainViewProtocol: class {
  func setInputMoneyTitle(value: String);
  func setOutputMoneyTitle(value:String);
  func setMoneyOutputAmountLabel(value: String);
  func openAboutView()
  func changeInputMoney()
  func changeOutputMoney()
  func showPickerView()
  func hidePickerView()
  func setImageForRow(row :Int, data: Data)
  func textFieldDidEndEditing(_ textField: UITextField)
  func setMoneyInputAmount(value: String)
  func setInfoLabel(value: String)
}
class MainViewController: UIViewController, MainViewProtocol {

  var presenter: MainPresenterProtocol!
  var configurator: MainConfiguratorProtocol!
  let mainView = MainView()

  // MARK: Life Circle

  override func loadView() {
    view = mainView
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configurator.configure(with: self)
    presenter.viewDidLoad()
    mainView.delegate = self
    // TODO: - Почему не работает из класса?
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    mainView.addGestureRecognizer(tapRecognizer)
    // Do any additional setup after loading the view.
  }

  // MARK: - Protocol implementation

  func setMoneyOutputAmountLabel(value: String) {
    mainView.setMoneyOutputAmountLabel(value: value)
  }

  func openAboutView(){
    presenter.openAboutView()
  }

  func changeInputMoney(){
    self.presenter.changeInputMoney()
  }

  func changeOutputMoney(){
    presenter.changeOutputMoney()
  }

  func showPickerView(){
    mainView.showPickerView()
  }
  func  hidePickerView(){
    mainView.hidePickerView()
  }
  func setImageForRow(row: Int, data: Data) {
    mainView.currencyView.images[row] = UIImage(data: data)!.trimmingTransparentPixels()
  }
  @objc func hideKeyboard(_ sender: UITapGestureRecognizer){
    mainView.endEditing(true)
  }
  func setInputMoneyTitle(value: String) {
    mainView.setInputMoneyTitle(value: value)
  }
  func setMoneyInputAmount(value: String) {
    mainView.setMoneyInputAmount(value: value)
  }
  func setOutputMoneyTitle(value: String) {
    mainView.setOutputMoneyTitle(value: value)
  }
  func setInfoLabel(value: String){
    mainView.setInfoLabel(value: value)
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, let value = Double(text) {
      presenter.setAmount(with: value)
    }
  }
}
