//
//  TimeService.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 04/04/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

protocol TimeRepository {
    func getTime(timezone: Router.TimeZone, callback: @escaping (Result<Time, Error>) -> Void)
}

class TimeRepositoryImplementation: TimeRepository {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    //MARK: - Properties
    
    private var apiClient: APIClient
    
    //MARK: - Methods
    
    func getTime(timezone: Router.TimeZone, callback: @escaping (Result<Time, Error>) -> Void) {
        apiClient.request(from: .time(timezone)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let time = try JSONDecoder().decode(Time.self, from: data)
                    DispatchQueue.main.async {
                        callback(.success(time))
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




