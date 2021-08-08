//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Alexander on 07.08.2021.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var tableViewLeftContraint: NSLayoutConstraint!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMap()
        self.addAnnotation()
        self.checkLocationServices()
    }
    
    private func setupMap() {
        let coordinate = CLLocation(latitude: 50.43041827068913, longitude: 30.522421225338896)
        self.mapView.centerToLocation(coordinate, regionRadius: 500)
        self.mapView.mapType = .hybrid
        self.mapView.showsCompass = true
        self.mapView.showsScale = true
    }
    
    private func addAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 50.43236832745365,
                                                       longitude: 30.517860429243495)
        annotation.title = "Park inn"
        annotation.subtitle = "Это отель для болельщиков"
        self.mapView.addAnnotation(annotation)
    }
    
    @IBAction func mapTypeSegmentChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            self.mapView.mapType = .hybridFlyover
        } else {
            self.mapView.mapType = .standard
        }
        
        
    }
    
    @IBAction func showTableView(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0) {
            self.tableViewLeftContraint.constant = 300
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func showTraficSwitchPressed(_ sender: UISwitch) {
        if sender.isOn {
            self.mapView.showsTraffic = true
        } else {
            self.mapView.showsTraffic = false
        }
    }
    
    @IBAction func showGoldenGateButtonPressed(_ sender: Any) {
        
        let coordinates = CLLocationCoordinate2D(latitude: 50.448789530649975, longitude: 30.513310441717437)
        let region = MKCoordinateRegion(center: coordinates,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        self.mapView.setRegion(region, animated: true)
    }
    
    // MARK: - Location
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            self.setupLocationManager()
            self.checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            self.centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
}

extension ViewController: MKMapViewDelegate {
    
}

private extension MKMapView {
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
