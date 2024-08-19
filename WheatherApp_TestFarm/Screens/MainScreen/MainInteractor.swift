//
//  MainInteractor.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation
import CoreLocation

protocol WeatherInteractorProtocol {
    func fetchWeatherWithCity(name: String, language: Language)
    func fetchWeatherWithCoordinates(lat: CLLocationDegrees, lon: CLLocationDegrees, language: Language)
    func loadLocation()
}

final class MainInteractor: NSObject, WeatherInteractorProtocol {
    
    private let presenter: WeatherPresentationProtocol
    private let networkManager: NetworkServiceProtocol
    private let locationManager: LocationUpdating
    private let language: Language?
    
    init(presenter: WeatherPresentationProtocol, networkingManager: NetworkServiceProtocol, locationManager: LocationUpdating,  language: Language) {
        self.presenter = presenter
        self.networkManager = networkingManager
        self.locationManager = locationManager
        self.language = language
    
        super.init()
    
    }
    
    
    func fetchWeatherWithCity(name: String, language: Language) {
        self.networkManager.getWheatherBy(city: name, language: language){ response in
            switch response {
            case let .success(items):
                if !items.isEmpty {
                    self.presenter.presentData(items)
                } else {
                    self.presenter.presentError()
                }
            case .failure(_):
                self.presenter.presentError()
            }
        }
    }
    
    func fetchWeatherWithCoordinates(lat: CLLocationDegrees, lon: CLLocationDegrees, language: Language) {
        self.networkManager.getWheatherBy(lat: lat, lon: lon, language: language) { response in
                switch response {
                case let .success(items):
                    self.presenter.presentData(items)
                case let .failure(error):
                    self.presenter.presentError()
                }
            }
    }
    
    func loadLocation() {
        self.locationManager.startLocate()
    }
    
}

// MARK: - CLLocationManagerDelegate
extension MainInteractor: LocationUpdateDelegate {
    
    func didUpdateLocation(_ location: CLLocationCoordinate2D) {
        if let language = self.language {
            self.fetchWeatherWithCoordinates(lat: location.latitude, lon: location.longitude, language: language)
        } else {
            let language = LocalizationManager.selectedLanguage()
            self.fetchWeatherWithCoordinates(lat: location.latitude, lon: location.longitude, language: language)
        }
    }
    
}

