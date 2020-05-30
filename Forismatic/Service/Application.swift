//
//  App.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import UIKit

class Application {
    
    private var navigation: Navigation?
    private static let _app: Application  = Application()
    private init() { }
    
}

extension Application {
    
    static func start(with window: UIWindow?) {
        guard let w = window else { return }
        _app.navigation = Navigation(with: w)
        _app.navigation?.start()
    }
    
}
