//
//  TimeMock.swift
//  Le BaluchonTests
//
//  Created by Nicolas Lion on 15/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

class TimeMock {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                            statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://fakeurl.com")!,
                                            statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    static let error = TimeError()
    
    static var timeCorrectData: Data? {
        let bundle = Bundle(for: TimeMock.self)
        let url = bundle.url(forResource: "Time", withExtension:
            "json")!
        return try! Data(contentsOf: url)
    }
    
    static let timeIncorrectData = "erreur".data(using: .utf8)!
}

class TimeError: Error {}
