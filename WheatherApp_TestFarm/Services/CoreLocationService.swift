//
//  CoreLocation.swift
//  WheatherApp_TestFarm
//
//  Created by Ксения Кобак on 19.08.2024.
//

import Foundation
import CoreLocation

protocol LocationUpdating {
    var delegate: LocationUpdateDelegate? { get set }
    func startLocate()
}

protocol LocationUpdateDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocationCoordinate2D)
}

final class LocationManager: NSObject, LocationUpdating {

    private var locationManager = CLLocationManager()

    weak var delegate: LocationUpdateDelegate?

    // MARK: - Init

    override init() {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }
    
    func startLocate() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            locationManager.stopUpdatingLocation()
            delegate?.didUpdateLocation(location)
        }
    }
}
