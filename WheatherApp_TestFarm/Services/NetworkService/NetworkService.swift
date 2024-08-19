//
//  NetworkService.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func getWheatherBy(city name: String,
                       language: Language,
                       completion: @escaping (Result<[WeatherModel], Error>) -> Void)
    
    func getWheatherBy(lat: CLLocationDegrees,
                       lon: CLLocationDegrees,
                       language: Language,
                       completion: @escaping (Result<[WeatherModel], Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let queue = DispatchQueue(label: "Network queue", attributes: [.concurrent])
    
    func getWheatherBy(city name: String, language: Language, completion: @escaping (Result<[WeatherModel], Error>) -> Void) {
        
        queue.async {
            let url = URLBuilder.createURL(city: name, language: language)
            guard let url = URL(string: url)   else { return }
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request) { data, _, error in
                if let data = data {
                    let items = self.parseJSONData(data)
                    DispatchQueue.main.async {
                        completion(.success(items))
                    }
                }
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
            }
            task.resume()
        }
        
    }
    
    func getWheatherBy(lat: CLLocationDegrees, lon: CLLocationDegrees, language: Language, completion: @escaping (Result<[WeatherModel], Error>) -> Void) {
        
        let url = URLBuilder.createURL(language: language, longitude: lon, latitude: lat)
        
        guard let url = URL(string: url)   else { return }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, _, error in
            if let data = data {
                let items = self.parseJSONData(data)
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error as! NetworkError))
                }
                return
            }
        }
        task.resume()
        
    }
    
    private func parseJSONData(_ weatherData: Data) -> [WeatherModel] {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherWeek.self, from: weatherData)
            let list = decodedData.list
            
            let filtered = list.filter {$0.dtTxt.contains("21:00:00")}
            
            var models: [WeatherModel] = []
            filtered.forEach {
                let model = WeatherModel(conditionId: $0.weather[0].id,
                                         cityName: decodedData.city.name,
                                         temperature: String(Int($0.main.temp)),
                                         maxTemp: String(Int($0.main.tempMax)),
                                         minTemp: String(Int($0.main.tempMin)),
                                         wind: String($0.wind.speed),
                                         date: $0.dtTxt,
                                         description: $0.weather[0].description)
                models.append(model)
            }
            return models
        } catch {
            print(error)
            return []
        }
    }
}
