//
//  Conversion.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 01/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation


struct Conversion: Decodable {
    
    let base: String
    let rates: [String: Double]
    let date: String
    
}
