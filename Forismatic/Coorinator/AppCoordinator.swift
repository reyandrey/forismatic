//
//  AppCoordinator.swift
//  Forismatic
//
//  Created by Andrey on 05.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    private var window: UIWindow? { UIApplication.shared.keyWindow }
    private var quoteCoordinator: QuoteCoordinator?
    
    func start() {
        showSplash()
    }
    
}

private extension AppCoordinator {
    
    func showSplash() {
        let splashVC = SplashViewController.instantiate()
        splashVC.completionHandler = { [weak self] in
            self?.showMain()
        }
        self.window?.rootViewController = splashVC
    }
    
    func showMain() {
        quoteCoordinator = QuoteCoordinator()
        quoteCoordinator?.navigationController = NavigationController()
        quoteCoordinator?.start()
    }
    
}
