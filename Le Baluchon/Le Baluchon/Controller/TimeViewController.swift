//
//  TimeViewController.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 04/04/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {

    
    //MARK: - Properties

    private let timeRepo = TimeRepositoryImplementation(apiClient: .init(session: .init(configuration: .default)))
    
    var mtpTime = ""
    var nycTime = ""
    
    //MARK: - Outlets
    
    @IBOutlet weak private var nycCityLabel: UILabel!
    @IBOutlet weak private var mtpCityLabel: UILabel!
    @IBOutlet weak private var mtpTimeLabel: UILabel!
    @IBOutlet weak private var nycTimeLabel: UILabel!
    @IBOutlet weak private var mtpTimeIcon: UIImageView!
    @IBOutlet weak private var nycTimeIcon: UIImageView!
    @IBOutlet weak private var timeActivityIndicator: UIActivityIndicatorView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTime()
        self.updateTimeForMtp()
        self.updateTimeForNyc()
    }
    
    //MARK: - Methods
    
    private func updateTimeForMtp() {
        timeRepo.getTime(timezone: .Montpellier) { result in
            switch result {
            case .success(let time):
                self.getMTPTime(time: time)
                self.mtpTimeLabel.text = self.mtpTime
                self.updateTimeIcon(currentHour: self.mtpTime, image: self.mtpTimeIcon)
                self.showTime()
            case .failure(_):
                self.presentAlert(alertTitle: "Error", message: "The time download failed.", actionTitle: "OK")
            }
        }
    }
    
    private func updateTimeForNyc() {
        timeRepo.getTime(timezone: .NewYork) { result in
            switch result {
            case .success(let time):
                self.getNYCTime(time: time)
                self.nycTimeLabel.text = self.nycTime
                self.updateTimeIcon(currentHour: self.nycTime, image: self.nycTimeIcon)
                self.showTime()
            case .failure(_):
                self.presentAlert(alertTitle: "Error", message: "The time download failed.", actionTitle: "OK")
            }
        }
    }
    
    private func getMTPTime(time: Time) {
        let date = time.formatted
        let cutDate = String(date.suffix(9))
        mtpTime = String(cutDate.prefix(6))
    }
    
    private func getNYCTime(time: Time) {
        let date = time.formatted
        let cutDate = String(date.suffix(9))
        nycTime = String(cutDate.prefix(6))
    }
    
    private func updateTimeIcon(currentHour: String, image: UIImageView) {
        let stringHour = String(currentHour.prefix(3))
        let hour = (stringHour as NSString).integerValue
        if hour >= 5 && hour < 8 {
            image.image = #imageLiteral(resourceName: "sunrise")
        } else if hour >= 8 && hour < 17 {
            image.image = #imageLiteral(resourceName: "sun")
        } else if hour >= 17 && hour < 20 {
            image.image = #imageLiteral(resourceName: "breakofday")
        } else if hour < 5 || hour >= 20 {
            image.image = #imageLiteral(resourceName: "night")
        }
    }
    
    private func hideTime() {
        timeActivityIndicator.isHidden = false
        mtpTimeLabel.isHidden = true
        mtpTimeIcon.isHidden = true
        mtpCityLabel.isHidden = true
        nycTimeLabel.isHidden = true
        nycTimeIcon.isHidden = true
        nycCityLabel.isHidden = true
    }
    
    private func showTime() {
        timeActivityIndicator.isHidden = true
        mtpTimeLabel.isHidden = false
        mtpTimeIcon.isHidden = false
        mtpCityLabel.isHidden = false
        nycTimeLabel.isHidden = false
        nycTimeIcon.isHidden = false
        nycCityLabel.isHidden = false
    }
}
