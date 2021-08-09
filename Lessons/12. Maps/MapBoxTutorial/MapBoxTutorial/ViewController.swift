//
//  ViewController.swift
//  MapBoxTutorial
//
//  Created by Alexander on 08.08.2021.
//

import UIKit
import Mapbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Прежде чем начинать работать, в info.plist мы добавили ключ, который был сгенерирован на официальном сайте mapbox.
        // Это не единственное, что необходимо сделать перед запуском, подробнее см документацию:
        // https://docs.mapbox.com/ios/maps/guides/install/
        
        // Создали урл стиля, который мы хотим подгрузить:
        let url = URL(string: "mapbox://styles/alexdneprin/cks30h73j3r4217p7l8nf3d7d")
        
        // Создали карту, передав в init-е ее frame и урл стиля:
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        
        // Задали расположение карты на екране через авторесазинг-маски:
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Задали область которую мы хотим увидеть на карте:
        mapView.setCenter(CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), zoomLevel: 9, animated: false)
        
        // Добавили карту на view (проперти любого UIViewController)
        view.addSubview(mapView)
    }


}

