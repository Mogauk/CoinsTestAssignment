//
//  AppDelegate.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var loginRouter: LoginRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        loginRouter = LoginRouterImpl(navigationController: navigationController)
        
        let isLogin = UserDefaults.standard.bool(forKey: authKey)
        if isLogin {
            print("isLogin")
            loginRouter?.routeToCoinsVC()
        } else {
            print("is not login")
            loginRouter?.routeToLogin()
        }
        
        return true
    }
}

