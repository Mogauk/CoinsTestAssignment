//
//  NetworkClient.swift
//  CoinsTestAssignment
//
//  Created by Alexey on 1/26/23.
//

import UIKit

enum NetworkError: Error {
    case invalidUrl
    case decodingError
}

class NetworkClient {
    
    func loadCoins(
        stringUrl: String, completion: @escaping (Result<CoinModel, NetworkError>) -> Void
    ) {
        guard let url = URL(string:  stringUrl) else {
            completion(.failure(.invalidUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data,
                      let model = try? JSONDecoder().decode(CoinModel.self, from: data)
                else {
                    completion(.failure(.decodingError))
                    return
                }
                completion(.success(model))
            } .resume()
    }
}
