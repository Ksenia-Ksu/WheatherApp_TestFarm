//
//  SearchInteractor.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

protocol SearchInteractorProtocol: AnyObject {
    func loadItems()
    func deleteItem(city: String)
    func addCity(city: String)
}

final class SearchInteractor: SearchInteractorProtocol {
    
    private let userDefaults: UserDefaultsStorageProtocol
    
    private let presenter: SearchPresenterProtocol
    private let storage: CoreDataStorageServicing
   
    
    init(presenter: SearchPresenterProtocol, storage: CoreDataStorageServicing, userDefaults: UserDefaultsStorageProtocol ) {
        self.presenter = presenter
        self.storage = storage
        self.userDefaults = userDefaults
    }
    
    func addCity(city: String) {
        self.userDefaults.saveLast(city: city)
        let cityModel = CityModel(city: city)
        
        self.storage.performSave { [weak self] context in
            self?.storage.save(cityModel, context: context)
        } completion: { [weak self] result in
            switch result {
            case .success():
                self?.presenter.reloadData()
                break
            case .failure(let error):
              print(error)
            }
        }
    }
    
    
    func loadItems() {
        do {
            let cities = try self.storage.fetchObjects()
            self.presenter.presentList(list: cities)
        } catch {
            self.presenter.presentList(list: [])
            print(error)
        }
    }
    
    func deleteItem(city: String) {
        self.storage.performSave({ [weak self] context in
            do {
                try self?.storage.deleteObject(withName: city, context: context)
            } catch {
                print(error.localizedDescription)
            }
        }, completion: { [weak self] result in
            switch result {
            case .success():
                self?.presenter.reloadData()
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        })

    }
    
}

