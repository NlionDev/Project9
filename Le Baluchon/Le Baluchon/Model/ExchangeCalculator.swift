//
//  Calculator.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 11/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

class ExchangeCalculator {
    
    //MARK: - Properties
    
    var usdRates = 0.0000
    var lastUpdate = ""
    var textFieldText = ""
    
    //MARK : - Methods
    
    func calculateExchange() -> String {
        var returnedString = ""
        if let eurDouble = Double(textFieldText) {
            let result = eurDouble * usdRates
            
            let usdString = String(format: "%.2f", result)
            returnedString = usdString
        }
        return returnedString
    }
}
