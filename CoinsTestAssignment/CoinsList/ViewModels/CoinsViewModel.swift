//
//  CoinsViewModel.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/25/23.
//

import Foundation
import UIKit

struct CoinModel: Decodable {
    
    struct Coin: Decodable {
        let name: String
        let symbol: String
        let market_data: MarketData
    }
    
    struct MarketData: Decodable {
        let price_usd: Double
        let percent_change_usd_last_1_hour: Double
        var percent1Hchange: String {
            return String(format: "%.2f", percent_change_usd_last_1_hour) + " %"
        }
        let percent_change_usd_last_24_hours: Double
        var percent24Hchange: String {
            return String(format: "%.2f", percent_change_usd_last_24_hours) + " %"
        }
    }
    
    let data: Coin
}

class CoinsViewModel {
    
    private let dispatchGroup = DispatchGroup()
    private let queue = DispatchQueue(label: "coins", attributes: .concurrent)
    
    private let router: LoginRouter
    private let userDefaults: UserDefaults
    private let network: NetworkClient
    
    var answers: [CoinModel] = []
    
    init(
        router: LoginRouter,
        network: NetworkClient
    ) {
        self.router = router
        self.userDefaults = UserDefaults.standard
        self.network = network
    }
    
    func loadCoins(completion: @escaping () -> Void) {
        let coins = ["btc", "eth", "tron", "luna", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
        
        queue.async(group: dispatchGroup) { [weak self] in
            coins.forEach { coin in
                let stringURL = "https://data.messari.io/api/v1/assets/\(coin)/metrics"
                
                self?.network.loadCoins(stringUrl: stringURL) { [weak self] result in
                    switch result {
                    case.success(let model):
                        self?.answers.append(model)
                    case .failure(let error):
                        switch error {
                        case .invalidUrl:
                            print("wrong url")
                        case .decodingError:
                            print("failed to decode \(coin)")
                        }
                        break
                    }
                    self?.dispatchGroup.leave()
                }
                self?.dispatchGroup.enter()
            }
        }
        
        queue.async(group: dispatchGroup) { [weak self] in
            self?.dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
    func routeToCoinsDetails(index: Int) {
        let coin = answers[index]
        router.routeToCoinsDetails(coin: coin)
        
    }
    
    func signOut() {
        userDefaults.set(false, forKey: authKey)
        router.routeToLogin()
    }
    
    func sortPrice() {
        answers = answers.sorted {$0.data.market_data.percent_change_usd_last_24_hours > $1.data.market_data.percent_change_usd_last_24_hours}
    }
}
