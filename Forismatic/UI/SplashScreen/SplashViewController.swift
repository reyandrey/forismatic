//
//  SplashViewController.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController, Storyboardable {
    typealias T = SplashViewController
    static var storyboardName: String { return "SplashScreen" }
    

    @IBOutlet weak var logoView: UIView!
    var completionHandler: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logoView.layer.opacity = 0
        UIView.animate(withDuration: 1.5, animations: {
            self.logoView.layer.opacity = 100
            self.logoView.layoutIfNeeded()
        }) { _ in
            self.completionHandler?()
        }
    }

}
