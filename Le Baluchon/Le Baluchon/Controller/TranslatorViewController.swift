//
//  TranslatorViewController.swift
//  Le Baluchon
//
//  Created by Nicolas Lion on 02/04/2019.
//  Copyright © 2019 Nicolas Lion. All rights reserved.
//

import UIKit

class TranslatorViewController: UIViewController {

    //MARK: - Properties

    private let translationRepo = TranslationRepositoryImplementation(apiClient: .init(session: .init(configuration: .default)))
    private var translatedText = ""
    
    //MARK: - Outlets
    
    @IBOutlet weak private var translatorTextView: UITextView!
    @IBOutlet weak var translatedTextLabel: LabelStyle!
    
    //MARK: - Actions
    
    @IBAction private func dismissKeyboard(_ sender: Any) {
        translatorTextView.resignFirstResponder()
    }
    
    @IBAction private func translateText(_ sender: Any) {
        if translatorTextView.text.isEmpty {
            presentAlert(alertTitle: "Error", message: "Please enter a text to convert", actionTitle: "OK")
        } else {
            translationRepo.textForTranslation = translatorTextView.text
            self.translate()
        }
    }
    
    //MARK: - Methods
    
    private func translate() {
        translationRepo.getTranslation { result in
            switch result {
            case .success(let translationResponse):
                self.getTranslatedText(translation: translationResponse)
                self.translatedTextLabel.text = self.translatedText
            case .failure(_):
                self.presentAlert(alertTitle: "Error", message: "The translation failed.", actionTitle: "OK")
            }
        }
    }
    
    private func getTranslatedText(translation: TranslationResponse) {
        if let translationResponse = translation.data.translations.first {
            translatedText = translationResponse.translatedText
        }
        
    }
   
}
