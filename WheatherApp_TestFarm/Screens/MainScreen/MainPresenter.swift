//
//  MainPresenter.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

protocol WeatherPresentationProtocol {
    func presentData(_ response: [WeatherModel])
    func presentError()
}

final class MainPresenter: WeatherPresentationProtocol {
    
    weak var controller: DisplayWheather?
    
    func presentData(_ response: [WeatherModel]) {
        var viewModels: [WeatherModel] = []
        for model in response {
            let viewModel = WeatherModel(conditionId: model.conditionId,
                                         cityName: model.cityName,
                                         temperature: model.temperature + "°",
                                         maxTemp: model.maxTemp + "°",
                                         minTemp: model.minTemp + "°",
                                         wind: model.wind + " м/c",
                                         date: Formatter.dateFormatter(string: model.date),
                                         description: model.description
            )
            viewModels.append(viewModel)
        }
        controller?.displayFetchedModels(viewModels)
    }
    
    func presentError() {
        self.controller?.displayError()
    }
    
}

