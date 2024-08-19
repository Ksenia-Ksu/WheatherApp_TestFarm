//
//  MainInteractor.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation
import CoreLocation

protocol WeatherInteractorProtocol {
    func fetchWeatherWithCity(name: String)
    func changeLanguage(on: Language)
}

final class MainInteractor: NSObject, WeatherInteractorProtocol {
    
    private let presenter: WeatherPresentationProtocol
    private let networkManager: NetworkServiceProtocol
    private let userDefaultsService: UserDefaultsStorageProtocol
    
    init(presenter: WeatherPresentationProtocol, networkingManager: NetworkServiceProtocol, userDefaultsService: UserDefaultsStorageProtocol ) {
        self.presenter = presenter
        self.networkManager = networkingManager
        self.userDefaultsService = userDefaultsService
    
        super.init()
    }
    
    
    func fetchWeatherWithCity(name: String) {
        let selectedLanguage = userDefaultsService.loadLanguage()
        self.networkManager.getWheatherBy(city: name, language: selectedLanguage){ response in
            switch response {
            case let .success(items):
                if !items.isEmpty {
                    self.presenter.presentData(items)
                } else {
                    self.presenter.presentData([])
                }
            case let .failure(error):
                self.presenter.presentError(error.localizedDescription)
            }
        }
    }
    
    func fetchWeatherWithCoordinates(lat: CLLocationDegrees, lon: CLLocationDegrees, language: Language) {
        self.networkManager.getWheatherBy(lat: lat, lon: lon, language: language) { response in
                switch response {
                case let .success(items):
                    self.presenter.presentData(items)
                case let .failure(error):
                    self.presenter.presentError(error.localizedDescription)
                }
            }
    }
    
    func changeLanguage(on: Language) {
        let city = self.userDefaultsService.loadLastCity()
        self.userDefaultsService.setNewLanguage(on)
        self.fetchWeatherWithCity(name: city)
    }
}

