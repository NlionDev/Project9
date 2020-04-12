//
//  MeteoService.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 02/04/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

protocol MeteoRepository {
    func downloadMeteo(city: Router.CityId, callback: @escaping (Result<Meteo, Error>) -> Void)
}

class MeteoRepositoryImplementation: MeteoRepository {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    //MARK: - Properties
    
    private var apiClient: APIClient
    
    //MARK: - Methods
    
    func downloadMeteo(city: Router.CityId, callback: @escaping (Result<Meteo, Error>) -> Void) {
        apiClient.request(from: .weather(city)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let meteo = try JSONDecoder().decode(Meteo.self, from: data)
                        DispatchQueue.main.async {
                            callback(.success(meteo))
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
