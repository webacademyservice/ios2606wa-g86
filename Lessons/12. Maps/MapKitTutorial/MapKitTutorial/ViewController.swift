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
        
        // Базовая настройка карты:
        self.setupMap()
        
        // Добавляем аннотацию:
        self.addAnnotations()
        
        // Проверяем доступ к локации пользователя:
        self.checkLocationServices()
        
        // Регистрируем кастомный класс аннотации:
        self.mapView.register(LocationAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    private func setupMap() {
        // Настраиваем карту: начальная позиция, тип, отображение компаса, отображение масштаба
        let coordinate = CLLocation(latitude: 50.43041827068913, longitude: 30.522421225338896)
        self.mapView.centerToLocation(coordinate, regionRadius: 500)
        self.mapView.mapType = .hybrid
        self.mapView.showsCompass = true
        self.mapView.showsScale = true
    }
    
    private func addAnnotations() {
        // Добавляем аннотации для примера
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 50.43236832745365,
                                                       longitude: 30.517860429243495)
        annotation.title = "Park inn"
        annotation.subtitle = "Это отель для болельщиков"
        self.mapView.addAnnotation(annotation)
        
        let annotationUnivercity = MKPointAnnotation()
        annotationUnivercity.coordinate = CLLocationCoordinate2D(latitude: 50.443745383074976,
                                                       longitude: 30.493406541706864)
        self.mapView.addAnnotation(annotationUnivercity)
    }
    
    @IBAction func mapTypeSegmentChanged(_ sender: UISegmentedControl) {
        // Меняем тип карты
        if sender.selectedSegmentIndex == 0 {
            self.mapView.mapType = .hybridFlyover
        } else {
            self.mapView.mapType = .standard
        }
    }
    
    @IBAction func showTableView(_ sender: Any) {
        
        // Пример того как анимировать view над картой по нажатию на кнопку:
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
        // Отображаем Золотые ворота на карте по нажатию на кнопку
        let coordinates = CLLocationCoordinate2D(latitude: 50.448789530649975, longitude: 30.513310441717437)
        let region = MKCoordinateRegion(center: coordinates,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        self.mapView.setRegion(region, animated: true)
    }
    
    // MARK: - Location

    // Проверяем доступность сервисов локации:
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            self.setupLocationManager()
            self.checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization() {
        
        // Обрабатываем "кейсы" доступов приложения к карте:
        
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
    
    // Показываем позицию пользователя на карте:
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

// Метод вызывается для каждой конкретной аннотации. Создаем MKAnnotationView

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier,
                                                                   for: annotation)
        return annotationView
    }
    
}

// Метод написанный в расширении центрирует карту к области:

private extension MKMapView {
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

// Создаем кастомный класс для отображения аннотаций:

final class LocationAnnotationView: MKAnnotationView {

    // MARK: Initialization

    override init(annotation: MKAnnotation?,
                  reuseIdentifier: String?) {

        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)

        canShowCallout = true
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setupUI() {

        backgroundColor = .white
        
        let customView = CustomView()
        self.addSubview(customView)
        customView.frame = frame
    }
}
