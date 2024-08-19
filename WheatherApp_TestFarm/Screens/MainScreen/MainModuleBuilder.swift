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
        let location = LocationManager()

        let interactor = MainInteractor(presenter: presenter, networkingManager: networkService, locationManager: location, language: .ru)
        if context != nil {
            let vc = MainViewController(interactor: interactor)
            presenter.controller = vc
            return vc
        } else {
            let vc = MainViewController(interactor: interactor)
            presenter.controller = vc
            return vc
        }
    }
}

