//
//  MainWeatherViewController.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import UIKit

protocol DisplayWheather: AnyObject {
    func displayFetchedModels(_ viewModel: [WeatherModel])
    func displayError(error: String)
}

final class MainViewController: UIViewController {
    
    private lazy var contentView: DisplaysWeather = CityWeatherView(weatherData: [])
    private var interactor: WeatherInteractorProtocol
    private var openWithCity: String?
    
    init (interactor: WeatherInteractorProtocol, openWithCity: String?) {
        self.interactor = interactor
        self.openWithCity = openWithCity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let city = openWithCity {
            contentView.startLoading()
            self.interactor.fetchWeatherWithCity(name: city)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
        self.interactor.fetchWeatherWithCity(name: "moscow".localized)
    }
    // MARK: - navBarSetup
    private func navBarSetup() {
        
        let rightButton = UIBarButtonItem(image: UIImage(systemName: SFSymbols.search ), style: .plain, target: self, action: #selector(openSearch(sender:)))
        rightButton.tintColor = Colors.text
        navigationItem.rightBarButtonItem = rightButton
        
        let left = UIBarButtonItem(image: UIImage(systemName: SFSymbols.localeSettings), style: .plain, target: self, action: #selector(changeLanguage))
        left.tintColor = Colors.text

        navigationItem.leftBarButtonItem = left
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func changeLanguage() {
        self.interactor.changeLanguage()
    }
    
    @objc func openSearch(sender: UIBarButtonItem) {
        let vc = SearchModuleBuilder().build()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - DisplayModels

extension MainViewController: DisplayWheather {
    func displayError(error: String) {
        self.contentView.displayError(error: error)
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



