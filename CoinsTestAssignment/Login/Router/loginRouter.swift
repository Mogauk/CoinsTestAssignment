//
//  LoginRouter.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import UIKit

protocol LoginRouter {
    func routeToLogin()
    func routeToCoinsVC()
    func routeToCoinsDetails(coin: CoinModel)
}

final class LoginRouterImpl: LoginRouter {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToLogin() {
        let viewModel = LoginViewModelImpl(router: self)
        let loginVC = LoginViewController(viewModel: viewModel)
        navigationController?.viewControllers = [loginVC]
    }
    
    func routeToCoinsVC() {
        let viewModel = CoinsViewModel(router: self, network: NetworkClient())
        let coinsVC = CoinsViewController(viewModel: viewModel)
        navigationController?.viewControllers = [coinsVC]
    }
    
    func routeToCoinsDetails(coin: CoinModel) {
        let viewModel = DetailCoinViewModel(coin: coin)
        let detailCoinVC = DetailCoinViewController(viewModel: viewModel)
        navigationController?.pushViewController(detailCoinVC, animated: true)
    }
}
