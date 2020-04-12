//
//  TranslationMock.swift
//  Le BaluchonTests
//
//  Created by Nicolas Lion on 21/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

class TranslationMock {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let error = TranslationError()
    
    static var translationCorrectData: Data? {
        let bundle = Bundle(for: TranslationMock.self)
        let url = bundle.url(forResource: "Translate", withExtension:
            "json")!
        return try! Data(contentsOf: url)
    }
    
    static let translationIncorrectData = "erreur".data(using: .utf8)!
}

class TranslationError: Error {}
