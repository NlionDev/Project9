//
//  ButtonStyle.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 23/05/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import Foundation
import UIKit

class ButtonStyle: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButtonStyle()
    }
    
    private func configureButtonStyle() {
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.borderWidth = 2
        layer.cornerRadius = 10
    }
}
