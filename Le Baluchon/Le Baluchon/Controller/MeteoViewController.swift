//
//  MeteoViewController.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 02/04/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {

    //MARK: - Properties
    
    private let meteoRepo = MeteoRepositoryImplementation(apiClient: .init(session: .init(configuration: .default)))
    
    private var tempMTP = 0.0
    private var nameMTP = ""
    private var weatherMTP = ""
    private var weatherMTPId = 0
    private var tempNYC = 0.0
    private var nameNYC = ""
    private var weatherNYC = ""
    private var weatherNYCId = 0
    
    //MARK: - Outlets
    
    @IBOutlet weak private var nameMTPLabel: UILabel!
    @IBOutlet weak private var tempMTPLabel: UILabel!
    @IBOutlet weak private var weatherMTPLabel: UILabel!
    @IBOutlet weak private var weatherMTPIcon: UIImageView!
    @IBOutlet weak private var nameNYCLabel: UILabel!
    @IBOutlet weak private var tempNYCLabel: UILabel!
    @IBOutlet weak private var weatherNYCLabel: UILabel!
    @IBOutlet weak private var weatherNYCIcon: UIImageView!
    @IBOutlet weak private var tempMTPTitle: UILabel!
    @IBOutlet weak private var weatherMTPTitle: UILabel!
    @IBOutlet weak private var tempNYCTitle: UILabel!
    @IBOutlet weak private var weatherNYCTitle: UILabel!
    @IBOutlet weak private var meteoActivityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideMeteo()
        self.updateMeteoForMtp()
        self.updateMeteoForNyc()
    }
    
    //MARK: - Methods
    
    private func updateMeteoForMtp() {
        meteoRepo.downloadMeteo(city: .Montpellier) { result in
            switch result {
            case .success(let meteo):
                let meteoMTP = meteo
                self.getMeteoForMTP(meteo: meteoMTP)
                self.nameMTPLabel.text = self.nameMTP
                self.weatherMTPLabel.text = self.weatherMTP
                self.updateWeatherIcon(image: self.weatherMTPIcon, id: self.weatherMTPId)
                self.showMeteo()
            case .failure(_):
                self.presentAlert(alertTitle: "Error", message: "The Meteo download failed.", actionTitle: "OK")
            }
            
        }
    }
    
    private func updateMeteoForNyc() {
        meteoRepo.downloadMeteo(city: .NewYork.self) { result in
            switch result {
            case .success(let meteo):
                let meteoNYC = meteo
                self.getMeteoForNYC(meteo: meteoNYC)
                self.nameNYCLabel.text = self.nameNYC
                self.weatherNYCLabel.text = self.weatherNYC
                self.updateWeatherIcon(image: self.weatherNYCIcon, id: self.weatherNYCId)
                self.showMeteo()
            case .failure(_):
                self.presentAlert(alertTitle: "Error", message: "The Meteo download failed.", actionTitle: "OK")
            }
        }
    }
    
    private func getMeteoForMTP(meteo: Meteo) {
        let temp = meteo.main.temp 
        tempMTP = temp
        let tempMTPString = String(format: "%.0f", tempMTP)
        tempMTPLabel.text = "\(tempMTPString)°C"
        
        nameMTP = "Montpellier"
        if let meteoResponse = meteo.weather.first {
            weatherMTP = meteoResponse.description
            weatherMTPId = meteoResponse.id
        }
    }
    
    private func getMeteoForNYC(meteo: Meteo) {
        let temp = meteo.main.temp
        tempNYC = temp
        let tempNYCString = String(format: "%.0f", tempNYC)
        tempNYCLabel.text = "\(tempNYCString)°C"
        
        nameNYC = meteo.name
        if let meteoResponse = meteo.weather.first {
            weatherNYC = meteoResponse.description
            weatherNYCId = meteoResponse.id
        }
    }
    
    private func updateWeatherIcon(image: UIImageView, id: Int) {
        switch id {
        case 200...232:
            image.image = #imageLiteral(resourceName: "storm")
        case 300...321:
            image.image = #imageLiteral(resourceName: "drizzle")
        case 500...531:
            image.image = #imageLiteral(resourceName: "rain")
        case 600...622:
            image.image = #imageLiteral(resourceName: "snow")
        case 701...781:
            image.image = #imageLiteral(resourceName: "wind")
        case 800:
            image.image = #imageLiteral(resourceName: "sun")
        case 801...804:
            image.image = #imageLiteral(resourceName: "clouds")
        default:
            image.image = #imageLiteral(resourceName: "interrogation")
        }
    }

    private func hideMeteo() {
        meteoActivityIndicator.isHidden = false
        tempMTPLabel.isHidden = true
        tempNYCLabel.isHidden = true
        tempMTPTitle.isHidden = true
        tempNYCTitle.isHidden = true
        nameNYCLabel.isHidden = true
        nameMTPLabel.isHidden = true
        weatherMTPLabel.isHidden = true
        weatherNYCLabel.isHidden = true
        weatherNYCTitle.isHidden = true
        weatherMTPTitle.isHidden = true
        weatherNYCIcon.isHidden = true
        weatherMTPIcon.isHidden = true
    }
    
    private func showMeteo() {
        meteoActivityIndicator.isHidden = true
        tempMTPLabel.isHidden = false
        tempNYCLabel.isHidden = false
        tempMTPTitle.isHidden = false
        tempNYCTitle.isHidden = false
        nameNYCLabel.isHidden = false
        nameMTPLabel.isHidden = false
        weatherMTPLabel.isHidden = false
        weatherNYCLabel.isHidden = false
        weatherNYCTitle.isHidden = false
        weatherMTPTitle.isHidden = false
        weatherNYCIcon.isHidden = false
        weatherMTPIcon.isHidden = false
    }

}
