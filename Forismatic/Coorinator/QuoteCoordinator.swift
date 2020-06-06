//
//  QuoteCoordinator.swift
//  Forismatic
//
//  Created by Andrey on 05.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

class QuoteCoordinator: Coordinator {
    
    private var window: UIWindow? { UIApplication.shared.keyWindow }
    var navigationController: UINavigationController!
    
    func start() {
        guard let window = window, let snapshot = window.snapshotView(afterScreenUpdates: true) else { return }
        navigationController = UINavigationController(rootViewController: initQuoteViewController())
        navigationController.view.addSubview(snapshot)
        window.rootViewController = navigationController
        UIView.animate(withDuration: 0.33, animations: {
            snapshot.alpha = 0
        }) { _ in
            snapshot.removeFromSuperview()
        }
    }
    
}

private extension QuoteCoordinator {
    
    func initQuoteViewController() -> QuoteViewController {
        let vc = QuoteViewController.instantiate()
        vc.viewModel = QuoteViewModel()
        return vc
    }
    
}
