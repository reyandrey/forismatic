//
//  NavigationController.swift
//  Forismatic
//
//  Created by Andrey on 06.06.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController{

    private lazy var titleView = NavigationTitleView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(false, animated: false)
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor(named: "primaryBlue")
        self.delegate = self
    }

}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.titleView = titleView
    }
}
