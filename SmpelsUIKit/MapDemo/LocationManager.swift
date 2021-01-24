//
//  LocationManager.swift
//  Samples
//
//  Created by Tal Spektor on 19/01/2021.
//  Copyright © 2021 Tal Spektor. All rights reserved.
//
import CoreLocation
import Foundation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping (CLLocation) -> Void) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.stopUpdatingLocation()
    }
    
    public func resulveLocationName(with location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geoCodder = CLGeocoder()
        geoCodder.reverseGeocodeLocation(location, preferredLocale: .current) { (placeMarks, error) in
            guard let place = placeMarks?.first, error == nil else {
                completion(nil)
                return
            }
            
            print(place)
            var name = ""
            
            if let locality = place.locality {
                name += locality
            }
            if let administrativeArea = place.administrativeArea {
                name += ", \(administrativeArea)"
            }
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        completion?(location)
        manager.stopUpdatingLocation()
    }
}
