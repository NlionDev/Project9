//
//  ExchangeMock.swift
//  Le BaluchonTests
//
//  Created by Nicolas Lion on 14/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

class ExchangeMock {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let error = ExchangeError()
    
    static var exchangeCorrectData: Data? {
        let bundle = Bundle(for: ExchangeMock.self)
        let url = bundle.url(forResource: "Exchange", withExtension:
            "json")!
        return try! Data(contentsOf: url)
    }
    
    static let exchangeIncorrectData = "erreur".data(using: .utf8)!
}

class ExchangeError: Error {}
