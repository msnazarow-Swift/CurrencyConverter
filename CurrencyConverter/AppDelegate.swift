//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by out-nazarov2-ms on 22.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let mainViewContoller = MainViewController()
    mainViewContoller.configurator = MainConfigurator()
    let navViewContorller = UINavigationController(rootViewController: mainViewContoller)
    window?.makeKeyAndVisible()
    window?.rootViewController = navViewContorller
    return true
  }

  // MARK: UISceneSession Lifecycle

}
