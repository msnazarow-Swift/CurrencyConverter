//
//  MainView.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 02.09.2021.
//

import UIKit
// swiftlint:disable implicitly_unwrapped_optional
class MainView: UIView {
    weak var delegate: MainViewProtocol!
    let inputMoneyTextField: UITextField = {
        let textField = UITextField()
        textField.text = "100"
        textField.font = textField.font?.withSize(55)
        textField.textColor = .purple
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        textField.addDoneOnKeyboard()
        return textField
    }()
    let outputMoneyLabel: UILabel = {
        let label = UILabel()
        label.text = "200"
        label.textColor = .white
        label.font = label.font.withSize(55)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .horizontal)
        return label
    }()
    let inputMoneyButton: UIButton =
    {
        let button = UIButton()
        button.setTitle("RUB", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(55)
        button.addTarget(self, action: #selector(changeInputMoney), for: .touchUpInside)
        button.titleLabel?.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
        }
        return button
    }()
    let outputMoneyButton: UIButton = {
        let button = UIButton()
        button.setTitle("EUR", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(55)
        button.addTarget(self, action: #selector(changeOutputMoney), for: .touchUpInside)
        button.titleLabel?.snp.makeConstraints { maker in
            maker.height.equalToSuperview()
        }
        return button
    }()
    let convertionLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Biches"
        label.textAlignment = .center
        return label
    }()
    let infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.addTarget(self, action: #selector(openAboutView), for: .touchUpInside)
        return button
    }()
    lazy var vStack: UIStackView = {
        let firstHorisontalStack = UIStackView()
        firstHorisontalStack.axis = .horizontal
        firstHorisontalStack.backgroundColor = .white
        firstHorisontalStack.addArrangedSubview(inputMoneyTextField)
        firstHorisontalStack.addArrangedSubview(inputMoneyButton)

        let secondHorisontalStack = UIStackView()
        secondHorisontalStack.axis = .horizontal
        secondHorisontalStack.addArrangedSubview(outputMoneyLabel)
        secondHorisontalStack.addArrangedSubview(outputMoneyButton)

        let thirdHorisontalStack = UIStackView()
        thirdHorisontalStack.axis = .horizontal
        thirdHorisontalStack.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        thirdHorisontalStack.addArrangedSubview(convertionLabel)
        thirdHorisontalStack.addArrangedSubview(infoButton)

        let vstack = UIStackView(arrangedSubviews: [firstHorisontalStack, secondHorisontalStack, thirdHorisontalStack])
        vstack.axis = .vertical
        vstack.distribution = .fill
        return vstack
    }()

    let currencyView = CurrencyPickerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        addSubview(currencyView)
        self.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(40)
            make.left.equalTo(safeAreaLayoutGuide).offset(10)
            make.right.equalTo(safeAreaLayoutGuide).inset(10)
        }
        inputMoneyTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    @objc func openAboutView() {
        delegate.openAboutView()
    }
    @objc func changeInputMoney() {
        delegate.changeInputMoney()
    }
    @objc func changeOutputMoney() {
        delegate.changeOutputMoney()
    }

    // MARK: - PickerView
    func showPickerView() {
        currencyView.becomeFirstResponder()
    }
    func  hidePickerView() {
        currencyView.resignFirstResponder()
    }
    // MARK: - Setters
    func setInputMoneyTitle(value: String) {
        inputMoneyButton.setTitle(value, for: .normal)
    }
    func setOutputMoneyTitle(value: String) {
        outputMoneyButton.setTitle(value, for: .normal)
    }
    func setMoneyOutputAmountLabel(value: String) {
        outputMoneyLabel.text = value
    }
    func setMoneyInputAmount(value: String) {
        inputMoneyTextField.text = value
    }
    func setInfoLabel(value: String) {
        convertionLabel.text = value
    }
}

extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.textFieldDidEndEditing(textField)
    }
}
