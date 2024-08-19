//
//  SearchViewController.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func openWeather(of city: String)
}

protocol DisplayList: AnyObject {
    func displayCachedCities(list: [String])
    func reloadData()
}

class SearchViewController: UIViewController {
    
    var viewModels: [String] = []
    
    lazy var contentView: SearcBarHandleProtocol = SearchView(cities: viewModels, delegate: self, searchBarDelegate: self)
    
    private var interactor: SearchInteractorProtocol
    
    override func loadView() {
        self.view = contentView
    }
    
    init(interactor: SearchInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.loadItems()
    }
}

extension SearchViewController: CellActionHandleProtocol {
    func deleteCity(city: String) {
        self.interactor.deleteItem(city: city)
    }
    
    func showWheather(city: String) {
        let vc = MainModuleBuilder().build(context: city)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        contentView.searchBarIsCanceled()
    }
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.contentView.searchBarIsTapped(city: text.firstCharUppercased())
            self.interactor.addCity(city: text)
        }
    }
 
}

extension SearchViewController: DisplayList {
    func reloadData() {
        self.contentView.reloadData()
    }
    
    func displayCachedCities(list: [String]) {
        self.contentView.configureView(list: list)
    }
}

