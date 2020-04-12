//
//  FakeResponseData.swift
//  Le BaluchonTests
//
//  Created by Nicolas Lion on 09/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

class WeatherMock {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                     statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                     statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let error = WeatherError()
    
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: WeatherMock.self)
        let url = bundle.url(forResource: "Weather", withExtension:
            "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
}

class WeatherError: Error {}

