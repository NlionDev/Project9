//
//  Translation.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 01/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation

struct TranslationResponse: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let translatedText: String
}
