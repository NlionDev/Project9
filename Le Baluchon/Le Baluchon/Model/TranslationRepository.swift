//
//  TranslationService.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 04/04/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

protocol TranslationRepository {
    func getTranslation(callback: @escaping (Result<TranslationResponse, Error>) -> Void)
}

class TranslationRepositoryImplementation: TranslationRepository {
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    //MARK: - Properties
    
    private var apiClient: APIClient
    var textForTranslation = ""
    
    //MARK: - Methods
    
    func getTranslation(callback: @escaping (Result<TranslationResponse, Error>) -> Void) {
        apiClient.request(from: .translation(textForTranslation)) { (result) in
            switch result {
            case .success(let data):
                do {
                    let translation = try JSONDecoder().decode(TranslationResponse.self, from: data)
                    DispatchQueue.main.async {
                        callback(.success(translation))
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

