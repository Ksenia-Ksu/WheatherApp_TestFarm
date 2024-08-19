//
//  LanguageSelectionService.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

protocol LocalizationManaging {
    static func selectedLanguage() -> Language
}

final class LocalizationManager: LocalizationManaging {
    static func selectedLanguage() -> Language {
        guard let language = Locale.preferredLanguages.first else {
            return .en
        }

        let locale = Locale(identifier: language)
        let regionCode = locale.region?.identifier

        if regionCode == "RU" {
            return .ru
        } else {
            return .en
        }
    }
}


