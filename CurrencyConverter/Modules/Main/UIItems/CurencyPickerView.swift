//
//  CurrencyPickerView.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 23.08.2021.
//

import UIKit

enum Modes {
    case input
    case output
}

protocol CurrencyPickerViewProtocol: AnyObject {
    var currencies: [Currency]? { get set }
    func reload()
    var images: [UIImage?] { get set }
    func setArraySize(_ size: Int)
    func setRowAt(row: Int)
    var mode: Modes { get set }
}

protocol CurrencyPickerViewDelegate: AnyObject {
    func currencyPickerViewCancelButtonClicked()
    func currencyPickerViewApplyButtonClicked(selectedRow: Int)
}

class CurrencyPickerView: UITextField, CurrencyPickerViewProtocol {
    var mode = Modes.input
    var presenter: MainPresenterProtocol!
    var currencies: [Currency]?
    var images: [UIImage?] = []
    let pickerHeight = CGFloat(40.0)

    let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply", for: .normal)
        button.addTarget(self, action: #selector(applyButtonClicked), for: .touchUpInside)
        return button
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose input currency"
        return label
    }()

    lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let apply = UIBarButtonItem(customView: applyButton)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(customView: cancelButton)
        let title = UIBarButtonItem(customView: titleLabel)
        toolBar.setItems([cancel, space, title, space, apply], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }()

    lazy var stackView = { (row: Int) -> UIView in
        let view = UIView()
        let label = UILabel()
        let code = UILabel()
        let imageView = UIImageView()
        guard let currencies = self.currencies else {
            return view
        }
        label.text = currencies[row].currencyName
        label.numberOfLines = 0
        code.text = currencies[row].currencyCode
        imageView.image = self.images[row]
        if let image = imageView.image {
            let aspect = image.size.width / image.size.height
            imageView.snp.makeConstraints { maker in
                maker.height.equalTo(self.pickerHeight - 5)
                maker.width.equalTo((self.pickerHeight - 5) * aspect)
            }
        }
        view.addSubview(code)
        view.addSubview(label)
        view.addSubview(imageView)
        code.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.left.equalTo(code.snp.right).offset(30)
            make.right.equalTo(imageView.snp.left)
            make.top.equalToSuperview()
        }
        return view
    }
    let pickerView = UIPickerView()

    private let componentIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        inputView = pickerView
        inputAccessoryView = toolBar
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reload() {
        pickerView.reloadAllComponents()
    }

    // MARK: - Setters
    func setArraySize(_ size: Int) {
        images = [UIImage?](repeating: nil, count: size)
    }

    func setRowAt(row: Int) {
        self.pickerView.selectRow(row, inComponent: 0, animated: true)
    }

    // MARK: - Actions
    @objc func cancelButtonClicked(_ sender: UIButton) {
        presenter.currencyPickerViewCancelButtonClicked()
    }

    @objc func applyButtonClicked(_ sender: UIButton) {
        presenter.currencyPickerViewApplyButtonClicked(selectedRow: pickerView.selectedRow(inComponent: componentIndex))
    }
}

extension CurrencyPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies?[row].currencyName
    }

    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        return stackView(row)
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets
        let width = UIScreen.main.bounds.size.width
        let left = insets?.left ?? 0
        let right = insets?.right ?? 0
        return width - left - right - 50
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerHeight
    }
}
