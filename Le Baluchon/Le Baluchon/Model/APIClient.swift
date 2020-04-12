//
//  APIClient.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 01/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

class APIClient {
    
    init(session: URLSession) {
        self.session = session
    }
    
    //MARK: - Properties
    
    var session = URLSession(configuration: .default)
    
    //MARK: - Methods
    
    func request(from route: Router, completion: @escaping (Result<Data, Error>) -> Void) {
        if let urlString = URL(string: route.url) {
            var request = URLRequest(url: urlString)
            request.httpMethod = route.httpMethod
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    completion(.success(data))
                }
                if let error = error {
                    completion(.failure(error))
                    return
                }
            }
            
            task.resume()
        }
    }
}

enum Router {
    case exchange
    case weather(CityId)
    case time(TimeZone)
    case translation(String)
    
    var url: String {
        switch self {
        case .exchange: return "http://data.fixer.io/api/latest?access_key=\(key)"
        case .weather(let city): return "http://api.openweathermap.org/data/2.5/weather?id=\(city.rawValue)&APPID=\(key)&units=metric"
        case .time(let timeZone): return "http://api.timezonedb.com/v2.1/get-time-zone?key=\(key)&format=json&by=zone&zone=\(timeZone.rawValue)"
        case .translation(let text): return "https://translation.googleapis.com/language/translate/v2?key=\(key)&q=\(text)&target=fr"
        }
    }
    
    var key: String {
        switch self {
        case .exchange: return "9cd1f7cf683f5c79c1d6bc1cc29598f6"
        case .weather: return "1ec6cee579e1d9dd8db62dfb56b71057"
        case .time: return "S1TXRVY7SETA"
        case.translation: return "AIzaSyARuR7LnxIFVO6HzvWO0ngsHkJI4pVAdTQ"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .exchange: return "POST"
        case .weather: return "POST"
        case .time: return "POST"
        case .translation: return "GET"
        }
    }
    
    enum CityId: String {
        case Montpellier = "2992165"
        case NewYork = "5128581"
    }
    
    enum TimeZone: String {
        case Montpellier = "Europe/Paris"
        case NewYork = "America/New_York"
    }

}

