//
//  MapVC.swift
//  Samples
//
//  Created by Tal Spektor on 19/01/2021.
//  Copyright © 2021 Tal Spektor. All rights reserved.
//
import CoreLocation	
import MapKit

class MapVC: UIViewController, BaseVC {
    var topTitle: String {
        return "\(MapVC.self)"
    }
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.addSubview(map)
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.addMapPim(with: location)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    private func addMapPim(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(center: location.coordinate,
                                                    span: MKCoordinateSpan(latitudeDelta: 0.7,
                                                                           longitudeDelta: 0.7)),
                                 animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resulveLocationName(with: location) { [weak self] (locationName) in
            self?.title = locationName
        }
    }
}

