//
//  AppDelegate.swift
//  RequestManager
//
//  Created by Andrey on 30.05.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        
        return true
    }



}

