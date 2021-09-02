//
//  AboutPresenter.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import Foundation

protocol AboutPresenterProtocol: class {
    var router: AboutRouterProtocol! { set get }
    func configureView()
    func closeButtonClicked()
    func urlButtonClicked(with urlString: String?)
}

class AboutPresenter: AboutPresenterProtocol {
    
      weak var view: AboutViewProtocol!
      var interactor: AboutInteractorProtocol!
      var router: AboutRouterProtocol!
      
      required init(view: AboutViewProtocol) {
          self.view = view
      }
      
      // MARK: - AboutPresenterProtocol methods
      
      func configureView() {
          view.setUrlButtonTitle(with: interactor.urlRatesSource)
      }
      
      func closeButtonClicked() {
          router.closeCurrentViewController()
      }
      
      func urlButtonClicked(with urlString: String?) {
          if let url = urlString {
              interactor.openUrl(with: url)
          }
      }
}
