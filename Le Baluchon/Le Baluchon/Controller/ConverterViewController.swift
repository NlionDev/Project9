//
//  ConverterViewController.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 15/03/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {

    
    //MARK: - Properties
   
    private let exchangeRepo = ExchangeRepositoryImplementation(apiClient: .init(session: .init(configuration: .default)))
    private let calculator = ExchangeCalculator()
    
    //MARK: - Outlets
    
    @IBOutlet weak private var usdLabel: UILabel!
    @IBOutlet weak private var eurTextField: UITextField!
    @IBOutlet weak private var updateLabel: UILabel!
    @IBOutlet weak private var converterActivityIndicator: UIActivityIndicatorView!
    

    //MARK: - Actions
    
    @IBAction private func didTapConvertButton() {
        if let eurValue = eurTextField.text {
            if eurValue.isEmpty {
                presentAlert(alertTitle: "Error", message: "Please enter a value to convert", actionTitle: "OK")
            } else {
              calculator.textFieldText = eurValue
              usdLabel.text = calculator.calculateExchange()
                
            }
        }
    }
    
    @IBAction private func dismissKeyboard(_ sender: Any) {
        eurTextField.resignFirstResponder()
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.converterActivityIndicator.isHidden = false
        
        self.downloadExchange()
    }
    
    //MARK: - Methods
    
    private func downloadExchange() {
        exchangeRepo.getExchange { result in
            switch result {
            case .success(let conversion):
                self.getRates(conversion: conversion)
                self.printLastUpdate()
                self.converterActivityIndicator.isHidden = true
            case .failure(_):
                self.presentAlert(alertTitle: "Error", message: "The rates download failed", actionTitle: "OK")
            }
        }
    }
    
    private func getRates(conversion: Conversion) {
        if let usd = conversion.rates["USD"] {
           calculator.usdRates = usd
        }
        calculator.lastUpdate = conversion.date
    }
    
    private func printLastUpdate() {
        updateLabel.text = "Last Update : \(calculator.lastUpdate)"
    }

}

