//
//  ViewController.swift
//  GoogleMapsTutorial
//
//  Created by Alexander on 08.08.2021.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавили ключ, сгенерированный в google аккаунте:
        
        GMSServices.provideAPIKey("AIzaSyD2Dyyfg_x6REp-8rF4a9y2AhjWccjqSzI")

        // Создали камеру - область что будет отображена на карте
        let camera = GMSCameraPosition.camera(withLatitude: 50.433877515202965, longitude: 30.518900167504952, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        // Настроили карту: тип, трафик, отображение локации пользователя
        mapView.mapType = .hybrid
        mapView.isTrafficEnabled = true
        mapView.isMyLocationEnabled = true

        // Задали view значение нашей карты. View - стандартная проперти UIViewController
        view = mapView

        // Создали маркер и задали ему параметры:
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }


}

