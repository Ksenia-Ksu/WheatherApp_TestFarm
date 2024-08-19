//
//  URLBuilder.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation
import CoreLocation

public struct URLBuilder {
    static let api = "0f46e9b537dd8ead3545fea77235afad"
    public static func createURL(
        city: String,
        language: Language) -> String {
       
        let url = "http://api.openweathermap.org/data/2.5/forecast?q=\(city),ru&APPID=\(self.api)&units=metric&lang=\(language)"
        
        return url
    }
    

    public static func createURL(
        language: Language,
        longitude: CLLocationDegrees,
        latitude: CLLocationDegrees) -> String {
        
        let url = "http://api.openweathermap.org/data/2.5/forecast?ru&APPID=\(self.api)&lat=\(latitude)&lon=\(longitude)&units=metric&lang=\(language)"
        
        return url
    }
}
