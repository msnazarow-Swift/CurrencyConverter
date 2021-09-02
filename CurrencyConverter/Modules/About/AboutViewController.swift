//
//  AboutViewController.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import UIKit
import SnapKit
protocol AboutViewProtocol: class {
    func setUrlButtonTitle(with title: String)
    func urlButtonClicked(_ sender: UIButton)
}

class AboutView: UIView {
    weak var delegate: AboutViewProtocol?
    let urlButton :UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(red: 0.24, green: 0.54, blue: 0.97, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(urlButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let greetingsLabel : UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.text = "Привет медвед!"
        label.numberOfLines = 0;
        return label
    }()
    
    let thanksLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0;
        label.font = label.font.withSize(30)
        label.textAlignment = .center
        label.text = "Переходи по ссылке, а то получишь по жопе!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        addSubview(urlButton);
        addSubview(greetingsLabel)
        addSubview(thanksLabel)
        
        urlButton.snp.makeConstraints { (maker) in
            maker.top.equalTo(safeAreaLayoutGuide).inset(150)
            maker.centerX.equalToSuperview()
        }
        thanksLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(urlButton.snp.top)
            maker.left.equalToSuperview().inset(40)
            maker.right.equalToSuperview().inset(40)
        }
        greetingsLabel.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.bottom.equalTo(thanksLabel.snp.top)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUrlButtonTitle(with title: String) {
        urlButton.setTitle(title, for: .normal)
    }
    @objc func urlButtonClicked(_ sender: UIButton) {
        delegate?.urlButtonClicked(sender)
    }
}
class AboutViewController: UIViewController, AboutViewProtocol {
    var presenter: AboutPresenterProtocol!
    var configurator: AboutConfiguratorProtocol!
    var aboutView = AboutView()
    
    @objc func closeButtonClicked(_ sender: UIBarButtonItem) {
        presenter.closeButtonClicked()
    }
    
    func urlButtonClicked(_ sender: UIButton) {
        presenter.urlButtonClicked(with: sender.currentTitle)
    }
            
    func setUrlButtonTitle(with title: String) {
        aboutView.setUrlButtonTitle(with: title)
    }
    
    override func loadView() {
        view = aboutView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            initialize()
            configurator.configure(with: self)
            presenter.configureView()
        }
    
    func initialize() {
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action:  #selector(closeButtonClicked))
        closeButton.title = "Close"
        navigationItem.leftBarButtonItem = closeButton;
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
