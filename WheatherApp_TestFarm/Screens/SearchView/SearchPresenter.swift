//
//  SearchPresenter.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation

protocol SearchPresenterProtocol {
    func presentList(list:[Cities])
    func reloadData()
}

final class SearchPresenter: SearchPresenterProtocol {
    
    weak var controller: DisplayList?
    
    func reloadData() {
        self.controller?.reloadData()
    }
    
    func presentList(list: [Cities]) {
        var cities = [String]()
        for item in list {
            if let name =  item.city {
                cities.append(name)
            }
        }
        self.controller?.displayCachedCities(list: cities)
        
    }
}



