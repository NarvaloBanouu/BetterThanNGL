//
//  LocationManager.swift
//  BetterthanNGL
//
//  Lightweight location helper using CoreLocation
//

import Foundation
import Combine
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var authorization: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            manager.requestWhenInUseAuthorization()
            manager.requestLocation()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: ", error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorization = status
    }
}
