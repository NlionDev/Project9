//
//  Le_BaluchonTests.swift
//  Le BaluchonTests
//
//  Created by Nicolas Lion on 14/03/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import XCTest
@testable import Le_Baluchon

class Le_BaluchonTests: XCTestCase {

    
    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    //MARK: - Test for Meteo

    func testDownloadMeteoShouldPostFailedCallbackIfError() {
        // Given
        let session = MockURLSession(data: nil, response: nil, error: WeatherMock.error)
        let weather = MeteoRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure.")
        weather.downloadMeteo(city: .Montpellier) { (result) in
            // Then
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadMeteoShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let session = MockURLSession(data: WeatherMock.weatherIncorrectData, response: WeatherMock.responseOK, error: nil)
        let weather = MeteoRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for failure")
        weather.downloadMeteo(city: .Montpellier) { (result) in
            // Then
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadMeteoForMtpShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let session = MockURLSession(data: WeatherMock.weatherCorrectData, response: WeatherMock.responseOK, error: nil)
        let weather = MeteoRepositoryImplementation(apiClient: .init(session: session))
        
        // When
        let expectation = self.expectation(description: "Wait for Callback")
        weather.downloadMeteo(city: .Montpellier) { result in
            //Then
            if case .success(let meteo) = result {
                XCTAssertNotNil(meteo)
                if let meteoResponse = meteo.weather.first {
                    let temp = meteo.main.temp
                    let description = meteoResponse.description
                    let id = meteoResponse.id
                    XCTAssertEqual(temp, 15.45)
                    XCTAssertEqual(description, "clear sky")
                    XCTAssertEqual(id, 800)
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    //MARK: - Test for Exchange

    func testDownloadExchangeShouldPostFailedCallbackIfError() {
        // Given
        let session = MockURLSession(data: nil, response: nil, error: ExchangeMock.error)
        let exchange = ExchangeRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure")
        exchange.getExchange { (result) in
            // Then
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadExchangeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let session = MockURLSession(data: ExchangeMock.exchangeIncorrectData, response: ExchangeMock.responseOK, error: nil)
        let exchange = ExchangeRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure")
        exchange.getExchange { (result) in
            // Then
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadExchangeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let session = MockURLSession(data: ExchangeMock.exchangeCorrectData, response: ExchangeMock.responseOK, error: nil)
        let exchange = ExchangeRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Success")
        exchange.getExchange { (result) in
            //Then
            if case .success(let conversion) = result {
                XCTAssertNotNil(conversion)
                let usdRates = conversion.rates["USD"]
                let date = conversion.date
                XCTAssertEqual(date, "2019-05-14")
                XCTAssertEqual(usdRates, 1.120837)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    //MARK: - Test for ExchangeCalculator

    func testCalculateExchangeShouldReturnCorrectString() {
        // Given
        let calculator = ExchangeCalculator()
        calculator.usdRates = 1.120837
        calculator.textFieldText = "50"
        // When
        let correctString = calculator.calculateExchange()
        //Then
        XCTAssertEqual(correctString, "56.04")

    }

    //MARK: - Test for Time

    func testDownloadTimeShouldPostFailedCallbackIfError() {
        // Given
        let session = MockURLSession(data: nil, response: nil, error: TimeMock.error)
        let time = TimeRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure")
        time.getTime(timezone: .Montpellier) { (result) in
            // Then
            if case .failure(let error) =  result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadTimeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let session = MockURLSession(data: TimeMock.timeIncorrectData, response: TimeMock.responseOK, error: nil)
        let time = TimeRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure")
        time.getTime(timezone: .Montpellier) { (result) in
            // Then
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadTimeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let session = MockURLSession(data: TimeMock.timeCorrectData, response: TimeMock.responseOK, error: nil)
        let time = TimeRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Success")
        time.getTime(timezone: .Montpellier) { (result) in
            //Then
            if case .success(let time) = result {
                XCTAssertNotNil(time)
                let mtpTime = time.formatted
                XCTAssertEqual(mtpTime, "2019-05-14 16:47:09")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    //MARK: - Test for Translation

    func testDownloadTranslationShouldPostFailedCallbackIfError() {
        // Given
        let session = MockURLSession(data: nil, response: nil, error: TranslationMock.error)
        let translation = TranslationRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure")
        translation.getTranslation { (result) in
            // Then
            if case .failure(let error) =  result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }

    func testDownloadTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let session = MockURLSession(data: TranslationMock.translationIncorrectData, response: TranslationMock.responseOK, error: nil)
        let translation = TranslationRepositoryImplementation(apiClient: .init(session: session))

        // When
        let expectation = self.expectation(description: "Wait for Failure")
        translation.getTranslation { (result) in
            // Then
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 0.1)
    }
    
    func testDownloadTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let session = MockURLSession(data: TranslationMock.translationCorrectData, response: TranslationMock.responseOK, error: nil)
        let translation = TranslationRepositoryImplementation(apiClient: .init(session: session))
        
        // When
        let expectation = self.expectation(description: "Wait for Success")
        translation.getTranslation { (result) in
            //Then
            if case .success(let translation) = result {
                XCTAssertNotNil(translation)
                if let translationResponse = translation.data.translations.first {
                    let translatedText = translationResponse.translatedText
                    XCTAssertEqual(translatedText, "Bonjour")
                    expectation.fulfill()
                }
            }
        }
        waitForExpectations(timeout: 0.1)
    }


}
