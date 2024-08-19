//
//  WheatherModel.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: String
    let maxTemp: String
    let minTemp: String
    let wind: String
    let date: String
    let description: String
    
    var conditionTitle: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}

extension WeatherModel {
    private enum Keys {
        static let conditionId = "conditionId"
        static let cityName = "cityName"
        static let temperature = "temperature"
        static let maxTemp = "maxTemp"
        static let minTemp = "minTemp"
        static let wind = "wind"
        static let date = "date"
        static let description = "description"
    }
}

