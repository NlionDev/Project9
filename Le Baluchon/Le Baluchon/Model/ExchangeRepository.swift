//
//  ExchangeService.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 14/03/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

protocol ExchangeRepository {
    func getExchange(callback: @escaping (Result<Conversion, Error>) -> Void)
}

class ExchangeRepositoryImplementation: ExchangeRepository {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    //MARK: - Properties
    
    private var apiClient: APIClient
    
    //MARK: - Methods
    
    func getExchange(callback: @escaping (Result<Conversion, Error>) -> Void) {
        apiClient.request(from: .exchange) { (result) in
            switch result {
            case .success(let data):
                do {
                    let conversion = try JSONDecoder().decode(Conversion.self, from: data)
                    DispatchQueue.main.async {
                        callback(.success(conversion))
                    }
                } catch {
                    DispatchQueue.main.async {
                        callback(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    callback(.failure(error))
                }
            }
        }
    }
}





