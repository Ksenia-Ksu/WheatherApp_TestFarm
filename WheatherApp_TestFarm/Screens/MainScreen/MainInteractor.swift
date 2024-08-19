//
//  MainInteractor.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation
import CoreLocation
import UIKit

protocol WeatherInteractorProtocol {
    func fetchWeatherWithCity(name: String)
    func changeLanguage()
}

final class MainInteractor: NSObject, WeatherInteractorProtocol {
    
    private let presenter: WeatherPresentationProtocol
    private let networkManager: NetworkServiceProtocol
    
    init(presenter: WeatherPresentationProtocol, networkingManager: NetworkServiceProtocol) {
        self.presenter = presenter
        self.networkManager = networkingManager
        super.init()
    }
    
    
    func fetchWeatherWithCity(name: String) {
        let selectedLanguage = LocalizationManager.selectedLanguage()
        
        self.networkManager.getWheatherBy(city: name, language: selectedLanguage){ response in
            switch response {
            case let .success(items):
                if !items.isEmpty {
                    self.presenter.presentData(items, language: selectedLanguage)
                } else {
                    self.presenter.presentData([], language: selectedLanguage)
                }
            case let .failure(error):
                self.presenter.presentError(error.localizedDescription)
            }
        }
    }
    
    func changeLanguage() {
        if let url = URL(string:UIApplication.openSettingsURLString) {
              if UIApplication.shared.canOpenURL(url) {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
              }
          }
    }
}

