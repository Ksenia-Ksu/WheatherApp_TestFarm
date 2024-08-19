//
//  MainWeatherViewController.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import UIKit

protocol DisplayWheather: AnyObject {
    func displayFetchedModels(_ viewModel: [WeatherModel])
    func displayError()
}

final class MainViewController: UIViewController {
    
    private lazy var contentView: DisplaysWeather = CityWeatherView(weatherData: [])
    private var interactor: WeatherInteractorProtocol
    
    init (interactor: WeatherInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if let city = openWithCity {
//            contentView.startLoading()
//            self.interactor.fetchWeatherWithCity(name: city, language: <#Language#>)
//        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        self.interactor.fetchWeatherWithCity(name: "Москва", language: .ru)
    }
    // MARK: - navBarSetup
    private func navBarSetup() {
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.search ), style: .plain, target: self, action: #selector(openSearch(sender:)))
        rightButton.tintColor = Colors.text
        navigationItem.rightBarButtonItem = rightButton
        
        let left = UIBarButtonItem(image: UIImage(systemName: SFSymbols.localeSettings))
        left.tintColor = Colors.text
        left.menu = menuLanguageSelection
        navigationItem.leftBarButtonItem = left
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private lazy var menuLanguageSelection: UIMenu = {
        let english = UIAction(title: "en") { _ in
            // setup interactor
        }
        
        let russin = UIAction(title: "ru") { _ in
            // setup interactor
        }
        
        let menu = UIMenu(title: "Выберите язык", children: [english, russin])
        
        return menu
    }()
    
    @objc func openSearch(sender: UIBarButtonItem) {
        
    }
    
}

// MARK: - DisplayModels

extension MainViewController: DisplayWheather {
    func displayError() {
        self.contentView.displayError()
    }
    
    func displayCachedModels(_ viewModel: [WeatherModel]) {
        self.contentView.configure(with: viewModel)
        self.contentView.stopLoading()
    }
    
    func displayFetchedModels(_ viewModel: [WeatherModel]) {
        self.contentView.configure(with: viewModel)
        self.contentView.stopLoading()
    }
}



