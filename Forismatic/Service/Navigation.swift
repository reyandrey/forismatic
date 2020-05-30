//
//  Navigation.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

class Navigation {
    
    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        get { return window.rootViewController }
        set { window?.rootViewController = newValue }
    }
    
    
    init(with window: UIWindow) {
        self.window = window
    }
    
}

extension Navigation {
    
    func start() {
        let splashVC = SplashViewController.instantiate()
        let mainNC = UINavigationController(rootViewController: splashVC)
        mainNC.setNavigationBarHidden(true, animated: false)
        let quoteVC = QuoteViewController.instantiate()
        splashVC.completionHandler = { [weak self] in
            mainNC.pushViewController(quoteVC, animated: true)
        }
        show(mainNC)
    }
    
    // nav
    
    func push(_ viewController: UIViewController, from source: UIViewController, animated: Bool = true) {
        guard let souruceNavigationController = source.navigationController else {
            print("\(#function) - error")
            return
        }
        souruceNavigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(_ viewController: UIViewController, animated: Bool = true) {
        guard let sourceNavigationController = viewController.navigationController else {
            print("\(#function) - error")
            return
        }
        sourceNavigationController.popViewController(animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = false, completion: (()->())? = nil) {
        guard let rootViewController = rootViewController else {
            print("\(#function) - error")
            return
        }
        rootViewController.present(viewController, animated: animated, completion: completion)
    }

    func showAlert(withTitle title: String, message: String, completionHandler: (() -> ())? = nil) {
        rootViewController?.presentAlert(withTitle: title, message: message, completionHandler: completionHandler)
    }
    
    func showErrorAlert(message: String, completionHandler: (() -> ())? = nil) {
        rootViewController?.presentAlert(withTitle: "Ошибка", message: message, completionHandler: completionHandler)
    }
    
}



private extension Navigation {
    
    func show(_ vc: UIViewController?) {
        guard let vc = vc else { return }
        self.rootViewController = vc
    }
    
}


