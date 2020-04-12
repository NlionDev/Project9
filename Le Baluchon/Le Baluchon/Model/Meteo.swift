//
//  Meteo.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 01/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation


struct Meteo: Decodable {
    let main: Main
    let name: String
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
