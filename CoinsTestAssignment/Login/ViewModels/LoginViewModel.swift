//
//  LoginViewModel.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import Foundation

let authKey = "isLogin"

protocol LoginViewModel {
    func didTapSignInButton (userName: String, password: String)
}

final class LoginViewModelImpl: LoginViewModel {
    
    private let router: LoginRouter
    private let userDefaults: UserDefaults
    
    init(router: LoginRouter) {
        self.router = router
        self.userDefaults = UserDefaults.standard
    }
    
    func didTapSignInButton (userName: String, password: String) {
        if userName == "1234" && password == "1234" {
            router.routeToCoinsVC()
            userDefaults.set(true, forKey: authKey)
            print("Success")
        } else {
            print("Error!!!")
        }
    }
}
