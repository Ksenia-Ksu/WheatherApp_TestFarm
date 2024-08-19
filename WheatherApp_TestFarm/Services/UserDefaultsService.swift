//
//  UserDefaultsService.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

protocol UserDefaultsStorageProtocol {
    func saveLast(city: String)
    func loadLastCity() -> String
    func setNewLanguage(_ locale: Language)
    func loadLanguage() -> Language
}

final class UserDefaultsStorageService: UserDefaultsStorageProtocol {
   
    
    enum Key: String {
        case city
        case locale
    }
    
    private let userDefaults = UserDefaults.standard
    
    func saveLast(city: String) {
        userDefaults.set(city, forKey: Key.city.rawValue)
    }
    
    func loadLastCity() -> String {
        guard let city = userDefaults.string(forKey: Key.city.rawValue) else {
            return "moscow".localized
        }
        
        return city
    }
    
    func setNewLanguage(_ locale: Language) {
        userDefaults.set(locale.rawValue, forKey: Key.locale.rawValue)
    }
    
    func loadLanguage() -> Language {
        guard let language = userDefaults.string(forKey: Key.locale.rawValue) else { return .ru }
        return Language(rawValue: language) ?? .ru
    }
}
