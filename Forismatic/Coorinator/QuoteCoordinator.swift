//
//  QuoteCoordinator.swift
//  Forismatic
//
//  Created by Andrey on 05.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import SafariServices
import UIKit

class QuoteCoordinator: Coordinator {
    
    private var window: UIWindow? { UIApplication.shared.keyWindow }
    var navigationController: NavigationController!
    
    func start() {
        guard let window = window, let snapshot = window.snapshotView(afterScreenUpdates: true) else { return }
        navigationController = NavigationController(rootViewController: initQuoteViewController())
        navigationController.view.addSubview(snapshot)
        window.rootViewController = navigationController
        UIView.animate(withDuration: 0.33, animations: {
            snapshot.alpha = 0
        }) { _ in
            snapshot.removeFromSuperview()
        }
    }
    
}

// MARK: Private

private extension QuoteCoordinator {
    
    func initQuoteViewController() -> QuoteViewController {
        let vc = QuoteViewController.instantiate()
        vc.viewModel = QuoteViewModel()
        vc.delegate = self
        return vc
    }
    
}

// MARK: QuoteViewControllerDelegate
extension QuoteCoordinator: QuoteViewControllerDelegate {
    
    func controller(_ controller: QuoteViewController, shouldOpenURL url: URL) {
        let svc = SFSafariViewController(url: url)
        svc.dismissButtonStyle = .done
        svc.preferredControlTintColor = UIColor(named: "primaryBlue")
        svc.title = "Forismatic"
        svc.modalPresentationStyle = .overFullScreen
        controller.present(svc, animated: true, completion: nil)
    }
    
}
