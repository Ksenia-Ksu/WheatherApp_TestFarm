//
//  SearchModuleBuilder.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import UIKit

public struct SearchModuleBuilder {
    func build() -> UIViewController {
        let presenter = SearchPresenter()
        let storage = CoreDataStorageService.shared
        let userdefaults = UserDefaultsStorageService()
        let interactor = SearchInteractor(presenter: presenter, storage: storage, userDefaults: userdefaults)
        let vc = SearchViewController(interactor: interactor)
        presenter.controller = vc
        return vc
    }
}
