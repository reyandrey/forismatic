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
    

    @IBOutlet weak var logoLabelWhite: UILabel!
    @IBOutlet weak var logoLabelBlue: UILabel!
    var completionHandler: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.logoLabelWhite.alpha = 0
            self.logoLabelBlue.alpha = 1
            self.view.backgroundColor = .white
        }) { _ in
            self.completionHandler?()
        }
        
    }

}
