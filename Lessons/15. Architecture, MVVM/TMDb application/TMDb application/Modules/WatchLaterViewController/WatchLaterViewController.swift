//
//  WatchLaterViewController.swift
//  TMDb application
//
//  Created by Alexander on 01.08.2021.
//

import UIKit
import RealmSwift

class WatchLaterViewController: UIViewController {
    
    // Создаем объект реалм
    let realm = try? Realm()
    
    var movies: [MovieRealm] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.title = Constants.viewControllerTitles.watchLater
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  Когда view отобразилась, вытаскиваем из realm фильмы и перезагружаем tableView:
        self.movies = self.getMovies()
        self.tableView.reloadData()
    }
    
    private func getMovies() -> [MovieRealm] {

        var movies = [MovieRealm]()
        guard let citiesResults = realm?.objects(MovieRealm.self) else { return [] }
        for movie in citiesResults {
            movies.append(movie)
        }
        return movies
    }
}

extension WatchLaterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let sizeOfHugeCell = 120
//        let sizeOfSmallCell = 20
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.movies[indexPath.row].title
        
//        if cellIsHuge {
//            cell.configure(with: title, height: sizeOfHugeCell)
//        } esle{
//            cell.configure(with: title, height: sizeOfSmallCell)
//        }
        return cell ?? UITableViewCell()
    }
}


// Или проблемма решается использованием наследования, или с помощью композиции.

protocol Bird {
    func setLocation(longitude: Double , latitude: Double)
}

protocol Fly {
    var altitudeToFly: Double? {get}
    mutating func setAltitude(altitude: Double)
}

protocol FlyingBird: Bird, Fly { }

class Eagle: FlyingBird {
    
    var altitudeToFly: Double?
    
    func setLocation(longitude: Double, latitude: Double) {
        //
    }
    
    func setAltitude(altitude: Double) {
        //
    }
    
}

class Penguin: Bird {
    
    func setLocation(longitude: Double, latitude: Double) {
        //
    }
}

//class Bird {
//
//    var altitudeToFly: Double = 0
//
//    func setLocation(longitude: Double , latitude: Double) {
//
//    }
//
//    func setAltitude(altitude: Double) {
//        self.altitudeToFly = altitude
//    }
//
//}
//
//class Eagle: Bird {
//
//    func setup() {
//        self.altitudeToFly = 10
//    }
//
//    override func setLocation(longitude: Double, latitude: Double) {
//        //
//    }
//
//    override func setAltitude(altitude: Double) {
//        self.altitudeToFly = altitude
//    }
//
//}
//
//class Penguin: Bird {
//
//    func setup() {
//        self.altitudeToFly = 10
//    }
//
//    override func setLocation(longitude: Double, latitude: Double) {
//        //
//    }
//
//    override func setAltitude(altitude: Double) { }
//}

class ViewModel {
    
    var networkMeneger: NetworkManagerProtocol
    
    init(networkMeneger: NetworkManagerProtocol) {
        self.networkMeneger = networkMeneger
    }
    
    public func setupViewModel() {
        self.networkMeneger.loadListOfData()
    }
}

protocol NetworkManagerProtocol {
    func loadListOfData()
}

struct NetworkManagerC: NetworkManagerProtocol {
    func loadListOfData() {
        //
    }
}
