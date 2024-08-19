//
//  MainModuleBuilder.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import UIKit

struct MainModuleBuilder {
    func build(context: String?) -> UIViewController {
        let networkService = NetworkService()
       
        let presenter = MainPresenter()
        let userDefaults = UserDefaultsStorageService()

        let interactor = MainInteractor(presenter: presenter, networkingManager: networkService, userDefaultsService: userDefaults)
        if let city = context {
            let vc = MainViewController(interactor: interactor, openWithCity: city)
            presenter.controller = vc
            return vc
        } else {
            let vc = MainViewController(interactor: interactor, openWithCity: nil)
            presenter.controller = vc
            return vc
        }
    }
}

